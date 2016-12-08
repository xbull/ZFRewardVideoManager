//
//  ZFRewardVideoMediator+Adcolony.m
//  ZFRewardVideoDemo
//
//  Created by Ruozi on 11/30/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "ZFRewardVideoMediator+Adcolony.h"

NSString * const kZFRewardVideoMediatorTargetAdcolony = @"Adcolony";

NSString * const kZFRewardVideoMediatorActionSetAdcolonyDelegate = @"setDelegate";
NSString * const kZFRewardVideoMediatorActionStartAdcolonyWithAppInfo = @"startWithInfo";
NSString * const kZFRewardVideoMediatorActionPlayAdcolonyWithOptions = @"playWithOptions";


@implementation ZFRewardVideoMediator (Adcolony)

- (void)ZFRewardVideoMediator_setAdcolonyDelegate:(id<ZFRewardVideoDelegate>)delegate {
    
    [self performTarget:kZFRewardVideoMediatorTargetAdcolony
                 action:kZFRewardVideoMediatorActionSetAdcolonyDelegate
                 params:@{@"delegate" : delegate}
      shouldCacheTarget:NO];
}

- (void)ZFRewardVideoMediator_startAdcolonyWithAppId:(NSString *)appId zoneId:(NSString *)zoneId {
    
    [self performTarget:kZFRewardVideoMediatorTargetAdcolony
                 action:kZFRewardVideoMediatorActionStartAdcolonyWithAppInfo
                 params:@{@"appId" : appId,
                          @"zoneId" : zoneId}
      shouldCacheTarget:NO];
}

- (void)ZFRewardVideoMediator_playAdcolony {
    
    [self performTarget:kZFRewardVideoMediatorTargetAdcolony
                 action:kZFRewardVideoMediatorActionPlayAdcolonyWithOptions
                 params:@{@"options" : @{}}
      shouldCacheTarget:NO];
}

@end
