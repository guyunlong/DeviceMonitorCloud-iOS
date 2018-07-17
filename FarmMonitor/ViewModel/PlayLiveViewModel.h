//
//  PlayLiveViewModel.h
//  FarmMonitor
//
//  Created by guyunlong on 7/16/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BoxModel.h"
@interface PlayLiveViewModel : NSObject
@property(nonatomic,strong)BoxModel*model;
-(NSString*)getRtmpUrl;
-(void)callVideo;
-(void)heartbeat;
-(void)setImdHeartBeat;
@end
