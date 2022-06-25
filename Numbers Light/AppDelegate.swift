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
    var appNavigator:AppNavigator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window                          =   UIWindow(frame: UIScreen.main.bounds)
        
        
        let appContainer = DIContainer()
        appContainer.registerDependencies()
        
        appNavigator                    =   AppNavigator.startApp(withDIContainer: appContainer)
        window?.rootViewController      =   appNavigator
        
        window?.makeKeyAndVisible()

        return true
    }
}
