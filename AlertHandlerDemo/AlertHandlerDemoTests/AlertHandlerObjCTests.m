//
//  AlertHandlerObjCTests.m
//  AlertHandlerDemo
//
//  Created by Paul Kite on 3/31/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <AlertHandler/AlertHandler.h>
#import <AlertHandler/AlertHandler-Swift.h>

@interface AlertHandlerObjCTests : XCTestCase

@end

@implementation AlertHandlerObjCTests

- (void)testAlertPopulatesCorrectly
{
    NSString *title = @"Title";
    NSString *message = @"Message";
    NSArray *actions = @[
        [UIAlertAction actionWithTitle:@"First" style:UIAlertActionStyleDefault handler:nil],
        [UIAlertAction actionWithTitle:@"Second" style:UIAlertActionStyleDefault handler:nil]
    ];

    AlertTextFieldHandler placeHolderBlock = ^void(UITextField *textField) {
        textField.placeholder = @"placeholder";
        textField.keyboardType = UIKeyboardTypeURL;
    };

    AlertTextFieldHandler secureTextEntryBlock = ^void(UITextField *textField) {
        textField.secureTextEntry = YES;
    };

    NSArray<AlertTextFieldHandlerBridge *> *textFieldHandlers = @[
        [AlertTextFieldHandlerBridge bridgeWithHandler:placeHolderBlock],
        [AlertTextFieldHandlerBridge bridgeWithHandler:secureTextEntryBlock]
    ];

    UIAlertController *alertController = [AlertHandler displayAlertWithTitle:title
                                                                     message:message
                                                                     actions:actions
                                                     textFieldHandlerBridges:textFieldHandlers
                                                                   tintColor:nil];

    XCTAssertEqual(alertController.title, title);

    [alertController.actions enumerateObjectsUsingBlock:^(UIAlertAction *action, NSUInteger idx, BOOL * _Nonnull stop) {
        if (action.style != UIAlertActionStyleCancel)
        {
            XCTAssertEqual(action.title, ((UIAlertAction *)actions[idx]).title);
            XCTAssertEqual(action.style, ((UIAlertAction *)actions[idx]).style);
        }
    }];

    XCTAssertEqual(alertController.textFields.firstObject.placeholder, @"placeholder");
    XCTAssertEqual(alertController.textFields.firstObject.keyboardType, UIKeyboardTypeURL);
    XCTAssertTrue(alertController.textFields.lastObject.secureTextEntry);

    [alertController dismissViewControllerAnimated:NO completion:nil];
}

- (void)testAlertDealloc
{
    __weak UIAlertController *alertController = nil;

    @autoreleasepool {
        UIAlertController *controller = [AlertHandler displayAlertWithTitle:@"Title"
                                                                    message:@"Message"
                                                                    actions:nil
                                                    textFieldHandlerBridges:nil
                                                                  tintColor:nil];
        alertController = controller;

        XCTestExpectation *expectation = [self expectationWithDescription:@"Alert Dismissal Completed Expecation"];

        [alertController dismissViewControllerAnimated:YES completion:^{
            [expectation fulfill];
        }];
        
        [self waitForExpectationsWithTimeout:3.0 handler: nil];
    }
    
    XCTAssertNil(alertController);
}

@end
