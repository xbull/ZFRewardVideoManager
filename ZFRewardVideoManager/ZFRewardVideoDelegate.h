//
//  ZFRewardVideoDelegate.h
//
//  Created by Ruozi on 1/27/16.

#ifndef RewardVideoAdsDelegate_H
#define RewardVideoAdsDelegate_H

// This definition indicates either the type of RV or the priority they play
typedef NS_ENUM(NSInteger, ZFRewardVideoType) {
    ZFRewardVideoTypeVungle = 0,
    ZFRewardVideoTypeApplovin,
    ZFRewardVideoTypeAdcolony,
    ZFRewardVideoTypeSupersonic,
    ZFRewardVideoTypeNativeX,
    ZFRewardVideoTypeFyber,
    ZFRewardVideoTypeMobVista,
    ZFRewardVideoTypeAppNext,
    ZFRewardVideoTypeUnity,
    ZFRewardVideoTypeCount
};

@protocol ZFRewardVideoDelegate <NSObject>

- (void)videoLoaded:(ZFRewardVideoType)type;

- (void)videoLoading:(ZFRewardVideoType)type;

- (void)videoWillStart:(ZFRewardVideoType)type;

- (void)videoClosed:(ZFRewardVideoType)type;

@end

#endif
