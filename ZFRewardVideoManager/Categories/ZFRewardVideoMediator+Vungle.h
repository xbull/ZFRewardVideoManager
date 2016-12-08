//
//  CTMediator+Vungle.h
//  ZFRewardVideoDemo
//
//  Created by Ruozi on 11/29/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "ZFRewardVideoMediator.h"
#import "ZFRewardVideoDelegate.h"

@interface ZFRewardVideoMediator (Vungle)

- (void)ZFRewardVideoMediator_setVungleDelegate:(id<ZFRewardVideoDelegate>)delegate;

- (void)ZFRewardVideoMediator_startVungleWithAppId:(NSString *)appId;

- (void)ZFRewardVideoMediator_playVungleWithOptions:(NSDictionary *)options;

@end
