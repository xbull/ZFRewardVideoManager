//
//  ZFRewardVideoMediator+Appnext.h
//  ZFRewardVideoDemo
//
//  Created by Ruozi on 11/30/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "ZFRewardVideoMediator.h"
#import "ZFRewardVideoDelegate.h"

@interface ZFRewardVideoMediator (Appnext)

- (void)ZFRewardVideoMediator_setAppnextDelegate:(id<ZFRewardVideoDelegate>)delegate;

- (void)ZFRewardVideoMediator_startAppnextWithPlacementId:(NSString *)placementId;

- (void)ZFRewardVideoMediator_playAppnext;

@end
