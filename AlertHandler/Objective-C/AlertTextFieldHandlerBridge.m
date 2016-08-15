//
//  AlertTextFieldHandlerBridge.m
//  AlertHandler
//
//  Created by Paul Kite on 4/1/16.
//  Copyright © 2016 Voodoo77 Studios, Inc. All rights reserved.
//

#import "AlertTextFieldHandlerBridge.h"

@implementation AlertTextFieldHandlerBridge

+ (instancetype _Nonnull)bridgeWithHandler:(AlertTextFieldHandler _Nonnull)handler
{
    return [[AlertTextFieldHandlerBridge alloc] initWithHandler:handler];
}

- (instancetype _Nonnull)initWithHandler:(AlertTextFieldHandler _Nonnull)handler
{
    self = [super init];

    if (self != nil)
    {
        _handler = handler;
    }

    return self;
}

@end
