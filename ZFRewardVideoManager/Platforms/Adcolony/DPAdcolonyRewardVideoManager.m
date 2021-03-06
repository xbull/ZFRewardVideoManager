//
//  DPAdcolonyRewardVideoManager.m
//  AdColonyV4VC
//
//  Created by Dai Pei on 2016/12/7.
//  Copyright © 2016年 Dai Pei. All rights reserved.
//

#import "DPAdcolonyRewardVideoManager.h"
#import <AdColony/AdColony.h>
#import "ZFCommon.h"

@interface DPAdcolonyRewardVideoManager()

@property (nonatomic, readwrite, copy) NSString *adId;
@property (nonatomic, readwrite, copy) NSString *zoneId;
@property (nonatomic, readwrite, strong) AdColonyInterstitial *ad;

@end

@implementation DPAdcolonyRewardVideoManager

+ (instancetype)sharedInstance {
    static DPAdcolonyRewardVideoManager *instance = nil;
    static dispatch_once_t onceTocken;
    dispatch_once(&onceTocken, ^{
        instance = [[DPAdcolonyRewardVideoManager alloc] init];
    });
    return instance;
}

#pragma mark - Public Method

- (void)startWithId:(NSString *)adColonyId zoneId:(NSString *)zoneId {
    self.adId = adColonyId;
    self.zoneId = zoneId;
    [AdColony configureWithAppID:adColonyId zoneIDs:@[zoneId] options:nil completion:^(NSArray<AdColonyZone *> * _Nonnull zones) {
        [self requestInterstitial];
    }];
    
}

- (void)play {
    if (self.ad && !self.ad.expired) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(videoWillStart:)]) {
            [self.delegate videoWillStart:ZFRewardVideoTypeAdcolony];
        }
        [self.ad showWithPresentingViewController:[ZFCommon getTopmostViewController]];
    }
}

#pragma mark - Private Method

- (void)requestInterstitial {
    //Request an interstitial ad from AdColony
    [self adcolonyRewardVideoManagerLog:[NSString stringWithFormat:@"video loading at zone:%@", self.zoneId]];
    [AdColony requestInterstitialInZone:self.zoneId options:nil
     
                                success:^(AdColonyInterstitial* ad) {
                                    
                                    
                                    ad.close = ^{
                                        _ad = nil;
                                        
                                        [self adcolonyRewardVideoManagerLog:[NSString stringWithFormat:@"video close at zone:%@", self.zoneId]];
                                        if (self.delegate) {
                                            if ([self.delegate respondsToSelector:@selector(videoClosed:)]) {
                                                [self.delegate videoClosed:ZFRewardVideoTypeAdcolony];
                                            }
                                            if ([self.delegate respondsToSelector:@selector(videoLoading:)]) {
                                                [self.delegate videoLoading:ZFRewardVideoTypeAdcolony];
                                            }
                                        }
                                        [self requestInterstitial];
                                    };
                                    
                                    
                                    ad.expire = ^{
                                        _ad = nil;
                                        [self adcolonyRewardVideoManagerLog:[NSString stringWithFormat:@"video expire at zone:%@", self.zoneId]];
                                        if (self.delegate && [self.delegate respondsToSelector:@selector(videoLoading:)]) {
                                            [self.delegate videoLoading:ZFRewardVideoTypeAdcolony];
                                        }
                                        [self requestInterstitial];
                                    };
                                    
                                    _ad = ad;
                                    
                                    [self adcolonyRewardVideoManagerLog:[NSString stringWithFormat:@"video ready at zone:%@", self.zoneId]];
                                    if (self.delegate && [self.delegate respondsToSelector:@selector(videoLoaded:)]) {
                                        [self.delegate videoLoaded:ZFRewardVideoTypeAdcolony];
                                    }
                                }
     
                                failure:^(AdColonyAdRequestError* error) {
                                    [self adcolonyRewardVideoManagerLog:[NSString stringWithFormat:@"Request failed with error: %@ and suggestion: %@", [error localizedDescription], [error localizedRecoverySuggestion]]];
                                }
     ];
}

#pragma mark - Logger

- (void)adcolonyRewardVideoManagerLog:(NSString *)message {
    NSLog(@"【DPAdColonyRewardVideoManager】%@", message);
}

@end
