//
//  AlertHandler.swift
//  AlertHandler
//
//  Created by Paul Kite on 3/11/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

import UIKit
import ObjectiveC

public typealias AlertTextFieldHandler = (@convention(block) (UITextField) -> Void)

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

        if UIDevice.currentDevice().userInterfaceIdiom == .Pad && self.preferredStyle == .ActionSheet {
            self.popoverPresentationController?.sourceView = self.displayWindow()?.rootViewController?.view
        }

        self.displayWindow()?.rootViewController?.presentViewController(self, animated: animated, completion: completion)
    }
    
    override public func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.setDisplayWindow(nil)
    }
}

@objc public class AlertHandler: NSObject {
    /**
     Presents an action sheet with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter actions: An array of UIAlertActions.
     - Parameter fromView: The view to present the action sheet from. (Required by iPad. Otherwise ignored.)
     - Parameter tintColor: The tint color to apply to the actions.

     - Returns: The presented UIAlertController instance.
     */

    @objc public class func displayActionSheet(title title: String?, message: String?, actions: [UIAlertAction]? = nil, fromView: UIView? = nil, tintColor: UIColor? = nil) -> UIAlertController? {
        return self.display(
            title: title,
            message: message,
            alertStyle: .ActionSheet,
            actions: actions,
            textFieldHandlers: nil,
            fromView: fromView,
            tintColor: tintColor
        )
    }

    /**
     Presents an alert with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter actions: An array of UIAlertActions.
     - Parameter textFieldHandlers: An array of AlertTextFieldHandler closures to configure each text field.
     - Parameter tintColor: The tint color to apply to the actions.

     - Returns: The presented UIAlertController instance.
     */
    
    @objc public class func displayAlert(title title: String?, message: String?, actions: [UIAlertAction]? = nil, textFieldHandlers: Array<AlertTextFieldHandler>? = nil, tintColor: UIColor? = nil) -> UIAlertController? {
        return self.display(
            title: title,
            message: message,
            alertStyle: .Alert,
            actions: actions,
            textFieldHandlers: textFieldHandlers,
            fromView:  nil,
            tintColor: tintColor
        )
    }
    
    private class func display(title title: String?, message: String?, alertStyle: UIAlertControllerStyle, actions: [UIAlertAction]?, textFieldHandlers: Array<AlertTextFieldHandler>?, fromView: UIView?, tintColor: UIColor?) -> UIAlertController? {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)

        if UIDevice.currentDevice().userInterfaceIdiom == .Pad && alertStyle == .ActionSheet {
            guard let presentFromView = fromView, let presenter = alertController.popoverPresentationController else {
                return nil
            }

            presenter.sourceRect = alertController.view.convertRect(presentFromView.bounds, fromView: presentFromView)
            alertController.modalPresentationStyle = .Popover
        }
        
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
    
    private class func UIKitLocalizedString(string: String) -> String {
        let bundle = NSBundle(forClass: UIApplication.self)
        let value = bundle.localizedStringForKey(string, value: string, table: nil)
        
        if value.characters.count > 0 {
            return value
        }
        
        return string
    }
    
    public class func cancelAction(handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        return UIAlertAction(
            title: self.UIKitLocalizedString("Cancel"),
            style: .Cancel,
            handler: handler
        )
    }
}
