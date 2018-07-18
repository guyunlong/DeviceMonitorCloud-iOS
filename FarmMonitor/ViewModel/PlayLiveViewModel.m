//
//  PlayLiveViewModel.m
//  FarmMonitor
//
//  Created by guyunlong on 7/16/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import "PlayLiveViewModel.h"
#import "FFHttpTool.h"

@interface PlayLiveViewModel()
@property(nonatomic,strong)NSTimer * timer;
@end


@implementation PlayLiveViewModel

-(NSString*)getRtmpUrl{
   // "rtmp://"+sip+":1935/live/"+bid;
    NSString * rtmpUrl = [NSString stringWithFormat:@"rtmp://%@:1935/live/%@",_model.sip,_model.bid];
    return rtmpUrl;
}
-(void)callVideo{
    //"http://"+sip+":1936/svr.php?act=cts&bid="+bid+"&pm1=1&pm2=1";
    NSString * url = [NSString stringWithFormat:@"http://%@:1936/svr.php?act=cts&bid=%@&pm1=1&pm2=1",_model.sip,_model.bid];
    [FFHttpTool GET:url parameters:nil success:^(id succss) {
        
        [self heartbeat];
        [self startTimer];
    } failure:^(NSError * error) {
        NSLog(@"error is %@",error.localizedDescription);
        
    }];
}
-(void)heartbeat{
    //String url ="http://"+Utils.sIp+"/svr/fls.php?act=hbt&bid="+bid;
    NSString * url = [NSString stringWithFormat:@"http://www.mowa-cloud.com/svr/fls.php?act=hbt&bid=%@",_model.bid];
    [FFHttpTool GET:url parameters:nil success:^(id succss) {
        
       
    } failure:^(NSError * error) {
        NSLog(@"error is %@",error.localizedDescription);
       
    }];
}
//让前端立刻获取心跳
-(void)setImdHeartBeat{
   // String url ="http://"+sip+":1936/svr.php?act=cts&bid="+bid+"&pm1=6";
    NSString * url = [NSString stringWithFormat:@"http://%@:1936/svr.php?act=cts&bid=%@&pm1=6",_model.sip,_model.bid];
    [FFHttpTool GET:url parameters:nil success:^(id succss) {
        
        
    } failure:^(NSError * error) {
        NSLog(@"error is %@",error.localizedDescription);
        
    }];
}
-(void)startTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:4 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self heartbeat];
    }];
}
-(void)stopTimer{
    [_timer invalidate];
    _timer = nil;
}



@end
