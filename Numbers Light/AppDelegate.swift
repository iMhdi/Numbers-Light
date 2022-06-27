//
//  AppDelegate.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 25/06/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window                          =   UIWindow(frame: UIScreen.main.bounds)
        
        
        let appContainer = DIContainer()
        appContainer.registerDependencies()
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            let appNavigator = AppNavigator.startiPhoneApp(withDIContainer: appContainer)
            window?.rootViewController = appNavigator
        } else {
            let appNavigator = AppNavigator.startiPadApp(withDIContainer: appContainer)
            window?.rootViewController = appNavigator
        }
        
        window?.makeKeyAndVisible()

        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .allButUpsideDown
        }
    }
}
