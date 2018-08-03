//
//  PlayLiveViewModel.h
//  FarmMonitor
//
//  Created by guyunlong on 7/16/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoxModel.h"
typedef NS_ENUM(NSInteger, ControlPtzType)
{
    ControlPtzType_up = 0,
     ControlPtzType_down,
    ControlPtzType_left,
    ControlPtzType_right,
     ControlPtzType_zoom0,
    ControlPtzType_zoom1
};


@interface PlayLiveViewModel : NSObject
@property(nonatomic,strong)BoxModel*model;
-(NSString*)getRtmpUrl;
-(void)callVideo;
-(void)heartbeat;
-(void)controlPtz:(ControlPtzType)type;
-(void)setImdHeartBeat;
-(void)stopTimer;
@end
