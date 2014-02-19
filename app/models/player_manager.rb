class PlayerManager

  def files= filenames
    play_list.initialize_from filenames
  end

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

  def next
    stop if is_playing?

    play_next
  end

  private

  def play_next
    return nil unless file = play_list.next

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
    sound.isPlaying
  end

  def sound sound, didFinishPlaying:finishedPlaying
    sound.stop if sound.isPlaying == 1

    return true unless finishedPlaying

    play_next
  end

end
