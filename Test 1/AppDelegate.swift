//
//  AppDelegate.swift
//  Test 1
//
//  Created by Nazar Lykashik on 25.07.22.
//

import UIKit
 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 
  var window: UIWindow?
  // 1
  let googleMapsApiKey = "AIzaSyD2kzbXMqCIxtzbH_Ujj1VkdwYa6x8DrOc"
 
  func application(application: UIApplication, didFinishLaunchingWithOptions
      launchOptions: [NSObject: AnyObject]?) -> Bool {
    // 2
    GMSServices.provideAPIKey(googleMapsApiKey)
    return true
  }
}

