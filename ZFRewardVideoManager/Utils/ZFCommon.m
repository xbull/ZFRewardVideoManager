//
//  ZFCommon.m
//
//  Created by Ruozi on 11/27/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "ZFCommon.h"

@implementation ZFCommon

+ (UIViewController *)getTopmostViewController {
    
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    BOOL isPresenting = NO;
    do {
        UIViewController *presented = [rootController presentedViewController];
        isPresenting = presented != nil;
        if(presented != nil) {
            rootController = presented;
        }
    } while (isPresenting);
    
    return rootController;
}


@end
