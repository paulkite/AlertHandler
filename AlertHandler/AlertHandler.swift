//
//  AlertHandler.swift
//  AlertHandler
//
//  Created by Paul Kite on 3/11/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

import UIKit
import ObjectiveC

extension UIAlertController {
    private func displayAnimated(animated animated: Bool, tintColor: UIColor?, completion: (() -> Void)?) {
        let displayWindow = UIApplication.sharedApplication().keyWindow

        if UIDevice.currentDevice().userInterfaceIdiom == .Pad && self.preferredStyle == .ActionSheet {
            self.popoverPresentationController?.sourceView = displayWindow?.rootViewController?.view
        }

        var viewController = displayWindow?.rootViewController

        if let navigationController = displayWindow?.rootViewController as? UINavigationController {
            viewController = navigationController.visibleViewController
        } else if let tabBarController = displayWindow?.rootViewController as? UITabBarController {
            if let navigationController = tabBarController.selectedViewController as? UINavigationController {
                viewController = navigationController.visibleViewController
            } else {
                viewController = tabBarController.selectedViewController
            }
        }

        viewController?.presentViewController(self, animated: animated, completion: completion)

        self.view.tintColor = tintColor
    }
}

extension AlertHandler {
    /**
     Presents an alert with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter actions: An array of UIAlertActions.
     - Parameter textFieldHandlers: An array of AlertTextFieldHandlerBridge object containing AlertTextFieldHandler blocks to configure each text field.
     - Parameter tintColor: The tint color to apply to the actions.
     - Parameter completion: Block to be executed once presentation completes.

     - Returns: The presented UIAlertController instance.
     */

    @objc public class func displayAlert(title title: String?, message: String?, actions: [UIAlertAction]?, textFieldHandlerBridges: [AlertTextFieldHandlerBridge]?, tintColor: UIColor?, completion: ((UIAlertController?) -> Void)?) -> UIAlertController? {
        return self.display(
            title: title,
            message: message,
            alertStyle: .Alert,
            actions: actions,
            textFieldHandlers: textFieldHandlerBridges?.map({return $0.handler}),
            fromView:  nil,
            tintColor: tintColor,
            completion: completion
        )
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
     - Parameter completion: Block to be executed once presentation completes.

     - Returns: The presented UIAlertController instance.
     */

    @objc public class func displayActionSheet(title title: String?, message: String?, actions: [UIAlertAction]? = nil, fromView: UIView? = nil, tintColor: UIColor? = nil, completion: ((UIAlertController?) -> Void)? = nil) -> UIAlertController? {
        return self.display(
            title: title,
            message: message,
            alertStyle: .ActionSheet,
            actions: actions,
            textFieldHandlers: nil,
            fromView: fromView,
            tintColor: tintColor,
            completion: completion
        )
    }

    /**
     Presents an alert with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter actions: An array of UIAlertActions.
     - Parameter textFieldHandlers: An array of AlertTextFieldHandler closures to configure each text field.
     - Parameter tintColor: The tint color to apply to the actions.
     - Parameter completion: Block to be executed once presentation completes.

     - Returns: The presented UIAlertController instance.
     */

    @nonobjc public class func displayAlert(title title: String?, message: String?, actions: [UIAlertAction]? = nil, textFieldHandlers: [AlertTextFieldHandler]? = nil, tintColor: UIColor? = nil, completion: ((UIAlertController?) -> Void)? = nil) -> UIAlertController? {
        return self.display(
            title: title,
            message: message,
            alertStyle: .Alert,
            actions: actions,
            textFieldHandlers: textFieldHandlers,
            fromView:  nil,
            tintColor: tintColor,
            completion: completion
        )
    }
    
    private class func display(title title: String?, message: String?, alertStyle: UIAlertControllerStyle, actions: [UIAlertAction]?, textFieldHandlers: [AlertTextFieldHandler]?, fromView: UIView?, tintColor: UIColor?, completion: ((UIAlertController?) -> Void)?) -> UIAlertController? {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)

        if UIDevice.currentDevice().userInterfaceIdiom == .Pad && alertStyle == .ActionSheet {
            guard let presentFromView = fromView, let presenter = alertController.popoverPresentationController else {
                return nil
            }

            presenter.sourceRect = alertController.view.convertRect(presentFromView.bounds, fromView: presentFromView)
            alertController.modalPresentationStyle = .Popover
        }

        if let handlers = textFieldHandlers?.enumerate() {
            for (_, handler) in handlers {
                alertController.addTextFieldWithConfigurationHandler(handler)
            }
        }
        
        let hasCancelAction = actions?.contains({return $0.style == .Cancel}) ?? false

        if let actions = actions {
            for action in actions {
                alertController.addAction(action)
            }
        }
        
        if !hasCancelAction {
            alertController.addAction(self.cancelAction(nil))
        }

        let alertCompletion = {[weak alertController] in
            if let completion = completion {
                completion(alertController)
            }
        }

        alertController.displayAnimated(animated: true, tintColor: tintColor, completion: alertCompletion)
        
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
