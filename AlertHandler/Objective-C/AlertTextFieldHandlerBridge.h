//
//  AlertTextFieldHandlerBridge.h
//  AlertHandler
//
//  Created by Paul Kite on 4/1/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UITextField;

typedef void (^AlertTextFieldHandler)(UITextField * _Nonnull);

@interface AlertTextFieldHandlerBridge : NSObject

@property (nonatomic, nonnull, readonly) AlertTextFieldHandler handler;

+ (instancetype _Nonnull)bridgeWithHandler:(AlertTextFieldHandler _Nonnull)handler;

@end
