//
//  AppDelegate.swift
//  HammerTest
//
//  Created by Филипп Гурин on 09.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let menuViewController = MenuViewController()
        let contactsViewController = UIViewController()
        let accountViewController = UIViewController()
        let orderViewController = UIViewController()
        
        let menuNavigationController = UINavigationController(rootViewController: menuViewController)
        let contactsNavigationController = UINavigationController(rootViewController: contactsViewController)
        let accountNavigationController = UINavigationController(rootViewController: accountViewController)
        let orderNavigationController = UINavigationController(rootViewController: orderViewController)
        
        menuNavigationController.title = "Меню"
        menuNavigationController.tabBarItem.image = UIImage(systemName: "pencil")
        contactsNavigationController.title = "Контакты"
        accountNavigationController.title = "Профиль"
        orderNavigationController.title = "Корзина"
        
        let mainTabBarController = UITabBarController()
        mainTabBarController.tabBar.tintColor = .red
        mainTabBarController.viewControllers = [menuNavigationController, contactsNavigationController, accountNavigationController, orderNavigationController]
        
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainTabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

}

