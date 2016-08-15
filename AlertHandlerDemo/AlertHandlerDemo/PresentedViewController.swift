//
//  PresentedViewController.swift
//  AlertHandlerDemo
//
//  Created by Paul Kite on 4/1/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

import UIKit
import AlertHandler

class PresentedViewController: UIViewController {
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var presentActionSheetButton: UIButton!
    @IBOutlet var presentAlertButton: UIButton!

    @IBAction func handleButtonTap(sender: AnyObject) {
        if sender as? UIButton == self.presentAlertButton {
            AlertHandler.displayAlert(title: "Title", message: "Message")
        } else if sender as? UIButton == self.presentActionSheetButton {
            AlertHandler.displayActionSheet(title: "Title", message: "Message", actions: nil, fromView: sender as? UIView)
        } else if sender as? UIBarButtonItem == self.doneButton {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
