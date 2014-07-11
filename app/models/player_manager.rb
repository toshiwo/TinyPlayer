class PlayerManager

  def files= filenames
    play_list.initialize_with filenames
  end

  def stop
    sound.stop if sound
  end

  def play
    self.next
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

  def back
    return nil unless file = play_list.previous

    play_sound file
  end

  def next
    return nil unless file = play_list.next

    play_sound file
  end

  def current_file
    play_list.current_file
  end

  def current_time
    sound.currentTime
  end

  def duration_time
    sound.duration
  end

  private

  def play_sound file
    stop if is_playing?

    make_sound file
    sound.play
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

  def play_list
    @play_list ||= PlayList.new
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
    return false unless sound

    sound.isPlaying
  end

  def sound sound, didFinishPlaying:finishedPlaying
    sound.stop if sound.isPlaying == 1

    return true unless finishedPlaying

    self.next
  end

end
