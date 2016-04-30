//
//  AlertHandler+ObjCHelper.m
//  AlertHandler
//
//  Created by Paul Kite on 4/30/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

#import "AlertHandler+ObjCHelper.h"

@implementation AlertHandler (ObjCHelper)

+ (UIAlertController * _Nullable)displayAlertWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message completion:(AlertHandlerCompletionBlock _Nullable)completion
{
    return [self displayAlertWithTitle:title message:message actions:nil completion:completion];
}

+ (UIAlertController * _Nullable)displayAlertWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message actions:(NSArray<UIAlertAction *> * _Nullable)actions completion:(AlertHandlerCompletionBlock _Nullable)completion
{
    return [self displayAlertWithTitle:title message:message actions:actions textFieldHandlerBridges:nil completion:completion];
}

+ (UIAlertController * _Nullable)displayAlertWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message actions:(NSArray<UIAlertAction *> * _Nullable)actions textFieldHandlerBridges:(NSArray<AlertTextFieldHandlerBridge *> * _Nullable)textFieldHandlerBridges completion:(AlertHandlerCompletionBlock _Nullable)completion
{
    return [self displayAlertWithTitle:title message:message actions:actions textFieldHandlerBridges:textFieldHandlerBridges tintColor:nil completion:completion];
}

@end
