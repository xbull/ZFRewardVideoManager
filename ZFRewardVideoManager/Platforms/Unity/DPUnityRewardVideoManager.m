//
//  DPUnityRewardVideoManager.m
//  DPUnityAdsDemo
//
//  Created by Dai Pei on 2016/12/9.
//  Copyright © 2016年 Dai Pei. All rights reserved.
//

#import "DPUnityRewardVideoManager.h"
#import <UnityAds/UnityAds.h>
#import "ZFCommon.h"

@interface DPUnityRewardVideoManager()<UnityAdsDelegate>

@property (nonatomic, readwrite, copy) NSString *gameId;
@property (nonatomic, readwrite, copy) NSString *placementId;

@end

@implementation DPUnityRewardVideoManager

+ (instancetype)sharedInstance {
    static DPUnityRewardVideoManager *instance = nil;
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        instance = [[DPUnityRewardVideoManager alloc] init];
    });
    return instance;
}

- (void)startWithGameId:(NSString *)gameId placementId:(NSString *)placementId {
    self.gameId = gameId;
    self.placementId = placementId;
    [UnityAds initialize:gameId delegate:self];
}

- (void)play {
    if ([UnityAds isReady:self.placementId]) {
        [UnityAds show:[ZFCommon getTopmostViewController] placementId:self.placementId];
    }
}

#pragma mark - UnityAdsDelegate

- (void)unityAdsReady:(NSString *)placementId {
    [self unityRewardVideoManagerLog:[NSString stringWithFormat:@"video ready at place:%@", placementId]];
    
    if ([placementId isEqualToString:self.placementId]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(videoLoaded:)]) {
            [self.delegate videoLoaded:ZFRewardVideoTypeUnity];
        }
    }
}

- (void)unityAdsDidError:(UnityAdsError)error withMessage:(NSString *)message {
    [self unityRewardVideoManagerLog:[NSString stringWithFormat:@"video load error:%@", message]];
}


- (void)unityAdsDidStart:(NSString *)placementId {
    [self unityRewardVideoManagerLog:[NSString stringWithFormat:@"video will show at place:%@", placementId]];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(videoWillStart:)]) {
            [self.delegate videoWillStart:ZFRewardVideoTypeUnity];
        }
        if ([self.delegate respondsToSelector:@selector(videoLoading:)]) {
            [self.delegate videoLoading:ZFRewardVideoTypeUnity];
        }
    }
}

- (void)unityAdsDidFinish:(NSString *)placementId
          withFinishState:(UnityAdsFinishState)state {
    [self unityRewardVideoManagerLog:[NSString stringWithFormat:@"video will closed at place:%@", placementId]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoClosed:)]) {
        [self.delegate videoClosed:ZFRewardVideoTypeUnity];
    }
}

#pragma mark - Logger

- (void)unityRewardVideoManagerLog:(NSString *)message {
    NSLog(@"【DPUnityRewardVideoManager】%@", message);
}

@end
