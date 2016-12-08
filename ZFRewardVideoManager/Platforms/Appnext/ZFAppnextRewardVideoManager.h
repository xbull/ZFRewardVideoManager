//
//  ZFAppnextRewardVideoManager.h
//  iFun
//
//  Created by Ruozi on 11/4/16.
//  Copyright © 2016 AppFinder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFRewardVideoDelegate.h"

@interface ZFAppnextRewardVideoManager : NSObject

@property (nonatomic, weak) id<ZFRewardVideoDelegate> delegate;

+ (instancetype)sharedInstance;
- (void)startWithPlacementId:(NSString *)placementId;

- (void)play;

@end
