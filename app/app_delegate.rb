class TinyWindow < NSWindow
  def canBecomeKeyWindow; true; end
end

class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow
  end

  def applicationWillTerminate application
    @controller.player_manager.stop
  end

  def buildWindow
    @mainWindow = TinyWindow.alloc.initWithContentRect([[0, 0], [480, 360]],
      styleMask: NSBorderlessWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.setBackgroundColor NSColor.clearColor
    @mainWindow.setOpaque false

    @mainWindow.center
    window_position = @mainWindow.frame.origin
    @mainWindow.setFrameOrigin NSMakePoint(window_position.x, 180)

    @controller = PlayerController.new
    initialize_firest_responder @controller

    player_manager = PlayerManager.new
    player_manager.files = @files ||= []
    @controller.player_manager = player_manager
    @controller.play

    @mainWindow.orderFrontRegardless
  end

  def window
    @mainWindow
  end

  def application sender, openFiles:filenames
    file_manager = NSFileManager.defaultManager

    @files = filenames.map do |filename|
      file_manager.fileExistsAtPath(filename) ? filename : nil
    end.compact
  end

  def initialize_firest_responder controller
    @key_event_manager = KeyEventManager.new
    @key_event_manager.controller = controller
    @mainWindow.makeFirstResponder @key_event_manager
  end
  private :initialize_firest_responder

end
