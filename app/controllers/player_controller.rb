class PlayerController

  attr_accessor :player_manager

  def key_event key_type
    case key_type
    when :space
      control_player :pause_or_resume
    when :left
      control_player :fast_forward, { sec: -10 }
    when :right
      control_player :fast_forward, { sec: 10 }
    when :down
      control_player :fast_forward, { sec: -60 }
    when :up
      control_player :fast_forward, { sec: 60 }
    end
  end

  private
  def control_player method_type, options = {}
    case method_type
    when :pause_or_resume
      player_manager.pause_or_resume
    when :fast_forward
      player_manager.fast_forward options[:sec]
    end
  end

end
