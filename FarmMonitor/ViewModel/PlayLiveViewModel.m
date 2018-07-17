//
//  PlayLiveViewModel.m
//  FarmMonitor
//
//  Created by guyunlong on 7/16/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import "PlayLiveViewModel.h"

@implementation PlayLiveViewModel
-(NSString*)getRtmpUrl{
   // "rtmp://"+sip+":1935/live/"+bid;
    NSString * rtmpUrl = [NSString stringWithFormat:@"rtmp://%@:1935/live/%@",_model.sip,_model.bid];
    return rtmpUrl;
}

@end
