//
//  AdColonyRewardVideoManager.m
//
//  Created by 文豪 on 1/22/16.
//

#import <AdColony/AdColony.h>
#import "AdColonyRewardVideoManager.h"

static AdColonyRewardVideoManager *adColonyRewardVideoManager = nil;

@interface AdColonyRewardVideoManager() <AdColonyDelegate, AdColonyAdDelegate>

@property (nonatomic, strong) NSString *adId;
@property (nonatomic, strong) NSString *zoneId;

@end

@implementation AdColonyRewardVideoManager
+ (instancetype)sharedInstance
{
    if (nil == adColonyRewardVideoManager)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            adColonyRewardVideoManager = [[AdColonyRewardVideoManager alloc] init];
        });
    }
    return adColonyRewardVideoManager;
}

- (void)startWithId:(NSString *)adColonyId zoneId:(NSString *)zoneId
{
    if (!adColonyId || adColonyId.length ==0) {
        return;
    }
    if (!zoneId || zoneId.length == 0) {
        return;
    }
    
    self.adId = adColonyId;
    self.zoneId = zoneId;
    [AdColony configureWithAppID:adColonyId zoneIDs:@[zoneId] delegate:self logging:YES];
    NSLog(@"【Adcolony】Start");
}

- (void)play {
    if (self.zoneId) {
        [AdColony playVideoAdForZone:self.zoneId withDelegate:self withV4VCPrePopup:NO andV4VCPostPopup:NO];
        NSLog(@"【Adcolony】Video Played!");
    }
}

#pragma mark - AdColonyelegate
- (void)onAdColonyAdAvailabilityChange:(BOOL)available inZone:(NSString *)zoneID {
    if (available) {
        NSLog(@"【AdColony】 feed ads is ready ");
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoLoaded:)]) {
            [self.delegate videoLoaded:ZFRewardVideoTypeAdcolony];
        }
    } else {
        NSLog(@"【AdColony】 zone is loading ");
        if(self.delegate && [self.delegate respondsToSelector:@selector(videoLoading:)]) {
            [self.delegate videoLoading:ZFRewardVideoTypeAdcolony];
        }
    }
}

#pragma mark - AdColonyAdDelegate
- (void)onAdColonyAdStartedInZone:(NSString *)zoneID {
    NSLog(@"【Adcolony】Video start!");
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoWillStart:)]) {
        [self.delegate videoWillStart:ZFRewardVideoTypeAdcolony];
    }
}

- (void)onAdColonyAdAttemptFinished:(BOOL)shown inZone:(NSString *)zoneID {
    
    NSLog(@"【Adcolony】Video finished. zoneId:%@, isShown:%@", zoneID, shown? @"YES" : @"NO");
    if (shown && self.delegate && [self.delegate respondsToSelector:@selector(videoClosed:)]) {
        [self.delegate videoClosed:ZFRewardVideoTypeAdcolony];
    }
}


@end
