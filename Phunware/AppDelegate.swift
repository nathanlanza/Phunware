import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let m = MainViewController(collectionViewLayout: UICollectionViewFlowLayout())
        m.useLayoutToLayoutNavigationTransitions = false
        m.title = "PHUN APP"
        let n = UINavigationController(rootViewController: m)
        window?.rootViewController = n
        window?.makeKeyAndVisible()
        
        return true
    }
}

