//
//  ViewController.m
//  FarmMonitor
//
//  Created by guyunlong on 6/17/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import "LoginViewController.h"
#import "UIViewController+HUD.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "LoginViewModel.h"
#import "NSString+Common.h"
#import "BoxListViewController.h"
#import "AccountManager.h"
@interface LoginViewController ()
@property(nonatomic,weak)IBOutlet UITextField * userField;
@property(nonatomic,weak)IBOutlet UITextField * passwordField;
@property(nonatomic,weak)IBOutlet UIButton * loginButton;
@property(nonatomic,strong) LoginViewModel * viewModel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view, typically from a nib.
    
    _viewModel = [LoginViewModel new];
    [_userField setPlaceholder:@"hintUser".localizedString];
    [_passwordField setPlaceholder:@"hintPassword".localizedString];
    [_loginButton setTitle:@"login".localizedString forState:UIControlStateNormal];
    [_userField setText:[AccountManager getUser]];
    [_passwordField setText:[AccountManager getPwd]];
    RAC(self.viewModel, username)  = self.userField.rac_textSignal;
    RAC(self.viewModel, password)  = self.passwordField.rac_textSignal;
    RAC(_loginButton,enabled) = self.viewModel.validLoginSignal;
    [_loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)loginButtonClicked{
    [self showHudInView:self.view hint:@""];
    @weakify(self)
    [[_viewModel racLogin] subscribeNext:^(id x) {
        @strongify(self)
        if ([x integerValue] == 1) {
            //登录成功
            BoxListViewController * ctl = [BoxListViewController new];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:ctl];
            [self presentViewController:nav animated:TRUE completion:nil];
            
            
        }
        else{
            //显示错误码
            [self showHint:[NSString stringWithFormat:@"%@,error code is %@",@"loginerror".localizedString,x]];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
