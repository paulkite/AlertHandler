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
        app.alerts["Title"].collectionViews.buttons["Cancel"].tap()
    }
    
    func testAlertWithAction() {
        let app = XCUIApplication()
        app.buttons["present_alert_with_action_button"].tap()
        app.alerts["Title"].collectionViews.buttons["Title"].tap()
    }
    
    func testAlertWithActionPlusTextField() {
        let app = XCUIApplication()
        app.buttons["present_alert_with_action_plus_textfield_button"].tap()
        
        let collectionViewsQuery = app.alerts["Title"].collectionViews
        collectionViewsQuery.textFields["placeholder"].typeText("Test")
        collectionViewsQuery.buttons["Title"].tap()
    }
    
    func testActionSheet() {
        let app = XCUIApplication()
        app.buttons["present_action_sheet_button"].tap()
        app.sheets["Title"].buttons["Cancel"].tap()
    }
    
    func testActionSheetWithAction() {
        let app = XCUIApplication()
        app.buttons["present_action_sheet_button_with_action_button"].tap()
        app.sheets["Title"].collectionViews.buttons["Title"].tap()
    }
}