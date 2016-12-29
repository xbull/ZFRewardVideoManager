//
//  ZFRewardVideoManager.m
//
//  Created by Ruozi on 7/26/16.
//

#import "ZFRewardVideoManager.h"
#import "NSOrderedSet+FirstObject.h"
#import "ZFRewardVideoParameters.h"
#import "ZFRewardVideoDelegate.h"
#import "ZFRewardVideoMediator+Vungle.h"
#import "ZFRewardVideoMediator+Appnext.h"
#import "ZFRewardVideoMediator+Adcolony.h"
#import "ZFRewardVideoMediator+Unity.h"

#ifdef DEBUG
#define currentAdcID                @"appb48fbc995f0d45d89e"
#define currentAdcZoneID            @"vz27c8f3f391b54bf5ac"
#else
#define currentAdcID                kAdColonyId
#define currentAdcZoneID            kAdColonyZoneId
#endif

static ZFRewardVideoManager *instance;

@interface ZFRewardVideoManager () <ZFRewardVideoDelegate>

@property (nonatomic, strong)   NSString *vungleAppId;
@property (nonatomic, strong)   NSString *appNextPlacementId;
@property (nonatomic, strong)   NSString *adcolonyAppId;
@property (nonatomic, strong)   NSString *adcolonyZoneId;
@property (nonatomic, copy)     NSString *unityGameId;
@property (nonatomic, copy)     NSString *unityPlacementId;

@property (atomic, strong)      NSMutableOrderedSet *rewardVideoPool;
@property (nonatomic, strong)   NSMutableArray<NSNumber *> *videoCapArray;
@property (nonatomic, assign)   NSInteger readyVideoIndex;
@property (nonatomic)           BOOL   isPlaying;

@property (nonatomic, strong)   NSMutableArray<NSNumber *> *priorityIndicator;
@property (nonatomic, strong)   NSMutableDictionary *capIndicator;

@end

@implementation ZFRewardVideoManager

@synthesize status = _status;

#pragma mark - Forbid KVC
+ (BOOL)accessInstanceVariablesDirectly {
    return NO;
}

#pragma mark - Singleton
+ (instancetype)sharedInstance {
    
    if (nil == instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[ZFRewardVideoManager alloc] init];
            instance.rewardVideoPool = [NSMutableOrderedSet orderedSetWithCapacity:ZFRewardVideoTypeCount];
            instance.readyVideoIndex = NSNotFound;
            instance.videoCapArray = [NSMutableArray arrayWithCapacity:ZFRewardVideoTypeCount];
            instance.status = ZFRewardVideoStatusLoading;
            for (int i = 0; i < ZFRewardVideoTypeCount; i++) {
                [instance.videoCapArray addObject:@(0)];
            }
        });
    }
    
    return instance;
}

#pragma mark - Public methods
- (void)configVungleAppId:(NSString *)vungleAppId {
    self.vungleAppId = vungleAppId;
}

- (void)configAppnextPlacementId:(NSString *)placementId {
    self.appNextPlacementId = placementId;
}

- (void)configAdcolonyAppId:(NSString *)appId zoneId:(NSString *)zoneId {
    self.adcolonyAppId = appId;
    self.adcolonyZoneId = zoneId;
}

- (void)configUnityGameId:(NSString *)gameId placementId:(NSString *)placementId {
    self.unityGameId = gameId;
    self.unityPlacementId = placementId;
}

- (void)setPriority:(NSArray<NSNumber *> *)priorityArray {
    
    if (priorityArray.count > ZFRewardVideoTypeCount) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [priorityArray enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) self = weakSelf;
        [self.priorityIndicator replaceObjectAtIndex:obj.unsignedIntegerValue withObject:[NSNumber numberWithUnsignedInteger:idx]];
    }];
    
    NSLog(@"【ZFRewardVideoManager】order indicator:%@", self.priorityIndicator);
}

- (void)setCap:(NSInteger)cap platform:(ZFRewardVideoType)platform {
    
    [self.capIndicator setObject:@(cap) forKey:[ZFRewardVideoParameters platformNameForIndex:platform]];
}

