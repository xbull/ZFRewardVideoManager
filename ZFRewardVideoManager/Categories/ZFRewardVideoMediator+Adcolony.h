//
//  ZFRewardVideoMediator+Adcolony.h
//  ZFRewardVideoDemo
//
//  Created by Ruozi on 11/30/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "ZFRewardVideoMediator.h"
#import "ZFRewardVideoDelegate.h"

@interface ZFRewardVideoMediator (Adcolony)

- (void)ZFRewardVideoMediator_setAdcolonyDelegate:(id<ZFRewardVideoDelegate>)delegate;

- (void)ZFRewardVideoMediator_startAdcolonyWithAppId:(NSString *)appId zoneId:(NSString *)zoneId;

- (void)ZFRewardVideoMediator_playAdcolony;

@end
