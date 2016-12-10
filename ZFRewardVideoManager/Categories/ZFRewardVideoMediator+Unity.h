//
//  ZFRewardVideoMediator+Unity.h
//  ZFRewardVideoDemo
//
//  Created by Dai Pei on 2016/12/9.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import "ZFRewardVideoMediator.h"
#import "ZFRewardVideoDelegate.h"

@interface ZFRewardVideoMediator (Unity)

- (void)ZFRewardVideoMediator_setUnityDelegate:(id<ZFRewardVideoDelegate>)delegate;

- (void)ZFRewardVideoMediator_startUnityWithGameId:(NSString *)gameId placementId:(NSString *)placementId;

- (void)ZFRewardVideoMediator_playUnity;

@end
