//
//  Target_Unity.h
//  ZFRewardVideoDemo
//
//  Created by Dai Pei on 2016/12/9.
//  Copyright © 2016年 Ruozi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Target_Unity : NSObject

- (void)Action_setDelegate:(NSDictionary *)params;

- (void)Action_startWithInfo:(NSDictionary *)params;

- (void)Action_playWithOption:(NSDictionary *)params;

@end
