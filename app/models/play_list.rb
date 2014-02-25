class PlayList

  def initialize_from filenames
    file_manager = NSFileManager.defaultManager

    filenames.each do |filename|
      files << filename if file_manager.fileExistsAtPath(filename)
    end
  end

  def next
    increment_position

    begin
      file = files.fetch(current_position)
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
    return nil if @position.nil?

    @position += 1
    reset_position if files.size <= current_position

    @position
  end

  def reset_position
    @position = 0
  end

  def files
    @files ||= []
  end

end
