//
//  ZFRewardVideoManager.h
//
//  Created by Ruozi on 7/26/16.
//  Copyright © 2016 AppFinder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZFRewardVideoDelegate.h"

typedef enum {
    ZFRewardVideoStatusReady = 0,
    ZFRewardVideoStatusLoading
}ZFRewardVideoStatus;

@protocol ZFRewardVideoManagerDelegate <NSObject>

@optional

/**
 * If implemented, this will get called when video status changes.
 * It can be ZFRewardVideoStatusReady => ZFRewardVideoStatusLoading after video played
   or ZFRewardVideoStatusLoading => ZFRewardVideoStatusReady while one of the platform has loaded the video.
 
 * Usually implement this for UI change.

 @param status Indicates reward video status. 
 */
- (void)videoDidUpdateStatus:(ZFRewardVideoStatus)status;

/**
 
 * if implemented, this will get called when the manager is about to show an ad. This point
   might be a good time to pause your game, and turn off any sound you might be playing.
 
 */
- (void)videoWillStartPlaying;

/**
 
 * if implemented, this will get called when the video finish playing. This point might be a 
   good time to give some reward to user.

 */
- (void)videoDidFinished;

@end

@interface ZFRewardVideoManager : NSObject

/**
 @return return the singleton instance;
 */
+ (instancetype)sharedInstance;

// =============================>   Platform Info Config    <==============================[Begin]


/**
 Set Vungle app id to load vungle videos.
 
 @param vungleAppId : Your vungle app id. You can get it from : http://v.vungle.com
 */
- (void)configVungleAppId:(NSString *)vungleAppId;

/**
 Set Appnext placement to load appnext videos.
 
 @param placementId : Your appnext placement id. You can get it from : http://www.appnext.com
 */
- (void)configAppnextPlacementId:(NSString *)placementId;

/**
 Set Adcolony appId and zoneId to load adcolony videos.
 
 @param appId : Your adcolony appId.
 @param zoneId : Your adcolony zoneId.
 * You can get the two params above from : http://www.adcolony.com
 */
- (void)configAdcolonyAppId:(NSString *)appId zoneId:(NSString *)zoneId;
// =============================>   Platform Info Config    <================================[End]

// ===========================>   Platform Dispatch Config    <============================[Begin]

/**
 Set the priority for all platforms to determine the priority for video playing order when they are simultaneously loaded.

 @param priorityArray : And array indicates the priority of the platforms, elements is Nsnumber form of ZFRewardVideoType enum.
                        (e.g. @[@(ZFRewardVideoTypeAdcolony), @(ZFRewardVideoTypeAppNext), @(ZFRewardVideoTypeVungle)]
 
 * [Warning] !!! : You must set priority for the platform that you want to load and play videos. 
 * That is, If you don't set the priority of platform A, even if you've configured the app info for platform A, the video from platform A will not be loaded.
 */
- (void)setPriority:(NSArray<NSNumber *> *)priorityArray;

/**
 Set the maximum video play upper limit for certain platform during one app life cycle.
 If the video of this platform reaches this cap, manager will play other platforms' video next time according to the priority.

 @param cap : Upper limit for video play during one app lifecycle.
 @param platform : Platform the cap should be setted for.
 */
- (void)setCap:(NSUInteger)cap platform:(ZFRewardVideoType)platform;

// ===========================>   Platform Dispatch Config    <==============================[End]

/**
 
 * Start to initialize all platforms which are configured by the [Platform Info Config] functions and start to load videos.
 * It's a good time to do this when enter into home page.
 * [Warning] : Call this after calling [Platform Info Config] and [Platform Dispatch Config] functions.
 
 */
- (void)start;

/**

 @return return the status of videos. Often called when load UI.
 */
- (ZFRewardVideoStatus)getStatus;

/**
 
 * Videos will be played according to the priority and cap after this called.
 
 */
- (void)play;

@property (nonatomic, weak) id<ZFRewardVideoManagerDelegate> delegate;

@end
