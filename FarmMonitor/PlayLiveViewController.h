//
//  PlayLiveViewController.h
//  FarmMonitor
//
//  Created by guyunlong on 7/1/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayLiveViewModel.h"
@interface PlayLiveViewController : UIViewController
@property(nonatomic,strong)NSString * rtmpUrl;
@property(nonatomic,strong)PlayLiveViewModel* viewModel;

@end
