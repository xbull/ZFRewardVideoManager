//
//  AdColonyRewardVideoManager.h
//
//  Created by 文豪 on 1/22/16.
//

#import <Foundation/Foundation.h>
#import "ZFRewardVideoDelegate.h"

@interface AdColonyRewardVideoManager : NSObject

+ (instancetype)sharedInstance;
- (void)startWithId:(NSString *)adColonyId zoneId:(NSString *)zoneId;

- (void)play;

@property (nonatomic, weak) id<ZFRewardVideoDelegate> delegate;

@end