- (void)start {
    
    static BOOL isStart = NO;
    
    if (isStart) {
        return;
    }
    
    if (self.adcolonyAppId && self.adcolonyZoneId && [[self.priorityIndicator objectAtIndex:ZFRewardVideoTypeAdcolony] unsignedIntegerValue] < ZFRewardVideoTypeCount) {
        [[ZFRewardVideoMediator sharedInstance] ZFRewardVideoMediator_setAdcolonyDelegate:instance];
        [[ZFRewardVideoMediator sharedInstance] ZFRewardVideoMediator_startAdcolonyWithAppId:self.adcolonyAppId zoneId:self.adcolonyZoneId];
    }
    
    if (self.vungleAppId && [[self.priorityIndicator objectAtIndex:ZFRewardVideoTypeVungle] unsignedIntegerValue] < ZFRewardVideoTypeCount) {
        [[ZFRewardVideoMediator sharedInstance] ZFRewardVideoMediator_setVungleDelegate:instance];
        [[ZFRewardVideoMediator sharedInstance] ZFRewardVideoMediator_startVungleWithAppId:self.vungleAppId];
    }
    
    if (self.appNextPlacementId && [[self.priorityIndicator objectAtIndex:ZFRewardVideoTypeAppNext] unsignedIntegerValue] < ZFRewardVideoTypeCount) {
        [[ZFRewardVideoMediator sharedInstance] ZFRewardVideoMediator_setAppnextDelegate:instance];
        [[ZFRewardVideoMediator sharedInstance] ZFRewardVideoMediator_startAppnextWithPlacementId:self.appNextPlacementId];
    }
    
    if (self.unityGameId && self.unityPlacementId && [self.priorityIndicator objectAtIndex:ZFRewardVideoTypeUnity].unsignedIntegerValue < ZFRewardVideoTypeCount) {
        [[ZFRewardVideoMediator sharedInstance] ZFRewardVideoMediator_setUnityDelegate:instance];
        [[ZFRewardVideoMediator sharedInstance] ZFRewardVideoMediator_startUnityWithGameId:self.unityGameId placementId:self.unityPlacementId];
    }
    
    isStart = YES;
}

- (void)play {
    
    if (self.isPlaying) {
        return;
    }
    
    if (ZFRewardVideoStatusReady != self.status) {
        return;
    }
    
    [self.rewardVideoPool sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [[self.priorityIndicator objectAtIndex:[obj1 unsignedIntegerValue]] compare:[self.priorityIndicator objectAtIndex:[obj2 unsignedIntegerValue]]];
    }];
    
    NSLog(@"【ZFRewardVideoManager】pool:%@", instance.rewardVideoPool);
    
    id indexObject = [instance.rewardVideoPool firstObjectSafe];
    if (indexObject) {
        ZFRewardVideoType index = [indexObject intValue];
        [self playVideo:index];
    }
}

#pragma mark - <RewardVideoDelegate>
- (void)videoLoaded:(ZFRewardVideoType)type {
    
    NSUInteger beforeCount = instance.rewardVideoPool.count;
    
    NSLog(@"【ZFRewardVideoManager】videoLoaded:%ld", (long)type);
    NSInteger cap = [[self.capIndicator valueForKey:[ZFRewardVideoParameters platformNameForIndex:type]] integerValue];
    NSInteger realCap;
    if (cap < 0) {
        realCap = 0;
    } else if (0 == cap) {
        realCap = [ZFRewardVideoParameters defaultSingleCap];
    } else {
        realCap = cap;
    }
    if (self.videoCapArray[type].integerValue < realCap) {
        NSLog(@"【ZFRewardVideoManager】video<%ld> add to the pool!", (long)type);
        [instance.rewardVideoPool addObject:@(type)];
        NSLog(@"【ZFRewardVideoManager】now the video pool status:%@!", instance.rewardVideoPool);
        
        if (!beforeCount) {
            NSLog(@"【ZFRewardVideoManager】Video did update status to [Loaded]!");
            self.status = ZFRewardVideoStatusReady;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(videoDidUpdateStatus:)]) {
                [self.delegate videoDidUpdateStatus:ZFRewardVideoStatusReady];
            }
        }
    } else {
        NSLog(@"【ZFRewardVideoManager】cap for platform [%ld] reaches the upper limit.", (long)type);
    }
}

