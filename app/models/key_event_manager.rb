class KeyEventManager < NSResponder

  attr_accessor :controller

  private

  def keyUp event
  end

  def keyDown event
    case event.keyCode
    when 49 # space
      controller.key_event :space
    when 123 # left
      controller.key_event :left
    when 124 # right
      controller.key_event :right
    when 125 # down
      controller.key_event :down
    when 126 # up
      controller.key_event :up
    end
  end

  def flagsChanged event
  end

end
