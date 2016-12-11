//
//  Target_Unity.m
//  ZFRewardVideoDemo
//
//  Created by Dai Pei on 2016/12/9.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import "Target_Unity.h"
#import "DPUnityRewardVideoManager.h"

@implementation Target_Unity

- (void)Action_setDelegate:(NSDictionary *)params {
    [DPUnityRewardVideoManager sharedInstance].delegate = [params objectForKey:@"delegate"];
}

- (void)Action_startWithInfo:(NSDictionary *)params {
    [[DPUnityRewardVideoManager sharedInstance] startWithGameId:[params objectForKey:@"gameId"] placementId:[params objectForKey:@"placementId"]];
}

- (void)Action_playWithOption:(NSDictionary *)params {
    [[DPUnityRewardVideoManager sharedInstance] play];
}

@end
