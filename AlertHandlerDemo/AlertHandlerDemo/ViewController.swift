//
//  ViewController.swift
//  V77AlertHandler
//
//  Created by Paul Kite on 3/11/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

import UIKit
import AlertHandler

class ViewController: UIViewController {
    @IBOutlet var presentAlertButton: UIButton!
    @IBOutlet var presentAlertWithActionButton: UIButton!
    @IBOutlet var presentAlertWithActionPlusTextFieldButton: UIButton!
    @IBOutlet var presentActionSheetButton: UIButton!
    @IBOutlet var presentActionSheetWithActionButton: UIButton!
    @IBOutlet var presentViewControllerButton: UIButton!

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    @IBAction func handleButtonTap(sender: AnyObject) {
        if sender as? UIButton == self.presentAlertButton {
            AlertHandler.displayAlert(title: "Title", message: "Message")
        } else if sender as? UIButton == self.presentAlertWithActionButton {
            AlertHandler.displayAlert(
                title: "Title",
                message: "Message",
                actions: [
                    UIAlertAction(title: "Title", style: .Default, handler: nil)
                ]
            )
        } else if sender as? UIButton == self.presentAlertWithActionPlusTextFieldButton {
            AlertHandler.displayAlert(
                title: "Title",
                message: "Message",
                actions: [
                    UIAlertAction(title: "Title", style: .Default, handler: nil)
                ],
                textFieldHandlers: [
                    { (textField) -> Void in
                        textField.placeholder = "placeholder"
                    }
                ]
            )
            
        } else if sender as? UIButton == self.presentActionSheetButton {
            AlertHandler.displayActionSheet(title: "Title", message: "Message", actions: nil, fromView: sender as? UIView)
        } else if sender as? UIButton == self.presentActionSheetWithActionButton {
            AlertHandler.displayActionSheet(
                title: "Title",
                message: "Message",
                actions: [
                    UIAlertAction(title: "Title", style: .Default, handler: nil)
                ],
                fromView: sender as? UIView
            )
        }
    }
}

