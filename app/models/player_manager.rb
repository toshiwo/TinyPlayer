class PlayerManager

  attr_accessor :files

  def stop
    sound.stop
  end

  def play
    play_next
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

  def sound
    @sound
  end

  def make_sound file
    @sound = NSSound.alloc.initWithContentsOfFile file, byReference: false
    @sound.setDelegate self
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
