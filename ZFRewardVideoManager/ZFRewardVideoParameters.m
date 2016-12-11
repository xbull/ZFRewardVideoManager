//
//  ZFRewardVideoParameters.m
//
//  Created by Ruozi on 11/2/16.

#import "ZFRewardVideoParameters.h"

@implementation ZFRewardVideoParameters

+ (NSString *)platformNameForIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return @"Vungle";
            break;
            
        case 1:
            return @"Applovin";
            break;
            
        case 2:
            return @"Adcolony";
            break;
            
        case 3:
            return @"Supersonic";
            break;
            
        case 4:
            return @"NativeX";
            break;
            
        case 5:
            return @"Fyber";
            break;
            
        case 6:
            return @"Mobvista";
            break;
            
        case 7:
            return @"Appnext";
            break;
            
        case 8:
            return @"unity";
            break;
            
        default:
            return @"Unknown";
            break;
    }
}

@end
