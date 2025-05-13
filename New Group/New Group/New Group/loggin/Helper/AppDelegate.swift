import SwiftUI
import FirebaseCore
import GoogleSignIn
import FacebookCore

class AppDelegate : NSObject , UIApplicationDelegate {
  func application ( _ application : UIApplication ,
                   didFinishLaunchingWithOptions launchOptions : [ UIApplication . LaunchOptionsKey : Any ]? = nil ) -> Bool {
    FirebaseApp.configure ( )
      ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    return true
  }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app,open: url,sourceApplication: options[.sourceApplication] as? String, annotation: options[.annotation])
    }
}
