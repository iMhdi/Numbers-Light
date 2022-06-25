//
//  AppNavigator.swift
//  Numbers Light
//
//  Created by El Mahdi Boukhris on 25/06/2022.
//

import UIKit

enum Destination {
    case home
    case details
}

enum ViewControllerPresentationStyle {
    case root
    case push
    case present
}

class AppNavigator: UINavigationController, Navigator {
    
    var appContainer: DIContainer?
    
    // MARK: - Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        configureNavBarAppearanceIfNecessary()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func startApp(withDIContainer container: DIContainer) -> AppNavigator {
        guard let homeController: HomeViewController = container.defaultContainer.resolve(HomeViewController.self) else {
            fatalError("unable to launch the app")
        }

        let navigationController = AppNavigator(rootViewController: homeController)
        navigationController.appContainer = container
        return navigationController
    }
    
    // MARK: - Navigator
    func navigate(to destination: Destination, withStyle presentationStyle: ViewControllerPresentationStyle, andData dataDictionary:[String:Any?]? = nil) {
        let viewController = ControllerFactory.newInstance(for: destination, withContainer: appContainer!, andData: dataDictionary)
        
        switch presentationStyle {
        case .push:
            push(viewController: viewController)
            break
        case .present:
            let navController = AppNavigator(rootViewController: viewController)
            present(viewController: navController)
            break
        case .root:
            changeRoot(viewController: viewController)
            break
        }
    }
    
    private func present(viewController:UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    private func push(viewController:UIViewController) {
        pushViewController(viewController, animated: true)
    }
    
    private func changeRoot(viewController:UIViewController) {
        setViewControllers([viewController], animated: true)
    }
    
    func configureNavBarAppearanceIfNecessary() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        navBarAppearance.backgroundColor = .black

        // Disable translucent bar
        UINavigationBar.appearance().isTranslucent = false
        
        // Set tab bar title style
        var navigationBarTitleAttributes:[NSAttributedString.Key :Any] = [:]
        navigationBarTitleAttributes[.foregroundColor] = UIColor.white
        navBarAppearance.titleTextAttributes = navigationBarTitleAttributes
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}
