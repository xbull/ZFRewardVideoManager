//
//  DPAdcolonyRewardVideoManager.h
//  AdColonyV4VC
//
//  Created by Dai Pei on 2016/12/7.
//  Copyright © 2016年 Dai Pei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFRewardVideoDelegate.h"

@interface DPAdcolonyRewardVideoManager : NSObject

+ (instancetype)sharedInstance;

- (void)startWithId:(NSString *)adColonyId zoneId:(NSString *)zoneId;
- (void)play;

@property (nonatomic, weak) id<ZFRewardVideoDelegate> delegate;

@end
