//
//  ViewController.m
//  DBDemo
//
//  Created by Vols on 14/11/3.
//  Copyright (c) 2014年 Vols. All rights reserved.
//

#import "ViewController.h"

#import "DataCenter.h"
#import "SearchHistoryDao.h"


@interface ViewController ()

@property (nonatomic, strong) AccountModel * account;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    
    [self writeToDB];
    [self updateDB];
    [self readFromDB];
    
    NSLog(@"dataCenter::%@",  [DataCenter shared].curAccount.nickname);
}

- (void)initData{
    _account = [[AccountModel alloc] init];
    _account.userID = @"1342";
    _account.phoneNum = @"15701235332";
    _account.birthday = @"23-23";
    _account.flavor = @"23";
    _account.nickname = @"er";
}

- (void)writeToDB{
    
    [AccountDao insertAccount:_account completion:^(BOOL success) {
        if (success) {
            NSLog(@"%s --> account",__FUNCTION__);
        }
    }];
}

- (void)updateDB{
    _account.nickname = @"sure";
    
    [AccountDao updateAccount:_account completion:^(BOOL success) {
        NSLog(@"%s --> %d",__FUNCTION__, success);
    }];
}

- (void)readFromDB{
    [AccountDao queryAccountByUserID:@"1342" completion:^(AccountModel *account) {
        NSLog(@"%s --> %@", __FUNCTION__, account.nickname);
    }];
}

- (IBAction)insertAction:(id)sender {
    AccountModel * model = [[AccountModel alloc] init];
    model.userID = [NSString stringWithFormat:@"%u", arc4random()%1000];
    model.phoneNum = @"15701235332";
    model.birthday = @"23-23";
    model.flavor = @"23";
    model.nickname = @"er";
    
    [SearchHistoryDao insertSearchAccountHistory:model historyType:HistoryType100 successBlock:^(BOOL success) {
        NSLog(@"%d",success);
    }];
}

- (IBAction)deleteAction:(id)sender {
    [SearchHistoryDao deleteAllHistoryType:HistoryType100 successBlock:^(BOOL success) {
        NSLog(@"%d",success);
        
    }];
}

- (IBAction)updateAction:(id)sender {

}

- (IBAction)queryAction:(id)sender {
    
    
    [SearchHistoryDao queryAccountHistoryType:HistoryType100 historyData:^(NSArray *historys) {
        for (AccountModel * obj in historys) {
            NSLog(@"stock --> %@", obj.userID);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
