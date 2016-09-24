//
//  AlertHandlerDemoUITests.swift
//  AlertHandlerDemoUITests
//
//  Created by Paul Kite on 3/11/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

import XCTest

class AlertHandlerDemoUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        self.continueAfterFailure = false
        
        XCUIApplication().launch()
    }
    
    func testAlert() {
        let app = XCUIApplication()
        app.buttons["present_alert_button"].tap()
        app.alerts["Title"].buttons["Cancel"].tap()
    }
    
    func testAlertWithAction() {
        let app = XCUIApplication()
        let presentAlertWithActionButtonButton = app.buttons["present_alert_with_action_button"]
        presentAlertWithActionButtonButton.tap()
        
        let titleAlert = app.alerts["Title"]
        titleAlert.buttons["Title"].tap()
        presentAlertWithActionButtonButton.tap()
        titleAlert.buttons["Cancel"].tap()

    }
    
    func testAlertWithActionPlusTextField() {
        let app = XCUIApplication()
        let presentAlertWithActionPlusTextfieldButtonButton = app.buttons["present_alert_with_action_plus_textfield_button"]
        presentAlertWithActionPlusTextfieldButtonButton.tap()
        
        let titleAlert = app.alerts["Title"]
        let placeholderTextField = titleAlert.collectionViews.textFields["placeholder"]
        placeholderTextField.typeText("Test")
        titleAlert.buttons["Title"].tap()
        presentAlertWithActionPlusTextfieldButtonButton.tap()
        placeholderTextField.typeText("Test")
        titleAlert.buttons["Cancel"].tap()
    }
    
    func testActionSheet() {
        let app = XCUIApplication()
        app.buttons["present_action_sheet_button"].tap()

        if UIDevice.current.userInterfaceIdiom == .phone {
            app.sheets["Title"].buttons["Cancel"].tap()
        } else {
            app.otherElements["PopoverDismissRegion"].tap()
        }
    }
    
    func testActionSheetWithAction() {
        let app = XCUIApplication()
        let presentActionSheetButtonWithActionButtonButton = app.buttons["present_action_sheet_button_with_action_button"]
        presentActionSheetButtonWithActionButtonButton.tap()
        
        let titleSheet = app.sheets["Title"]
        titleSheet.buttons["Title"].tap()
        presentActionSheetButtonWithActionButtonButton.tap()

        if UIDevice.current.userInterfaceIdiom == .phone {
            titleSheet.buttons["Cancel"].tap()
        } else {
            app.otherElements["PopoverDismissRegion"].tap()
        }
    }

    func testAlertOnPresentedViewController() {
        let app = XCUIApplication()
        app.buttons["present_view_controller_button"].tap()
        app.buttons["present_alert_button"].tap()
        app.alerts["Title"].buttons["Cancel"].tap()
        app.navigationBars["Presented View Controller"].buttons["Done"].tap()
    }

    func testActionSheetOnPresentedViewController() {
        let app = XCUIApplication()
        app.buttons["present_view_controller_button"].tap()
        app.buttons["present_action_sheet_button"].tap()

        if UIDevice.current.userInterfaceIdiom == .phone {
            app.sheets["Title"].buttons["Cancel"].tap()
        } else {
            app.otherElements["PopoverDismissRegion"].tap()
        }

        app.navigationBars["Presented View Controller"].buttons["Done"].tap()
    }
}
