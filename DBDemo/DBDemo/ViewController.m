//
//  ViewController.m
//  DBDemo
//
//  Created by Vols on 14/11/3.
//  Copyright (c) 2014年 Vols. All rights reserved.
//

#import "ViewController.h"

#import "DataCenter.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
