//
//  AccountDao.m
//  DBDemo
//
//  Created by Vols on 14/11/3.
//  Copyright (c) 2014年 Vols. All rights reserved.
//

#import "AccountDao.h"
#import "DBManager.h"

@implementation AccountDao

+ (void)insertAccount:(AccountModel *)account completion:(Completion)completion{
    
    [[DBManager sharedDBManager].dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"users_list"]) {
            [db executeUpdate:@"create table users_list(user_id PRIMARY KEY, phone_num, nickname, birthday, flavor)"];
        }
        
        BOOL success = [db executeUpdate:@"replace into users_list(user_id, phone_num, nickname, birthday, flavor) values(?, ?, ?, ?, ?)", account.userID, account.phoneNum, account.nickname, account.birthday, account.flavor];
        
        completion(success);
    }];
}

+ (void)deleteAccountByUserID:(NSString *)userID completion:(Completion)completion{
    [[DBManager sharedDBManager].dbQueue inDatabase:^(FMDatabase *db) {
    
        BOOL success = [db executeUpdate:@"delete from users_list where user_id = ?",userID];
        completion(success);
    }];
}

+ (void)updateAccount:(AccountModel *)account completion:(Completion)completion{
    [[DBManager sharedDBManager].dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"users_list"]) {
            [db executeUpdate:@"create table users_list(user_id PRIMARY KEY, phone_num, nickname, birthday, flavor)"];
        }
        
        BOOL success = [db executeUpdate:@"replace into users_list(user_id, phone_num, nickname, birthday, flavor) values(?, ?, ?, ?, ?)", account.userID, account.phoneNum, account.nickname, account.birthday, account.flavor];

        completion(success);
    }];
}


+ (void)queryAccountByUserID:(NSString *)userID completion:(void(^)(AccountModel *account))completion{
    [[DBManager sharedDBManager].dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"users_list"]) {
//            [db executeUpdate:@"create table users_list(user_id PRIMARY KEY, phone_num, nickname, birthday, flavor)"];
            
        }
        
        AccountModel * account = nil;
        FMResultSet *rs = [db executeQuery:@"select * from users_list where user_id = ?", userID];
        
        if ([rs next]) {
            account = [AccountDao accountForRS:rs];
        }
        [rs close];
        
        completion(account);
    }];

}

+ (void)queryAccountByPhoneNum:(NSString *)phoneNum completion:(void(^)(AccountModel *account))completion{
    [[DBManager sharedDBManager].dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"users_list"]) {
            //            [db executeUpdate:@"create table users_list(user_id PRIMARY KEY, phone_num, nickname, birthday, flavor)"];
            
        }
        
        AccountModel * account = nil;
        FMResultSet *rs = [db executeQuery:@"select * from users_list where phone_num = ?", phoneNum];
        
        if ([rs next]) {
            account = [AccountDao accountForRS:rs];
        }
        [rs close];
        
        completion(account);
    }];
}


#pragma mark - helper
+ (AccountModel *)accountForRS: (FMResultSet*)rs{

    AccountModel * account  = [[AccountModel alloc] init];
    
    account.userID = [rs stringForColumn:@"user_id"];
    account.phoneNum = [rs stringForColumn:@"phone_num"];
    account.nickname = [rs stringForColumn:@"nickname"];
    account.birthday = [rs stringForColumn:@"birthday"];
    account.flavor = [rs stringForColumn:@"flavor"];
    
    return account;
}

@end
