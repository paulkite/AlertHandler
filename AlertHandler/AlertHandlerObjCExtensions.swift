//
//  AlertHandlerObjCExtensions.swift
//  AlertHandler
//
//  Created by Paul Kite on 3/31/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

import Foundation

extension AlertHandler {
    /**
     Presents an alert with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.

     - Returns: The presented UIAlertController instance.
     */

    @objc public class func objc_displayAlert(title title: String?, message: String?) -> UIAlertController? {
        return self.objc_displayAlert(title: title, message: message, actions: nil)
    }

    /**
     Presents an alert with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter actions: An array of UIAlertActions.

     - Returns: The presented UIAlertController instance.
     */

    @objc public class func objc_displayAlert(title title: String?, message: String?, actions: [UIAlertAction]?) -> UIAlertController? {
        return self.objc_displayAlert(title: title, message: message, actions: actions, textFieldHandlerInfo: nil)
    }

    /**
     Presents an alert with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter actions: An array of UIAlertActions.
     - Parameter textFieldHandlerInfo: An array of dictionaries to configure each text field.

     - Returns: The presented UIAlertController instance.
     */

    @objc public class func objc_displayAlert(title title: String?, message: String?, actions: [UIAlertAction]?, textFieldHandlerInfo: [[String : AnyObject]]?) -> UIAlertController? {
        return self.objc_displayAlert(title: title, message: message, actions: actions, textFieldHandlerInfo: textFieldHandlerInfo, tintColor: nil)
    }

    /**
     Presents an alert with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter actions: An array of UIAlertActions.
     - Parameter textFieldHandlerInfo: An array of dictionaries to configure each text field.
     - Parameter tintColor: The tint color to apply to the actions.

     - Returns: The presented UIAlertController instance.
     */

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

    /**
     Presents an action sheet with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.

     - Returns: The presented UIAlertController instance.
     */

    @objc public class func objc_displayActionSheet(title title: String?, message: String?) -> UIAlertController? {
        return self.objc_displayActionSheet(title: title, message: message, actions: nil)
    }

    /**
     Presents an action sheet with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter actions: An array of UIAlertActions.

     - Returns: The presented UIAlertController instance.
     */

    @objc public class func objc_displayActionSheet(title title: String?, message: String?, actions: [UIAlertAction]?) -> UIAlertController? {
        return self.objc_displayActionSheet(title: title, message: message, actions: actions, fromView: nil)
    }

    /**
     Presents an action sheet with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter actions: An array of UIAlertActions.
     - Parameter fromView: The view to present the action sheet from. (Required by iPad. Otherwise ignored.)

     - Returns: The presented UIAlertController instance.
     */

    @objc public class func objc_displayActionSheet(title title: String?, message: String?, actions: [UIAlertAction]?, fromView: UIView?) -> UIAlertController? {
        return self.objc_displayActionSheet(title: title, message: message, actions: actions, fromView: fromView, tintColor: nil)
    }

    /**
     Presents an action sheet with the supplied arguments.

     - Parameter title: The title to display.
     - Parameter message: The message to display.
     - Parameter actions: An array of UIAlertActions.
     - Parameter fromView: The view to present the action sheet from. (Required by iPad. Otherwise ignored.)
     - Parameter tintColor: The tint color to apply to the actions.

     - Returns: The presented UIAlertController instance.
     */

    @objc public class func objc_displayActionSheet(title title: String?, message: String?, actions: [UIAlertAction]?, fromView: UIView?, tintColor: UIColor?) -> UIAlertController? {
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
}