//
//  ZFRewardVideoMediator+Appnext.m
//  ZFRewardVideoDemo
//
//  Created by Ruozi on 11/30/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "ZFRewardVideoMediator+Appnext.h"

NSString * const kZFRewardVideoMediatorTargetAppnext = @"Appnext";

NSString * const kZFRewardVideoMediatorActionSetAppnextDelegate = @"setDelegate";
NSString * const kZFRewardVideoMediatorActionStartAppnextWithPlacementId = @"startWithPlacementId";
NSString * const kZFRewardVideoMediatorActionPlayAppnext = @"showRV";

@implementation ZFRewardVideoMediator (Appnext)

- (void)ZFRewardVideoMediator_setAppnextDelegate:(id<ZFRewardVideoDelegate>)delegate {
    
    [self performTarget:kZFRewardVideoMediatorTargetAppnext
                 action:kZFRewardVideoMediatorActionSetAppnextDelegate
                 params:@{@"delegate" : delegate}
      shouldCacheTarget:NO];
}

- (void)ZFRewardVideoMediator_startAppnextWithPlacementId:(NSString *)placementId {
    
    [self performTarget:kZFRewardVideoMediatorTargetAppnext
                 action:kZFRewardVideoMediatorActionStartAppnextWithPlacementId
                 params:@{@"placementId" : placementId}
      shouldCacheTarget:NO];
}

- (void)ZFRewardVideoMediator_playAppnext {
    
    [self performTarget:kZFRewardVideoMediatorTargetAppnext
                 action:kZFRewardVideoMediatorActionPlayAppnext
                 params:@{@"options" : @{}}
      shouldCacheTarget:NO];
}


@end
