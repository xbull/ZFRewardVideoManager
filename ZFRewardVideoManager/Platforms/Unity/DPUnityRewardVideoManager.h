//
//  DPUnityRewardVideoManager.h
//  DPUnityAdsDemo
//
//  Created by Dai Pei on 2016/12/9.
//  Copyright © 2016年 Dai Pei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFRewardVideoDelegate.h"

@interface DPUnityRewardVideoManager : NSObject

+ (instancetype)sharedInstance;

- (void)startWithGameId:(NSString *)gameId placementId:(NSString *)placementId;
- (void)play;

@property (nonatomic, weak) id<ZFRewardVideoDelegate> delegate;

@end
