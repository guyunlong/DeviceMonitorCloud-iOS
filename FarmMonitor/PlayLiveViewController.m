//
//  PlayLiveViewController.m
//  FarmMonitor
//
//  Created by guyunlong on 7/1/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import "PlayLiveViewController.h"
#import <PLPlayerKit/PLPlayerKit.h>
#import "OCHeader.h"
@interface PlayLiveViewController ()<PLPlayerDelegate>
@property(nonatomic,strong)PLPlayer * player;
@property(nonatomic,strong)UIButton * exitBtn;
@end

@implementation PlayLiveViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [_viewModel stopTimer];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    // Do any additional setup after loading the view.
    [_viewModel callVideo];
    
    [self rotate];
    
    [self initPlayer];
    [self initControlView];
    
    [self showHudInView:self.view hint:nil];
    
    
}
-(void)rotate{
    
   
    
    //设置视图旋转
    self.view.bounds = CGRectMake(0, 0,kScreenHeight , kScreenWidth);
    self.view.transform = CGAffineTransformMakeRotation(M_PI*0.5);
    [UIView beginAnimations:nil context:nil];
    [UIView commitAnimations];
    
}



-(void)initPlayer{
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    
    // 更改需要修改的 option 属性键所对应的值
    [option setOptionValue:@1 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
    [option setOptionValue:@1 forKey:PLPlayerOptionKeyMaxL1BufferDuration];
    [option setOptionValue:@1 forKey:PLPlayerOptionKeyMaxL2BufferDuration];
    [option setOptionValue:@(NO) forKey:PLPlayerOptionKeyVideoToolbox];
    [option setOptionValue:@(kPLLogInfo) forKey:PLPlayerOptionKeyLogLevel];
    
    self.player = [PLPlayer playerWithURL:[NSURL URLWithString:[_viewModel getRtmpUrl]] option:option];
    
    // 设定代理 (optional)
    self.player.delegate = self;
    
    [self.player.playerView setFrame:CGRectMake(0, 0, kScreenHeight,kScreenWidth)];
    [self.view addSubview:self.player.playerView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self.player play];
    });
   
    /*
     // 播放
     [self.player play];
     
     // 停止
     [self.player stop];
     
     // 暂停
     [self.player pause];
     
     // 继续播放
     [self.player resume];
     */
    
}

-(void)initControlView{
    if (!_exitBtn) {
        _exitBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenHeight-50, 10, 40, 40)];
        [_exitBtn addTarget:self action:@selector(exitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_exitBtn setImage:[UIImage imageNamed:@"icon_shut_down"] forState:UIControlStateNormal];
        [self.view addSubview:_exitBtn];
    }
}
-(void)exitBtnClicked{
    [self.player stop];
    [self.navigationController popViewControllerAnimated:YES];
}

// 实现 <PLPlayerDelegate> 来控制流状态的变更
- (void)player:(nonnull PLPlayer *)player statusDidChange:(PLPlayerStatus)state {
    // 这里会返回流的各种状态，你可以根据状态做 UI 定制及各类其他业务操作
    // 除了 Error 状态，其他状态都会回调这个方法
    // 开始播放，当连接成功后，将收到第一个 PLPlayerStatusCaching 状态
    // 第一帧渲染后，将收到第一个 PLPlayerStatusPlaying 状态
    // 播放过程中出现卡顿时，将收到 PLPlayerStatusCaching 状态
    // 卡顿结束后，将收到 PLPlayerStatusPlaying 状态
}

- (void)player:(nonnull PLPlayer *)player stoppedWithError:(nullable NSError *)error {
    [self hideHud];
    [self showHint:@"cann't play the stream"];
    [self exitBtnClicked];
    // 当发生错误，停止播放时，会回调这个方法
}

- (void)player:(nonnull PLPlayer *)player codecError:(nonnull NSError *)error {
    // 当解码器发生错误时，会回调这个方法
    // 当 videotoolbox 硬解初始化或解码出错时
    // error.code 值为 PLPlayerErrorHWCodecInitFailed/PLPlayerErrorHWDecodeFailed
    // 播发器也将自动切换成软解，继续播放
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)player:(nonnull PLPlayer *)player firstRender:(PLPlayerFirstRenderType)firstRenderType {
   //音视频渲染首帧回调通知
    //关闭加载动画
    [self hideHud];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
