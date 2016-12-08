//
//  ZFAppnextRewardVideoManager.m
//  iFun
//
//  Created by Ruozi on 11/4/16.
//  Copyright © 2016 AppFinder. All rights reserved.
//

#import "ZFAppnextRewardVideoManager.h"
#import "AppnextLib.h"

@interface ZFAppnextRewardVideoManager () <AppnextAdDelegate>

@property (nonatomic, strong) AppnextFullScreenVideoAd *fullScreenAd;

@end

@implementation ZFAppnextRewardVideoManager

#pragma mark - Singleton
+ (instancetype)sharedInstance {
    static ZFAppnextRewardVideoManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZFAppnextRewardVideoManager alloc] init];
    });
    return instance;
}

#pragma mark - Public methods
- (void)startWithPlacementId:(NSString *)placementId {
    
    [AppnextSDKApi startSDKApi];
    
    self.fullScreenAd = [[AppnextFullScreenVideoAd alloc] initWithPlacementID:placementId];
    [self.fullScreenAd setShowClose:NO];
    self.fullScreenAd.delegate = self;
    
    [self.fullScreenAd loadAd];
    NSLog(@"【ZFAppnextRewardVIdeoManager】start with placement id:%@!", placementId);
}

- (void)play {
    
    if (self.fullScreenAd.adIsLoaded) {
        [self.fullScreenAd showAd];
        NSLog(@"【ZFAppnextRewardVIdeoManager】Play ads.");
    }
}

#pragma mark - <AppnextAdDelegate>
- (void)adLoaded:(AppnextAd *)ad {
    NSLog(@"【ZFAppnextRewardVIdeoManager】Ad Loaded!");
    if (ad.adIsLoaded) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(videoLoaded:)]) {
            [self.delegate videoLoaded:ZFRewardVideoTypeAppNext];
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(videoLoading:)]) {
            [self.delegate videoLoading:ZFRewardVideoTypeAppNext];
        }
        [ad loadAd];
    }
}

- (void)adOpened:(AppnextAd *)ad {
    NSLog(@"【ZFAppnextRewardVIdeoManager】Ad opened!");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoWillStart:)]) {
        [self.delegate videoWillStart:ZFRewardVideoTypeAppNext];
    }
}

- (void)adClosed:(AppnextAd *)ad {
    NSLog(@"【ZFAppnextRewardVIdeoManager】Ad closed!");
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoClosed:)]) {
        [self.delegate videoClosed:ZFRewardVideoTypeAppNext];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoLoading:)]) {
        [self.delegate videoLoading:ZFRewardVideoTypeAppNext];
    }
    
    [ad loadAd];
}

- (void)adClicked:(AppnextAd *)ad {
    NSLog(@"【ZFAppnextRewardVIdeoManager】Ad clicked!");
}

- (void)adUserWillLeaveApplication:(AppnextAd *)ad {
    NSLog(@"【ZFAppnextRewardVIdeoManager】Ad user will leave application!");
}

- (void)adError:(AppnextAd *)ad error:(NSString *)error {
    NSLog(@"【ZFAppnextRewardVIdeoManager】Ad error:%@!", error);
}

@end
