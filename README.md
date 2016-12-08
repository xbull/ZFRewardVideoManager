# ZFRewardVideoManager
ZFRewardVideoManager is an integration of all mainstream reward video platforms. You can monetize your app by reward video with simple API and dispatch reward videos by priority. And you can also integrate/delete certain RV platform just by adding/deleting one line code in ```Podfile``` without changing any code in your project.

## Supported RV Platforms

- Vungle
- Appnext
- Adcolony

## Features

- Integrate multiple RV platforms.
- Customize platform priority in order to adjust video play order.
- You can set cap for each platform during one app life cycle to limit play counts for single user.
- Integrate/Delete certain RV platform by just one line code without any code modification in your project. 

## Installation

```
pod 'ZFRewardVideoManager/Vungle', :git => 'git@github.com:ruozi/ZFRewardVideoManager.git'
pod 'ZFRewardVideoManager/Appnext', :git => 'git@github.com:ruozi/ZFRewardVideoManager.git'
pod 'ZFRewardVideoManager/Adcolony', :git => 'git@github.com:ruozi/ZFRewardVideoManager.git'
```
You can delete certain line if you don't need to play the videos from that platform.

## Usage

### Initialize

Initialize and start to load videos. Usually use when user enters the homepage of your app.

```objc
[ZFRewardVideoManager sharedInstance].delegate = self;
[[ZFRewardVideoManager sharedInstance] configVungleAppId:{vungle_appId}];
[[ZFRewardVideoManager sharedInstance] configAppnextPlacementId:{appnext_placementId}];
[[ZFRewardVideoManager sharedInstance] configAdcolonyAppId:{adcolony_appId} zoneId:{adcolony_zoneId}];
[[ZFRewardVideoManager sharedInstance] setPriority:@[@(ZFRewardVideoTypeAdcolony),
                                                     @(ZFRewardVideoTypeAppNext),
                                                     @(ZFRewardVideoTypeVungle)]];
[[ZFRewardVideoManager sharedInstance] setCap:2 platform:ZFRewardVideoTypeAppNext];
[[ZFRewardVideoManager sharedInstance] setCap:1 platform:ZFRewardVideoTypeAdcolony];
[[ZFRewardVideoManager sharedInstance] start];
```
**Notice** : You must set priority for a platform if you want to play videos from it.

### Play Video

Call this function to start playing video(If any video has been loaded).
```objc
[[ZFRewardVideoManager sharedInstance] play];
```
### Status Change

```ZFRewardVideoManagerDelegate``` indicates the status for the reward videos.
Usually implemented for UI changes.

## Reference

To avoid namespace duplication. This project changes ```CTMediator``` file name.

**CTMediator** by casa : [https://github.com/casatwy/CTMediator](https://github.com/casatwy/CTMediator)
