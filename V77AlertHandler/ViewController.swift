//
//  ViewController.swift
//  V77AlertHandler
//
//  Created by Paul Kite on 3/11/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var presentAlertButton: UIButton!
    @IBOutlet var presentAlertWithActionButton: UIButton!
    @IBOutlet var presentAlertWithActionPlusTextFieldButton: UIButton!
    @IBOutlet var presentActionSheetButton: UIButton!
    @IBOutlet var presentActionSheetWithActionButton: UIButton!
    
    @IBAction func handleButtonTap(sender: AnyObject) {
        if sender as? UIButton == self.presentAlertButton {
            V77AlertHandler.displayAlert(title: "Title", message: "Message")
        } else if sender as? UIButton == self.presentAlertWithActionButton {
            V77AlertHandler.displayAlert(
                title: "Title",
                message: "Message",
                actions: [
                    UIAlertAction(title: "Title", style: .Default, handler: nil)
                ]
            )
        } else if sender as? UIButton == self.presentAlertWithActionPlusTextFieldButton {
            V77AlertHandler.displayAlert(
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
            V77AlertHandler.displayActionSheet(title: "Title", message: "Message")
        } else if sender as? UIButton == self.presentActionSheetWithActionButton {
            V77AlertHandler.displayActionSheet(
                title: "Title",
                message: "Message",
                actions: [
                    UIAlertAction(title: "Title", style: .Default, handler: nil)
                ]
            )
        }
    }
}

