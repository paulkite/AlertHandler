//
//  AlertHandler+ObjCHelper.h
//  AlertHandler
//
//  Created by Paul Kite on 4/30/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

#import <AlertHandler/AlertHandler.h>
#import <AlertHandler/AlertHandler-Swift.h>

typedef void (^AlertHandlerCompletionBlock)(UIAlertController  * _Nullable controller);

@interface AlertHandler (ObjCHelper)

+ (UIAlertController * _Nullable)displayAlertWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message completion:(AlertHandlerCompletionBlock _Nullable)completion;

+ (UIAlertController * _Nullable)displayAlertWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message actions:(NSArray<UIAlertAction *> * _Nullable)actions completion:(AlertHandlerCompletionBlock _Nullable)completion;

+ (UIAlertController * _Nullable)displayAlertWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message actions:(NSArray<UIAlertAction *> * _Nullable)actions textFieldHandlerBridges:(NSArray<AlertTextFieldHandlerBridge *> * _Nullable)textFieldHandlerBridges completion:(AlertHandlerCompletionBlock _Nullable)completion;

@end
