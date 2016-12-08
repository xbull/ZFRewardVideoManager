//
//  ZFRewardVideoMediator+Vungle.m
//  ZFRewardVideoDemo
//
//  Created by Ruozi on 11/29/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "ZFRewardVideoMediator+Vungle.h"

NSString * const kZFRewardVideoMediatorTargetVungle = @"Vungle";

NSString * const kZFRewardVideoMediatorActionSetVungleDelegate = @"setDelegate";
NSString * const kZFRewardVideoMediatorActionStartVungleWithAppId = @"startWithAppId";
NSString * const kZFRewardVideoMediatorActionPlayVungleWithOptions = @"playWithOptions";

@implementation ZFRewardVideoMediator (Vungle)

- (void)ZFRewardVideoMediator_setVungleDelegate:(id<ZFRewardVideoDelegate>)delegate {
    
    [self performTarget:kZFRewardVideoMediatorTargetVungle
                 action:kZFRewardVideoMediatorActionSetVungleDelegate
                 params:@{@"delegate" : delegate}
      shouldCacheTarget:NO];
}

- (void)ZFRewardVideoMediator_startVungleWithAppId:(NSString *)appId {
    
    [self performTarget:kZFRewardVideoMediatorTargetVungle
                 action:kZFRewardVideoMediatorActionStartVungleWithAppId
                 params:@{@"appId" : appId}
      shouldCacheTarget:NO];
}

- (void)ZFRewardVideoMediator_playVungleWithOptions:(NSDictionary *)options {
    
    [self performTarget:kZFRewardVideoMediatorTargetVungle
                 action:kZFRewardVideoMediatorActionPlayVungleWithOptions
                 params:@{@"options" : options? options : @{}}
      shouldCacheTarget:NO];
}

@end
