class PlayerController

  attr_accessor :player_manager

  def key_event key_type
    case key_type
    when :comma
      control_player :back

      showPanelView
    when :dot
      control_player :next

      showPanelView
    when :space
      control_player :pause_or_resume

      showPanelView
    when :left
      control_player :fast_forward, { sec: -10 }

      showPanelView
    when :right
      control_player :fast_forward, { sec: 10 }

      showPanelView
    when :down
      control_player :fast_forward, { sec: -60 }

      showPanelView
    when :up
      control_player :fast_forward, { sec: 60 }

      showPanelView
    end
  end

  def play
    player_manager.play

    showPanelView
  end

  private
  def showPanelView
    if @view
      @view.restart_animation
    else
      buildPanelView
      @view.start_animation
    end
  end

  def buildPanelView
    @view = PanelView.alloc.initWithFrame CGRectMake(0, 0, 480, 100)
    @view.player_manager = self.player_manager
    @view.buildSubViews

    frame = app.window.contentRectForFrameRect @view.frame, styleMask: app.window.styleMask
    frame.origin.x = app.window.frame.origin.x
    frame.origin.y = app.window.frame.origin.y

    app.window.setFrame frame, display: true, animate: false

    app.window.contentView.addSubview @view
  end

  def control_player method_type, options = {}
    case method_type
    when :back
      player_manager.back
    when :next
      player_manager.next
    when :pause_or_resume
      player_manager.pause_or_resume
    when :fast_forward
      player_manager.fast_forward options[:sec]
    end
  end

  def app
    NSApp.delegate
  end

end
