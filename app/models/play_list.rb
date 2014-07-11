class PlayList

  def initialize_from filenames
    file_manager = NSFileManager.defaultManager

    filenames.each do |filename|
      files << filename if file_manager.fileExistsAtPath(filename)
    end
  end

  def previous
    decrement_position

    file = files.fetch(current_position)
  end

  def next
    increment_position

    current_file
  end

  def current_file
    begin
      files.fetch(current_position)
    rescue IndexError => e
      nil
    end
  end

  private

  def current_position
    @position ||= 0
  end

  def decrement_position
    @position = current_position - 1

    if current_position < 0
      @position = files.empty? ? reset_position : (files.size - 1)
    end

    @position
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
