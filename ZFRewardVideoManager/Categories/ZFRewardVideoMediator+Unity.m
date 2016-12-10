//
//  ZFRewardVideoMediator+Unity.m
//  ZFRewardVideoDemo
//
//  Created by Dai Pei on 2016/12/9.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import "ZFRewardVideoMediator+Unity.h"

NSString *const kZFRewardVideoMediatorTargetUnity = @"Unity";

NSString *const kZFRewardVideoMediatorActionSetMediatorDelegate = @"setDelegate";

NSString *const kZFRewardVideoMediatorActionStartUnityWithInfo = @"startWithInfo";

NSString *const kZFRewardVideoMediatorActionPlay = @"playWithOption";

/*
 *  Params Keys
 */

//params keys for method -ZFRewardVideoMediator_setUnityDelegate:
#define kDelegateKey            @"delegate"

//params keys for method -ZFRewardVideoMediator_startUnityWithGameId:placementId:
#define kGameIdKey              @"gameId"
#define kPlacementIdKey         @"placementId"

#define kOptionKey              @"option"

@implementation ZFRewardVideoMediator (Unity)

- (void)ZFRewardVideoMediator_setUnityDelegate:(id<ZFRewardVideoDelegate>)delegate {
    [self performTarget:kZFRewardVideoMediatorTargetUnity
                 action:kZFRewardVideoMediatorActionSetMediatorDelegate
                 params:@{kDelegateKey : delegate}
      shouldCacheTarget:NO];
}

- (void)ZFRewardVideoMediator_startUnityWithGameId:(NSString *)gameId placementId:(NSString *)placementId {
    [self performTarget:kZFRewardVideoMediatorTargetUnity
                 action:kZFRewardVideoMediatorActionStartUnityWithInfo
                 params:@{kGameIdKey        : gameId,
                          kPlacementIdKey   : placementId}
      shouldCacheTarget:NO];
}

- (void)ZFRewardVideoMediator_playUnity {
    [self performTarget:kZFRewardVideoMediatorTargetUnity
                 action:kZFRewardVideoMediatorActionPlay
                 params:@{@"option" : @{}}
      shouldCacheTarget:NO];
}

@end
