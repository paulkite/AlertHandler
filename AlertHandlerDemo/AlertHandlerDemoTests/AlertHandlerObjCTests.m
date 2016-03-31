//
//  AlertHandlerObjCTests.m
//  AlertHandlerDemo
//
//  Created by Paul Kite on 3/31/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

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

    NSArray<NSDictionary *> *textFieldHandlers = @[
        @{@"placeholder" : @"placeholder"},
        @{@"secureTextEntry" : @YES},
    ];

    UIAlertController *alertController = [AlertHandler objc_displayAlertWithTitle:title
                                                                          message:message
                                                                          actions:actions
                                                             textFieldHandlerInfo:textFieldHandlers];

    XCTAssertEqual(alertController.title, title);

    [alertController.actions enumerateObjectsUsingBlock:^(UIAlertAction *action, NSUInteger idx, BOOL * _Nonnull stop) {
        if (action.style != UIAlertActionStyleCancel)
        {
            XCTAssertEqual(action.title, ((UIAlertAction *)actions[idx]).title);
            XCTAssertEqual(action.style, ((UIAlertAction *)actions[idx]).style);
        }
    }];

    XCTAssertEqual(alertController.textFields.firstObject.placeholder, @"placeholder");
    XCTAssertEqual(alertController.textFields.lastObject.secureTextEntry, YES);
}

- (void)testAlertDealloc
{
    __weak UIAlertController *alertController = nil;

    @autoreleasepool {
        UIAlertController *controller = [AlertHandler objc_displayAlertWithTitle:@"Title" message:@"Message"];
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
