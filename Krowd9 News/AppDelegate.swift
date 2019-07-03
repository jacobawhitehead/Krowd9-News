//
//  AppDelegate.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 02/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  var coordinator: Coordinator?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let mainCoordinator = MainCoordinator(navigationController: UINavigationController(), networkService: NetworkService())
    mainCoordinator.start()

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = mainCoordinator.navigationController
    window?.makeKeyAndVisible()

    coordinator = mainCoordinator

    return true
  }
  
}

