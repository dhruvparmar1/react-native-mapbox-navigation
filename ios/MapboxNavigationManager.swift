@objc(MapboxNavigationManager)
class MapboxNavigationManager: RCTViewManager {

  override func view() -> UIView! {
    return MapboxNavigation()
  }

  @objc override static func requiresMainQueueSetup() -> Bool {
    return false
  }
}