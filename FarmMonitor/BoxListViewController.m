//
//  BoxListViewController.m
//  FarmMonitor
//
//  Created by guyunlong on 6/17/18.
//  Copyright © 2018 farm. All rights reserved.
//

#import "BoxListViewController.h"
#import <Masonry/Masonry.h>
#import "MASConstraint.h"
#import "BoxCell.h"
#import "MJRefresh.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "FarmGetManager.h"
#import "AccountManager.h"
#import "UITableView+Common.h"
#import "UIViewController+HUD.h"
#import "NSString+Common.h"
#import "PlayLiveViewController.h"
@interface BoxListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *myTableView;//
@property (strong,nonatomic) NSArray * boxList;
@end

@implementation BoxListViewController

-(void)loadView{
    [super loadView];
    
    if (!_myTableView) {
        _myTableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [tableView setUserInteractionEnabled:true];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView;
        });
    }
    [self.view addSubview:_myTableView];
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    // 下拉刷新
    @weakify(self)
    _myTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //
        @strongify(self);
        [self refreshBoxList];
    }];
    
    
    
}
-(void)refreshBoxList{
   @weakify(self)
    [FarmGetManager getBoxList:[AccountManager getUser] password:[AccountManager getPwd] success:^(id data) {
         @strongify(self)
        self.boxList = data;
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self hideHud];
    } failure:^(int errorcode) {
        [self hideHud];
        [self.myTableView.mj_header endRefreshing];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitle:@"设备列表".localizedString];
    [self showHudInView:self.view hint:@""];
    [self refreshBoxList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _boxList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoxCell * cell = [BoxCell BoxCellWith:tableView indexPath:indexPath];
    [cell setModel:_boxList[indexPath.row]];
    [cell setFrame:CGRectMake(0, 0,self.view.frame.size.width, 45)];
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BoxModel*model = _boxList[indexPath.row];
    if (!model.ste) {
        [self showHint:@"设备离线，无法观看视频"];
        return;
    }
    
  
    PlayLiveViewController *ctl =[PlayLiveViewController new];
    PlayLiveViewModel * viewModel = [PlayLiveViewModel new];
    [viewModel setModel:_boxList[indexPath.row]];
    [ctl setViewModel:viewModel];
    [self.navigationController pushViewController:ctl animated:YES];
}



@end
