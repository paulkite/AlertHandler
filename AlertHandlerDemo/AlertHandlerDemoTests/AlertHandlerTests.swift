//
//  AlertHandlerTests.swift
//  AlertHandlerTests
//
//  Created by Paul Kite on 3/11/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

import XCTest
import UIKit

@testable import AlertHandler

class AlertHandlerTests: XCTestCase {
    func testAlertPopulatesCorrectly() {
        let title = "Title"
        let message = "Message"
        let actions = [
            UIAlertAction(title: "First", style: .default, handler: nil),
            UIAlertAction(title: "Second", style: .default, handler: nil)
        ]
        let textFieldHandlers: [AlertTextFieldHandler] = [
            {$0.placeholder = "placeholder"
             $0.keyboardType = .URL},
            {$0.isSecureTextEntry = true}
        ]
        
        let alertController = AlertHandler.displayAlert(
            title: title,
            message: message,
            actions: actions,
            textFieldHandlers: textFieldHandlers
        )
        
        XCTAssertEqual(alertController?.title, title)
        
        for index in 0..<(alertController!.actions.count - 1) {
            let action = alertController?.actions[index]
            
            XCTAssertEqual(action!.title, actions[index].title)
            XCTAssertEqual(action!.style, actions[index].style)
        }
        
        XCTAssertEqual(alertController!.textFields!.first!.placeholder, "placeholder")
        XCTAssertEqual(alertController!.textFields!.first!.keyboardType, UIKeyboardType.URL)
        XCTAssertTrue(alertController!.textFields!.last!.isSecureTextEntry)

        alertController?.dismiss(animated: false, completion: nil)
    }
    
    func testAlertDealloc() {
        weak var alertController: UIAlertController?
        
        autoreleasepool {
            let controller = AlertHandler.displayAlert(title: "Title", message: "Message")
            alertController = controller
            
            let expectation = self.expectation(description: "Alert Dismissal Completed Expecation")

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                alertController?.dismiss(animated: true) {
                    expectation.fulfill()
                }
            }
            
            self.waitForExpectations(timeout: 3.0, handler: nil)
        }
        
        XCTAssertNil(alertController)
    }
}
