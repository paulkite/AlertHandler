//
//  V77AlertHandlerTests.swift
//  V77AlertHandlerTests
//
//  Created by Paul Kite on 3/11/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

import XCTest
@testable import V77AlertHandler

class V77AlertHandlerTests: XCTestCase {
    func testAlertPopulatesCorrectly() {
        let title = "Title"
        let message = "Message"
        let actions = [
            UIAlertAction(title: "First", style: .Default, handler: nil),
            UIAlertAction(title: "Second", style: .Default, handler: nil)
        ]
        let textFieldHandlers: [V77AlertTextFieldHandler] = [
            {$0.placeholder = "placeholder"},
            {$0.secureTextEntry = true}
        ]
        
        let alertController = V77AlertHandler.displayAlert(
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
        
        XCTAssertEqual(alertController?.textFields?.first?.placeholder, "placeholder")
        XCTAssertEqual(alertController?.textFields?.last?.secureTextEntry, true)
    }
    
    func testAlertDealloc() {
        weak var alertController: UIAlertController?
        
        autoreleasepool {
            let controller = V77AlertHandler.displayAlert(title: "Title", message: "Message")
            alertController = controller
            
            let expectation = self.expectationWithDescription("Alert Dismissal Completed Expecation")
            
            alertController?.dismissViewControllerAnimated(true, completion: {
                expectation.fulfill()
            })
            
            self.waitForExpectationsWithTimeout(3.0, handler: nil)
        }
        
        XCTAssertNil(alertController)
    }
}
