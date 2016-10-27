//
//  PlayerListViewController.m
//  FiveChessGame
//
//  Created by 邓西亮 on 16/10/26.
//  Copyright © 2016年 dxl. All rights reserved.
//

#import "PlayerListViewController.h"
#import "UDPSendManager.h"
#import "UDPReciveManager.h"
#import "GameViewController.h"

@interface PlayerListViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UITableView *playerList;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) NSMutableArray *players;

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation PlayerListViewController

#pragma mark ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.playerList];
    [self.view addSubview:self.backButton];
    
    [[UDPReciveManager shareManager] setSendMessage];
    [[UDPSendManager shareManager] SendFirstManagerWith];
    
    __weak typeof (self) weakSelf = self;
    [UDPReciveManager shareManager].deviceInfoBlock = ^(NSString *device){
        
        if (weakSelf.players.count == 0) {
              [[UDPSendManager shareManager] SendFirstManagerWith];
        }
        [weakSelf.players addObject:device];
        [weakSelf.playerList reloadData];
    };
}

#pragma mark somethingMethods
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark tableViewDelegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.players.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.players[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GameViewController *pre = [[GameViewController alloc] init];
    [self presentViewController:pre animated:YES completion:nil];
}

#pragma mark setter getter Methods
- (UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        _topLabel.backgroundColor = [UIColor grayColor];
        _topLabel.text = @"搜索周边玩家中...";
        _topLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabel;
}

- (UITableView *)playerList
{
    if (!_playerList) {
        _playerList = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
        _playerList.delegate = self;
        _playerList.dataSource = self;
        [_playerList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _playerList;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(30, 400, 60, 60);
        _backButton.layer.cornerRadius = 30;
        [_backButton setTitle:@"back" forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _backButton.backgroundColor = [UIColor redColor];
    }
    return _backButton;
}

- (NSMutableArray *)players
{
    if (!_players) {
        _players = @[].mutableCopy;
    }
    return _players;
}

#pragma mark dellec
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
