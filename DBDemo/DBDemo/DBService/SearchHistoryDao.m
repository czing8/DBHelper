//
//  SearchHistoryDao.m
//  DBDemo
//
//  Created by Vols on 2017/1/13.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import "SearchHistoryDao.h"
#define kHistoryMaxNum  10

@implementation SearchHistoryDao

+ (void)insertSearchAccountHistory:(AccountModel *)model historyType:(HistoryType)historyType successBlock:(SuccessBlock)completion {
    
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"users_history_list"]) {
            [db executeUpdate:@"create table users_history_list(user_id PRIMARY KEY, phone_num, nickname, birthday, flavor, searchTime, historyType)"];
        }
        
        BOOL success = [db executeUpdate:@"replace into users_history_list(user_id, phone_num, nickname, birthday, flavor, searchTime, historyType) values(?, ?, ?, ?, ?, ?, ?)", model.userID, model.phoneNum, model.nickname, model.birthday, model.flavor, [NSNumber numberWithInt:[self get1970IntTimeFromSystem]], @(historyType)];
        
        completion(success);
    }];
}

+ (void)deleteAccountHistoryBy:(NSString *)userId historyType:(HistoryType)historyType successBlock:(SuccessBlock)completion{
    
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db){
        
        BOOL success = [db executeUpdate:@"delete from users_history_list where user_id = ? and historyType = ?", userId, @(historyType)];
        completion(success);
    }];
}

+ (void)deleteAllHistoryType:(HistoryType)historyType successBlock:(SuccessBlock)completion {
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db){
        
        BOOL success = [db executeUpdate:@"delete from users_history_list where historyType = ?", @(historyType)];
        completion(success);
    }];
}

+ (void)updateAccountHistory:(AccountModel *)model historyType:(HistoryType)historyType successBlock:(SuccessBlock)completion{
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"users_history_list"]) {
            [db executeUpdate:@"create table users_history_list(user_id PRIMARY KEY, phone_num, nickname, birthday, flavor, searchTime, historyType)"];
        }
        
        BOOL success = [db executeUpdate:@"replace into users_history_list(user_id, phone_num, nickname, birthday, flavor, searchTime, historyType) values(?, ?, ?, ?, ?, ?, ?)", model.userID, model.phoneNum, model.nickname, model.birthday, model.flavor, [NSNumber numberWithInt:[self get1970IntTimeFromSystem]], @(historyType)];
        
        completion(success);
    }];
}

+ (void)queryAccountHistoryType:(HistoryType)historyType historyData:(void(^)(NSArray *historys))completion {
    
    __block NSMutableArray * stockArray = [[NSMutableArray alloc] init];
    
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
        
        if (![db tableExists:@"users_history_list"]) {
            [db executeUpdate:@"create table users_history_list(user_id PRIMARY KEY, phone_num, nickname, birthday, flavor, searchTime, historyType)"];
        }
        
        FMResultSet *rs = [db executeQuery:@"select * from users_history_list where historyType = ? order by searchTime desc", @(historyType)];
        int count = 0;
        
        while ([rs next]) {
            count++;
            AccountModel * model = [self accountForRS:rs];
            [stockArray addObject:model];
            
            if (count >= kHistoryMaxNum) {
                [db executeUpdate:@"delete from users_history_list where searchTime < ?",[rs objectForColumnName:@"searchTime"]];
                break;
            }
        }
        completion(stockArray);
        
        [rs close];
    }];
}

+ (int)get1970IntTimeFromSystem {
    
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
    
    int timeint = (int)time;
    
    return timeint;
}

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
