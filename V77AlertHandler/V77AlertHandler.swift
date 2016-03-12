//
//  V77AlertHandler.swift
//  V77AlertHandler
//
//  Created by Paul Kite on 3/11/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

import UIKit
import ObjectiveC

typealias V77AlertTextFieldHandler = ((UITextField) -> Void)

extension UIAlertController {
    private struct AssociatedKeys {
        static var displayWindowKey = "displayWindowKey"
    }
    
    private func displayWindow() -> UIWindow? {
        return objc_getAssociatedObject(self, &AssociatedKeys.displayWindowKey) as? UIWindow
    }
    
    private func setDisplayWindow(window: UIWindow?) {
        objc_setAssociatedObject(self, &AssociatedKeys.displayWindowKey, window, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    private func displayAnimated(animated animated: Bool, completion: (() -> Void)?) {
        self.setDisplayWindow(UIWindow(frame: UIScreen.mainScreen().bounds))
        
        self.displayWindow()?.rootViewController = UIViewController(nibName: nil, bundle: nil)
        self.displayWindow()?.windowLevel = (UIWindowLevelAlert + 1.0)
        
        self.displayWindow()?.makeKeyAndVisible()
        self.displayWindow()?.rootViewController?.presentViewController(self, animated: animated, completion: completion)
    }
    
    override public func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.setDisplayWindow(nil)
    }
}

class V77AlertHandler: NSObject {
    class func displayActionSheet(title title: String?, message: String?, actions: [UIAlertAction]? = nil, tintColor: UIColor? = nil) -> UIAlertController? {
        return self.display(
            title: title,
            message: message,
            alertStyle: .ActionSheet,
            actions: actions,
            textFieldHandlers: nil,
            tintColor: tintColor
        )
    }
    
    class func displayAlert(title title: String?, message: String?, actions: [UIAlertAction]? = nil, textFieldHandlers: Array<V77AlertTextFieldHandler>? = nil, tintColor: UIColor? = nil) -> UIAlertController? {
        return self.display(
            title: title,
            message: message,
            alertStyle: .Alert,
            actions: actions,
            textFieldHandlers: textFieldHandlers,
            tintColor: tintColor
        )
    }
    
    private class func display(title title: String?, message: String?, alertStyle: UIAlertControllerStyle, actions: [UIAlertAction]?, textFieldHandlers: Array<V77AlertTextFieldHandler>?, tintColor: UIColor?) -> UIAlertController? {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        
        if let handlers = textFieldHandlers {
            for handler in handlers {
                alertController.addTextFieldWithConfigurationHandler(handler)
            }
        }
        
        var hasCancelAction = false
        
        if let actions = actions {
            for action in actions {
                if action.style == .Cancel {
                    hasCancelAction = true
                }
                
                alertController.addAction(action)
            }
        }
        
        if !hasCancelAction {
            alertController.addAction(self.cancelAction(nil))
        }
        
        alertController.view.tintColor = tintColor
        alertController.displayAnimated(animated: true, completion: nil)
        
        return alertController
    }
    
    class func cancelAction(handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        return UIAlertAction(
            title: NSLocalizedString("S_Cancel", comment: ""),
            style: .Cancel,
            handler: handler
        )
    }
}
