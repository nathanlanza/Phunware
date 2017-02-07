import UIKit
import Hero

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
//    HeroDebugPlugin.isEnabled = true
    
    window = UIWindow()
    let m = MainViewController()
    m.title = "PHUN APP"
    let n = UINavigationController(rootViewController: m)
    n.isHeroEnabled = true
    window?.rootViewController = n
    window?.makeKeyAndVisible()
    
    return true
  }
}

