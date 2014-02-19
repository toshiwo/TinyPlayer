class PlayList

  def initialize_from filenames
    file_manager = NSFileManager.defaultManager

    filenames.each do |filename|
      files << filename if file_manager.fileExistsAtPath(filename)
    end
  end

  def next
    reset_position if files.size <= current_position

    begin
      file = files.fetch(current_position)
      increment_position
    rescue IndexError => e
      file = nil
    end

    file
  end

  private

  def current_position
    @position ||= 0
  end

  def increment_position
    @position += 1
  end

  def reset_position
    @position = 0
  end

  def files
    @files ||= []
  end

end
