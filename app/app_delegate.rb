class TinyWindow < NSWindow
  def canBecomeKeyWindow; true; end
end

class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow
  end

  def buildWindow
    @mainWindow = TinyWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']

    initialize_firest_responder

    @mainWindow.orderFrontRegardless
  end

  def initialize_firest_responder
    @key_event_manager = KeyEventManager.new
    @mainWindow.makeFirstResponder @key_event_manager
  end
  private :initialize_firest_responder

end
