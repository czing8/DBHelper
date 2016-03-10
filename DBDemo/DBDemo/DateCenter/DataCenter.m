//
//  DataCenter.m
//  DBDemo
//
//  Created by Vols on 14/11/3.
//  Copyright (c) 2014年 Vols. All rights reserved.
//

#import "DataCenter.h"

@implementation DataCenter

+ (DataCenter *)shared{
    static DataCenter *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init{
    self = [super init];
    
    if (self) {
        
        _curUserID = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_Id"];
        
        //TODO:test
        _curUserID = @"1342";
        
    }
    return self;
}

- (AccountModel *)curAccount{
    __block AccountModel * tmpAccount = [[AccountModel alloc] init];
    
    [AccountDao queryAccountByUserID:_curUserID completion:^(AccountModel *account) {
        tmpAccount = account;
    }];
    
    return tmpAccount;
}

@end
