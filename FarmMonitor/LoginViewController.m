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
#import <Masonry/Masonry.h>
#import "LoginViewModel.h"
#import "NSString+Common.h"
#import "BoxListViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "AccountManager.h"
#import "LoginEditCell.h"
#import "OCHeader.h"
@interface LoginViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UIImageView *backgroundView;//
@property (strong, nonatomic) UIImageView *headerView;
@property (strong, nonatomic) UITableView *myTableView;//
@property (strong, nonatomic) UIButton *loginBtn;//



@property(nonatomic,strong) LoginViewModel * viewModel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view, typically from a nib.
    
     [self initView];
    
    _viewModel = [LoginViewModel new];
//    [_userField setPlaceholder:@"hintUser".localizedString];
//    [_passwordField setPlaceholder:@"hintPassword".localizedString];
//    [_loginButton setTitle:@"login".localizedString forState:UIControlStateNormal];
//    [_userField setText:[AccountManager getUser]];
//    [_passwordField setText:[AccountManager getPwd]];
//    RAC(self.viewModel, username)  = self.userField.rac_textSignal;
//    RAC(self.viewModel, password)  = self.passwordField.rac_textSignal;
    RAC(_loginBtn,enabled) = self.viewModel.validLoginSignal;
    [_loginBtn addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}


-(void)initView{
    if (!_backgroundView) {
        _backgroundView = [UIImageView new];
        //43 152 216
        [_backgroundView setImage:[UIImage imageWithColor:appColor]];
        [self.view addSubview:_backgroundView];
    }
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
//    if (!_headerView) {
//        _headerView = [UIImageView new];
//
//        [_headerView setImage:[UIImage imageNamed:@"loginheader"]];
//
//        
//        
//        [self.view addSubview:_headerView];
//    }
//    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//
//            make.centerX.mas_equalTo(self.view.mas_centerX);
//            make.top.mas_equalTo(self.view.mas_top).with.offset(80);
//            make.height.equalTo(@120);
//            make.width.equalTo(@(403*120/262));
//
//        }
//
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//
//    }];
    if (!_myTableView) {
        _myTableView = ({
            TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            [tableView registerClass:[LoginEditCell class] forCellReuseIdentifier:LoginEditCellIdentify];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            // [tableView setBackgroundColor:[UIColor redColor]];
            [tableView setUserInteractionEnabled:true];
            tableView.scrollEnabled = NO;
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.layer.masksToBounds = true;
            tableView.layer.cornerRadius = 10;
            tableView.layer.borderColor = [UIColor colorWithHexString:@"0xaaaaaa"].CGColor;
            tableView.layer.borderWidth=0.5;
            tableView.rowHeight = UITableViewAutomaticDimension;
            tableView;
        });
    }
    [self.view addSubview:_myTableView];
    @weakify(self)
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
            make.top.mas_equalTo(self.view.mas_top).with.offset(220*kScreenHeight/667);
            make.left.mas_equalTo(self.view).with.offset(30);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-30);
            make.height.mas_equalTo(2*[LoginEditCell cellHeight]);
    }];
    //登录按钮
    
    if (!_loginBtn) {
        _loginBtn = [UIButton new];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        //43 152 216
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"normal"] forState:UIControlStateNormal];
        _loginBtn.layer.masksToBounds = true;
        _loginBtn.layer.cornerRadius = 10;
    }
    [self.view addSubview:_loginBtn];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.mas_equalTo(self.myTableView.mas_bottom).with.offset(30);
        make.left.mas_equalTo(self.view).with.offset(30);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-30);
        make.height.mas_equalTo(40);
    }];
    
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

#pragma mark Table M
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = [indexPath row];
    LoginEditCell *cell = [tableView dequeueReusableCellWithIdentifier:LoginEditCellIdentify forIndexPath:indexPath];
    if (0 == row) {
        [tableView addLineforRegPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
    }
    [cell setRow:row];
    @weakify(self)
    cell.textChangeBlock = ^(NSInteger row,id value){
        @strongify(self)
        if(0 == row){
            [self.viewModel setUsername:value];
        }
        else if(1 == row){
            [self.viewModel setPassword:value];
        }
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LoginEditCell cellHeight];
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
