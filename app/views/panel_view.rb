class PanelView < NSView

  attr_accessor :player_manager

  def drawRect dirtyRect
    refresh_title
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
    self.setAlphaValue 1.0
    self.setHidden false

    animation.startAnimation
  end

  def buildSubViews
    self.setWantsLayer true
    self.layer.backgroundColor = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.4)
    self.layer.cornerRadius = 10.0

    self.addSubview buildTitleLabel
  end

  private
  def refresh_title
    label = self.subviews.first
    label.setStringValue title
  end

  def buildTitleLabel
    # https://developer.apple.com/library/mac/documentation/cocoa/reference/applicationkit/classes/NSTextField_Class/Reference/Reference.html
    label = NSTextField.alloc.initWithFrame CGRectMake(10, self.frame.size.height - 15, self.frame.size.width - 20, 15)
    label.setTextColor NSColor.whiteColor

    # http://stackoverflow.com/questions/11120654/nstextfield-transparent-background
    label.editable = false
    label.bezeled = false
    label.drawsBackground = false

    label
  end

  def animation
    return @animation if @animation

    dictionary = NSMutableDictionary.dictionary
    dictionary.setObject self, forKey:NSViewAnimationTargetKey
    dictionary.setObject NSViewAnimationFadeOutEffect, forKey:NSViewAnimationEffectKey

    animation_params = NSArray.arrayWithObject dictionary

    @animation = NSViewAnimation.alloc.initWithViewAnimations animation_params
    @animation.setDuration 3.0
    @animation.setAnimationCurve NSAnimationEaseIn
    @animation.setDelegate self
  end

  def title
    player_manager.current_file.lastPathComponent
  end

end