- (void)videoLoading:(ZFRewardVideoType)type {
    
    NSUInteger beforeCount = instance.rewardVideoPool.count;
    
    [instance.rewardVideoPool removeObject:@(type)];
    NSLog(@"【ZFRewardVideoManager】videoLoading:%ld", (long)type);
    
    if (beforeCount && !instance.rewardVideoPool.count) {
        NSLog(@"【ZFRewardVideoManager】Video did update status to [Loading]!");
        self.status = ZFRewardVideoStatusLoading;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(videoDidUpdateStatus:)]) {
            [self.delegate videoDidUpdateStatus:ZFRewardVideoStatusLoading];
        }
    }
}

- (void)videoWillStart:(ZFRewardVideoType)type {
    
    NSLog(@"【ZFRewardVideoManager】video will start:%ld", (long)type);
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoWillStartPlaying)]) {
        [self.delegate videoWillStartPlaying];
    }
}

- (void)videoClosed:(ZFRewardVideoType)type {
    
    self.isPlaying = NO;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(videoDidFinished)]) {
        [self.delegate videoDidFinished];
    }
    //
}

#pragma mark - private methods
- (void)playVideo:(ZFRewardVideoType)index {
    
    NSLog(@"【ZFRewardVideoManager】Cap +1 for video %ld", (long)index);
    [self.videoCapArray replaceObjectAtIndex:index withObject:@(self.videoCapArray[index].integerValue + 1)];
    
    switch (index) {
        case ZFRewardVideoTypeAdcolony: {
            self.isPlaying = YES;
            [[ZFRewardVideoMediator sharedInstance] ZFRewardVideoMediator_playAdcolony];
        }
            break;
            
        case ZFRewardVideoTypeVungle: {
            self.isPlaying = YES;
            [[ZFRewardVideoMediator sharedInstance] ZFRewardVideoMediator_playVungleWithOptions:nil];
        }
            break;
        case ZFRewardVideoTypeApplovin: {
            self.isPlaying = YES;
//            [[DPApplovinRewardVideoManager sharedInstance] play];
        }
            break;
        case ZFRewardVideoTypeSupersonic: {
            self.isPlaying = YES;
//            [[ZFSupersonicRewardVideoManager sharedInstance] play];
        }
            break;
        case ZFRewardVideoTypeFyber: {
            self.isPlaying = YES;
//            [[ZFFyberRewardVideoManager sharedInstance] play];
        }
            break;
        case ZFRewardVideoTypeMobVista: {
            self.isPlaying = YES;
//            [[ZFMobvistaRewardVideoManager sharedInstance] play];
        }
            break;
        case ZFRewardVideoTypeAppNext: {
            self.isPlaying = YES;
            [[ZFRewardVideoMediator sharedInstance] ZFRewardVideoMediator_playAppnext];
        }
            break;
        case ZFRewardVideoTypeUnity: {
            self.isPlaying = YES;
            [[ZFRewardVideoMediator sharedInstance] ZFRewardVideoMediator_playUnity];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - getters
- (NSMutableArray<NSNumber *> *)priorityIndicator {
    if (!_priorityIndicator) {
        _priorityIndicator = [NSMutableArray<NSNumber *> arrayWithCapacity:ZFRewardVideoTypeCount];
        for (NSInteger i = 0; i < ZFRewardVideoTypeCount; i++) {
            [_priorityIndicator addObject:@(ZFRewardVideoTypeCount)];
        }
    }
    return _priorityIndicator;
}

- (NSMutableDictionary *)capIndicator {
    if (!_capIndicator) {
        _capIndicator = [NSMutableDictionary dictionary];
    }
    return _capIndicator;
}

#pragma mark - setters
- (void)setStatus:(ZFRewardVideoStatus)status {
    _status = status;
}

@end
