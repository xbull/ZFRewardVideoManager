//
//  ZFVungleRewardVideoManager.h
//  GiftGame
//
//  Created by Ruozi on 8/17/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFRewardVideoDelegate.h"

@interface ZFVungleRewardVideoManager : NSObject

+ (instancetype)sharedInstance;
- (void)startWithAppId:(NSString *)appId;

- (void)playWithOptions:(NSDictionary *)options;

@property (nonatomic, weak) id<ZFRewardVideoDelegate> delegate;

@end
