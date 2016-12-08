//
//  Target_Adcolony.m
//  ZFRewardVideoDemo
//
//  Created by Ruozi on 11/30/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "Target_Adcolony.h"
#import "AdColonyRewardVideoManager.h"

@implementation Target_Adcolony

- (void)Action_setDelegate:(NSDictionary *)params {
    [AdColonyRewardVideoManager sharedInstance].delegate = [params objectForKey:@"delegate"];
}

- (void)Action_startWithInfo:(NSDictionary *)params {
    [[AdColonyRewardVideoManager sharedInstance] startWithId:[params objectForKey:@"appId"] zoneId:[params objectForKey:@"zoneId"]];
}

- (void)Action_playWithOptions:(NSDictionary *)params {
    [[AdColonyRewardVideoManager sharedInstance] play];
}

@end
