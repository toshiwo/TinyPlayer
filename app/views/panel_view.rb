class NSAnimationWithRedraw < NSAnimation
  def setCurrentProgress progress
    super

    self.delegate.redraw progress
  end
end

class PanelView < NSView

  LabelTags = {
    title: 0,
    time: 1,
  }

  attr_accessor :player_manager

  def drawRect dirtyRect
    refresh_title
    refresh_current_time
  end

  def redraw progress
    refresh_title
    refresh_current_time

    self.setAlphaValue (1.0 - progress)
  end

  def stop_and_start_animation
    stop_animation
    start_animation
  end
  alias :restart_animation :stop_and_start_animation

  def stop_animation
    animation.stopAnimation
  end

  def start_animation
    animation.setCurrentProgress 0

    refresh_title
    refresh_current_time
    self.setAlphaValue 1.0

    animation.startAnimation
  end

  def buildSubViews
    self.setWantsLayer true
    self.layer.backgroundColor = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)
    self.layer.cornerRadius = 10.0

    self.addSubview buildTitleLabel
    self.addSubview buildTimeLabel
  end

  private
  def refresh_title
    label = self.viewWithTag LabelTags[:title]
    label.setStringValue title
  end

  def refresh_current_time
    label = self.viewWithTag LabelTags[:time]
    label.setStringValue current_and_duration_time
  end

  def buildTitleLabel
    # https://developer.apple.com/library/mac/documentation/cocoa/reference/applicationkit/classes/NSTextField_Class/Reference/Reference.html
    label = NSTextField.alloc.initWithFrame CGRectMake(10, self.frame.size.height - (18 + 5), self.frame.size.width - 20, 18)
    label.setTextColor NSColor.whiteColor
    label.tag = LabelTags[:title]

    # http://stackoverflow.com/questions/11120654/nstextfield-transparent-background
    label.editable = false
    label.bezeled = false
    label.drawsBackground = false

    label
  end

  def buildTimeLabel
    label = NSTextField.alloc.initWithFrame CGRectMake(10, self.frame.size.height - (18 + (18 + 5)), self.frame.size.width - 20, 18)
    label.setTextColor NSColor.whiteColor
    label.tag = LabelTags[:time]

    label.editable = false
    label.bezeled = false
    label.drawsBackground = false

    label
  end

  def animation
    return @animation if @animation

    @animation = NSAnimationWithRedraw .alloc.initWithDuration 3.0, animationCurve: NSAnimationEaseIn

    @animation.setAnimationBlockingMode NSAnimationNonblocking
    @animation.setDelegate self

    @animation
  end

  def title
    player_manager.current_file.lastPathComponent
  end

  def current_and_duration_time
    duration_time = player_manager.duration_time
    current_time = player_manager.current_time

    duration_time_str = sprintf "%3d:%02d",
      (duration_time / 60), (duration_time % 60)
    current_time_str = sprintf "%3d:%02d",
      (current_time / 60), (current_time % 60)

    "#{ current_time_str } / #{ duration_time_str }"
  end

end
