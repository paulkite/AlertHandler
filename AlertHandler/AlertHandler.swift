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
    private func displayAnimated(animated animated: Bool, completion: (() -> Void)?) {
        let displayWindow = UIApplication.sharedApplication().keyWindow

        if UIDevice.currentDevice().userInterfaceIdiom == .Pad && self.preferredStyle == .ActionSheet {
            self.popoverPresentationController?.sourceView = displayWindow?.rootViewController?.view
        }

        displayWindow?.rootViewController?.presentViewController(self, animated: animated, completion: completion)
    }
}

extension AlertHandler {
    /**
     Presents an alert with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter actions: An array of UIAlertActions.
     - Parameter textFieldHandlerInfo: An array of dictionaries to configure each text field.
     - Parameter tintColor: The tint color to apply to the actions.

     - Returns: The presented UIAlertController instance.
    */
    
    @objc public class func objc_displayAlert(title title: String?, message: String?) -> UIAlertController? {
        return self.objc_displayAlert(title: title, message: message, actions: nil)
    }

    @objc public class func objc_displayAlert(title title: String?, message: String?, actions: [UIAlertAction]?) -> UIAlertController? {
        return self.objc_displayAlert(title: title, message: message, actions: actions, textFieldHandlerInfo: nil)
    }

    @objc public class func objc_displayAlert(title title: String?, message: String?, actions: [UIAlertAction]?, textFieldHandlerInfo: [[String : AnyObject]]?) -> UIAlertController? {
        return self.objc_displayAlert(title: title, message: message, actions: actions, textFieldHandlerInfo: textFieldHandlerInfo, tintColor: nil)
    }

    @objc public class func objc_displayAlert(title title: String?, message: String?, actions: [UIAlertAction]?, textFieldHandlerInfo: [[String : AnyObject]]?, tintColor: UIColor?) -> UIAlertController? {
        let handlers = textFieldHandlerInfo?.reduce([AlertTextFieldHandler](), combine: { (aggregate, next) -> [AlertTextFieldHandler] in
            var mutableAggregate = [AlertTextFieldHandler]()
            mutableAggregate.appendContentsOf(aggregate)

            mutableAggregate.append({ (textField: UITextField!) -> Void in
                for (key, value) in next {
                    textField.setValue(value, forKey: key)
                }
            })

            return mutableAggregate
        })

        return self.display(
            title: title,
            message: message,
            alertStyle: .Alert,
            actions: actions,
            textFieldHandlers: handlers,
            fromView:  nil,
            tintColor: tintColor
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

    @nonobjc public class func displayAlert(title title: String?, message: String?, actions: [UIAlertAction]? = nil, textFieldHandlers: [AlertTextFieldHandler]? = nil, tintColor: UIColor? = nil) -> UIAlertController? {
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
    
    private class func display(title title: String?, message: String?, alertStyle: UIAlertControllerStyle, actions: [UIAlertAction]?, textFieldHandlers: [AlertTextFieldHandler]?, fromView: UIView?, tintColor: UIColor?) -> UIAlertController? {
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
