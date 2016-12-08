//
//  AppnextSDKCoreApi.h
//  AppnextSDKCore
//
//  Created by Eran Mausner on 14/08/2016.
//  Copyright © 2016 Appnext. All rights reserved.
//

@interface AppnextSDKCoreApi : NSObject

/**
 *  Get the version of this library/framework
 *
 */
+ (NSString *) getCoreVersion;

/**
 *  Get the API started get common resourses. This should be called at the start of the application's AppDelegate
 *  in the application:didFinishLaunchingWithOptions: function.
 *
 */
+ (void) startSDKApi;

/**
 *  Helper functions for plugins to turn creative type strings to ANCreativeType and back
 *
 */
+ (NSString *) getCreativeTypeString:(ANCreativeType)type;
+ (ANCreativeType) getCreativeTypeFromString:(NSString *)creativeTypeString;

/**
 *  Helper functions for plugins to turn progress type strings to ANProgressType and back
 *
 */
+ (NSString *) getProgressTypeString:(ANProgressType)progressType;
+ (ANProgressType) getANProgressTypeFromString:(NSString *)progressTypeString;

/**
 *  Helper functions for plugins to turn Video Length strings to ANVideoLength and back
 *
 */
+ (NSString *) getVideoLengthString:(ANVideoLength)videoLengthType;
+ (ANVideoLength) getANVideoLengthFromString:(NSString *)videoLengthString;

@end
