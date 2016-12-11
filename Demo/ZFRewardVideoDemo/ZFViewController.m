//
//  ViewController.m
//  ZFRewardVideoDemo
//
//  Created by Ruozi on 11/25/16.
//  Copyright © 2016 Ruozi. All rights reserved.
//

#import "ZFViewController.h"
#import <Masonry/Masonry.h>
#import "ZFRewardVideoManager.h"
#import <Toast/UIView+Toast.h>

@interface ZFViewController () <ZFRewardVideoManagerDelegate>

@property (nonatomic, strong) UIButton *videoPlayButton;

@end

@implementation ZFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureViews];
    
    [self configureRewardVideo];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureViews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.videoPlayButton];
    [self.videoPlayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).multipliedBy(0.8f);
        make.width.equalTo(self.view).multipliedBy(0.4f);
        make.height.mas_equalTo(50);
    }];
}

- (void)configureRewardVideo {
    
    [ZFRewardVideoManager sharedInstance].delegate = self;
    [[ZFRewardVideoManager sharedInstance] configVungleAppId:@"57a9883caeabb1ce4b000058"];
    [[ZFRewardVideoManager sharedInstance] configAppnextPlacementId:@"c655c6af-d835-43df-bce9-a1634bf95abc"];
    [[ZFRewardVideoManager sharedInstance] configUnityGameId:@"1227091" placementId:@"video"];
    [[ZFRewardVideoManager sharedInstance] configAdcolonyAppId:@"app86b86d6bc5bc4ef2b5" zoneId:@"vz22069ee8f2e3429489"];
    [[ZFRewardVideoManager sharedInstance] setPriority:@[@(ZFRewardVideoTypeVungle),
                                                         @(ZFRewardVideoTypeUnity),
                                                         @(ZFRewardVideoTypeAdcolony),
                                                         @(ZFRewardVideoTypeAppNext)]];
    [[ZFRewardVideoManager sharedInstance] setCap:2 platform:ZFRewardVideoTypeAppNext];
    [[ZFRewardVideoManager sharedInstance] setCap:1 platform:ZFRewardVideoTypeAdcolony];
    [[ZFRewardVideoManager sharedInstance] start];
}

#pragma mark - <ZFRewardVideoManagerDelegate>
- (void)videoDidUpdateStatus:(ZFRewardVideoStatus)status {
    NSLog(@"【ZFViewController】Video status update : %@", (status == ZFRewardVideoStatusReady) ? @"Ready" : @"Loading");
    
    if (ZFRewardVideoStatusReady == status) {
        [self.videoPlayButton setEnabled:YES];
    } else {
        [self.videoPlayButton setEnabled:NO];
    }
}

- (void)videoWillStartPlaying {
    NSLog(@"【ZFViewController】Video will start playing!");
    [self.view hideToastActivity];
}

- (void)videoDidFinished {
    NSLog(@"【ZFViewController】Video did finish");
}

#pragma mark - Action methods
- (void)onVideoPlay {
    
    [self.view makeToastActivity:CSToastPositionCenter];
    
    [[ZFRewardVideoManager sharedInstance] play];
    NSLog(@"【ZFViewController】Video play button clicked!");
}

#pragma mark - Getters
- (UIButton *)videoPlayButton {
    if (!_videoPlayButton) {
        _videoPlayButton = [[UIButton alloc] init];
        [_videoPlayButton setTitle:@"Loading" forState:UIControlStateDisabled];
        [_videoPlayButton setTitle:@"Play" forState:UIControlStateNormal];
        [_videoPlayButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_videoPlayButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        _videoPlayButton.backgroundColor = [UIColor lightGrayColor];
        [_videoPlayButton addTarget:self action:@selector(onVideoPlay) forControlEvents:UIControlEventTouchUpInside];
        _videoPlayButton.enabled = NO;
    }
    return _videoPlayButton;
}

@end
