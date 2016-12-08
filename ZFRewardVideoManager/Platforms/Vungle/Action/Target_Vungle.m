//
//  ZFVungleRewardVideoManager.m
//
//  Created by Ruozi on 8/17/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "Target_Vungle.h"
#import "ZFVungleRewardVideoManager.h"

@implementation Target_Vungle

#pragma mark - Public methods
- (void)Action_setDelegate:(NSDictionary *)params {
    [ZFVungleRewardVideoManager sharedInstance].delegate = [params objectForKey:@"delegate"];
}

- (void)Action_startWithAppId:(NSDictionary *)params {
    [[ZFVungleRewardVideoManager sharedInstance] startWithAppId:[params objectForKey:@"appId"]];
}

- (void)Action_playWithOptions:(NSDictionary *)params {
    [[ZFVungleRewardVideoManager sharedInstance] playWithOptions:[params objectForKey:@"options"]];
}

@end
