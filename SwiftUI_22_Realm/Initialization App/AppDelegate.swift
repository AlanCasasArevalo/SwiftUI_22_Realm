
import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //VERSION 0
        /* En la version 0 solo teniamos Person que se compone de id, nombre y edad
         @objc dynamic var id = UUID().uuidString
         @objc dynamic var name = ""
         @objc dynamic var age = 0
         */
        
        //VERSION 1
        /*
         En la version 1 le hemos puesto una relacion entre personas y mascotas
         */
        let config = Realm.Configuration (
            schemaVersion: 1, migrationBlock: { (migration, oldVersion) in
                if oldVersion < 1 {
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        
        
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

