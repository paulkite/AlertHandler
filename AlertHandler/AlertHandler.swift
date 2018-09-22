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
    fileprivate func displayAnimated(animated: Bool, tintColor: UIColor?, completion: (() -> Void)?) {
        let displayWindow = UIApplication.shared.keyWindow

        if UIDevice.current.userInterfaceIdiom == .pad && self.preferredStyle == .actionSheet {
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

        viewController?.present(self, animated: animated, completion: completion)

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

    @objc public class func displayAlert(title: String?, message: String?, actions: [UIAlertAction]?, textFieldHandlerBridges: [AlertTextFieldHandlerBridge]?, tintColor: UIColor?, completion: ((UIAlertController?) -> Void)?) -> UIAlertController? {
        return self.display(
            title: title,
            message: message,
            alertStyle: .alert,
            actions: actions,
            textFieldHandlers: textFieldHandlerBridges?.map({return $0.handler}),
            fromView:  nil,
            tintColor: tintColor,
            completion: completion
        )
    }
}

@objc open class AlertHandler: NSObject {
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

    @discardableResult
    @objc open class func displayActionSheet(title: String?, message: String?, actions: [UIAlertAction]? = nil, fromView: UIView? = nil, tintColor: UIColor? = nil, completion: ((UIAlertController?) -> Void)? = nil) -> UIAlertController? {
        return self.display(
            title: title,
            message: message,
            alertStyle: .actionSheet,
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

    @discardableResult
    @nonobjc open class func displayAlert(title: String?, message: String?, actions: [UIAlertAction]? = nil, textFieldHandlers: [AlertTextFieldHandler]? = nil, tintColor: UIColor? = nil, completion: ((UIAlertController?) -> Void)? = nil) -> UIAlertController? {
        return self.display(
            title: title,
            message: message,
            alertStyle: .alert,
            actions: actions,
            textFieldHandlers: textFieldHandlers,
            fromView:  nil,
            tintColor: tintColor,
            completion: completion
        )
    }
    
    fileprivate class func display(title: String?, message: String?, alertStyle: UIAlertController.Style, actions: [UIAlertAction]?, textFieldHandlers: [AlertTextFieldHandler]?, fromView: UIView?, tintColor: UIColor?, completion: ((UIAlertController?) -> Void)?) -> UIAlertController? {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)

        if UIDevice.current.userInterfaceIdiom == .pad && alertStyle == .actionSheet {
            guard let presentFromView = fromView, let presenter = alertController.popoverPresentationController else {
                return nil
            }

            presenter.sourceRect = alertController.view.convert(presentFromView.bounds, from: presentFromView)
            alertController.modalPresentationStyle = .popover
        }

        if let handlers = textFieldHandlers?.enumerated() {
            for (_, handler) in handlers {
                alertController.addTextField(configurationHandler: handler)
            }
        }
        
        let hasCancelAction = actions?.contains(where: {return $0.style == .cancel}) ?? false

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
    
    fileprivate class func UIKitLocalizedString(_ string: String) -> String {
        let bundle = Bundle(for: UIApplication.self)
        let value = bundle.localizedString(forKey: string, value: string, table: nil)
        
        if value.count > 0 {
            return value
        }
        
        return string
    }
    
    @objc open class func cancelAction(_ handler: ((UIAlertAction) -> Void)?) -> UIAlertAction {
        return UIAlertAction(
            title: self.UIKitLocalizedString("Cancel"),
            style: .cancel,
            handler: handler
        )
    }
}
