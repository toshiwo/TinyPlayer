class PlayerController

  attr_accessor :player_manager

  def key_event key_type
    case key_type
    when :comma
      control_player :back
    when :dot
      control_player :next
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

  def play
    player_manager.play
  end

  private
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

end
