//
//  WarningManager.swift
//  EScooters
//
//  Created by Sasi Moorthy on 25/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import UIKit

class WarningManager: NSObject {
    
    class func createAndPushWarning(message: String, cancel: String) {
        let alertControl = WarningManager.createAlertControl(message: message)
        alertControl.addAction(UIAlertAction(title: cancel, style: .default, handler: nil))
        self.displayAlertControl(alert: alertControl)
    }
    
    class func createAndPushWarning(message: String, buttons : [(title: String, callBack:(() -> Void)?)]?) {  // cancel button has to be sent in tuple
        let alertControl = WarningManager.createAlertControl(message: message)
        if (buttons != nil) {
            for item in buttons! {
                alertControl.addAction(UIAlertAction(title: item.title, style: .default, handler: { (action) in
                    if (item.callBack != nil) {
                        item.callBack!()
                    }
                }))
            }
        }
        self.displayAlertControl(alert: alertControl)
    }
    
    //Mark: Private Methods
    
    private class func createAlertControl(message: String) -> UIAlertController {
        return UIAlertController.init(title: NSLocalizedString("Flash", comment: ""), message: message, preferredStyle: .alert)
    }
    
    private class func displayAlertControl(alert: UIAlertController) {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindow.Level.alert + 1
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
