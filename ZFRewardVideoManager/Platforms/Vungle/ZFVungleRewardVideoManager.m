//
//  ZFVungleRewardVideoManager.m
//  GiftGame
//
//  Created by Ruozi on 8/17/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "ZFVungleRewardVideoManager.h"
#import <VungleSDK/VungleSDK.h>
#import "ZFCommon.h"

@interface ZFVungleRewardVideoManager () <VungleSDKDelegate, VungleSDKLogger>

@property (nonatomic, copy) NSString *appId;

@end

@implementation ZFVungleRewardVideoManager

#pragma mark - Singleton
+ (instancetype)sharedInstance {
    static ZFVungleRewardVideoManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZFVungleRewardVideoManager alloc] init];
    });
    return instance;
}

#pragma mark - Public methods
- (void)startWithAppId:(NSString *)appId {
    
    if (!appId || appId.length == 0) {
        NSLog(@"【VungleRewardVideoManager】appId nil!");
        return;
    }
    
    self.appId = appId;
    
    [[VungleSDK sharedSDK] startWithAppId:appId];
    [[VungleSDK sharedSDK] setDelegate:self];
    [[VungleSDK sharedSDK] attachLogger:self];
    
    NSLog(@"【VungleRewardVideoManager】start with appID:%@!", appId);
}

- (void)playWithOptions:(NSDictionary *)options {
    NSError *error = nil;
    [[VungleSDK sharedSDK] playAd:[ZFCommon getTopmostViewController] withOptions:options error:&error];
    NSLog(@"【VungleRewardVideoManager】Play video with error:%@", error);
}

#pragma mark - VungleSDKDelegate
- (void)vungleSDKAdPlayableChanged:(BOOL)isAdPlayable {
    
    NSLog(@"【VungleRewardVideoManager】Video playable changed to :%@", isAdPlayable? @"Playable" : @"Unavailable");
    if (isAdPlayable) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(videoLoaded:)]) {
            [self.delegate videoLoaded:ZFRewardVideoTypeVungle];
        }
    } else {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(videoLoading:)]) {
            [self.delegate videoLoading:ZFRewardVideoTypeVungle];
        }
    }
}

- (void)vungleSDKwillShowAd {
    NSLog(@"【ZFVungleRewardVideoManager】SDK will show ad");
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoWillStart:)]) {
        [self.delegate videoWillStart:ZFRewardVideoTypeVungle];
    }
}

- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary *)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet {
    
    NSLog(@"【VungleRewardVideoManager】Video will closed with info:%@", viewInfo);
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoClosed:)]) {
        [self.delegate videoClosed:ZFRewardVideoTypeVungle];
    }
}

#pragma mark - VungleSDKLogger
- (void)vungleSDKLog:(NSString *)message {
    NSLog(@"【VungleSDKLogger】%@", message);
}

@end
