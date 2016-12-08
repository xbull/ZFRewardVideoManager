//
//  Target_Appnext.m
//  ZFRewardVideoDemo
//
//  Created by Ruozi on 11/30/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "Target_Appnext.h"
#import "ZFAppnextRewardVideoManager.h"

@implementation Target_Appnext

- (void)Action_setDelegate:(NSDictionary *)params {
    [ZFAppnextRewardVideoManager sharedInstance].delegate = [params objectForKey:@"delegate"];
}

- (void)Action_startWithPlacementId:(NSDictionary *)params {
    [[ZFAppnextRewardVideoManager sharedInstance] startWithPlacementId:[params objectForKey:@"placementId"]];
}

- (void)Action_showRV:(NSDictionary *)params {
    [[ZFAppnextRewardVideoManager sharedInstance] play];
}

@end
