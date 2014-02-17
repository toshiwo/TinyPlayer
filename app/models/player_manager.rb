class PlayerManager

  attr_accessor :files

  def stop
    sound.stop
  end

  def play
    play_next
  end

  def pause_or_resume
    return nil unless sound

    is_pausing? ? resume : pause
  end

  def fast_forward sec
    return nil unless is_playing?

    current_time = sound.currentTime
    if (sound.currentTime + sec) < 0
    elsif sound.duration < (sound.currentTime + sec)
    else
      sound.setCurrentTime (sound.currentTime + sec)
    end
  end

  private

  def play_next
    return false if @files.empty?

    begin
      file = @files.fetch(current_index)
    rescue IndexError => e
      reset_index

      file = @files.fetch(current_index)
    end

    make_sound file

    @index += 1 if result = sound.play

    result
  end

  def current_index
    @index ||= 0
  end

  def reset_index
    @index = 0
  end

  def pause
    @is_pausing = true
    sound.pause
  end

  def resume
    @is_pausing = false
    sound.resume
  end

  def is_pausing?
    @is_pausing
  end

  def sound
    @sound
  end

  def make_sound file
    @sound = NSSound.alloc.initWithContentsOfFile file, byReference: false
    @sound.setDelegate self

    @is_pausing = false
  end

  def is_playing?
    sound.isPlaying
  end

  def sound sound, didFinishPlaying:finishedPlaying
    sound.stop if sound.isPlaying == 1

    return true unless finishedPlaying

    play_next
  end

end
