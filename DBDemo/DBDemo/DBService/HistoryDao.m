//
//  HistoryDao.m
//  Hibor
//
//  Created by Vols on 2017/1/13.
//  Copyright © 2017年 huibo. All rights reserved.
//

#import "HistoryDao.h"
#import "DBHelper.h"

#define kHistoryMaxNum  100
//@property(nonatomic,copy)NSString * code;
//@property(nonatomic,copy)NSString * sname;
//@property(nonatomic,copy)NSString * itype;
//@property(nonatomic,copy)NSString * isSelect;
//@property(nonatomic,copy)NSString * sid;

@implementation HistoryDao

+ (void)addStockSearchHistory:(CustomStockModel *)stockModel completion:(Completion)completion {
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"stock_list"]) {
            [db executeUpdate:@"create table stock_list(code PRIMARY KEY, sname, itype, isSelect, sid, searchTime)"];
        }
        
        BOOL success = [db executeUpdate:@"replace into stock_list(code, sname, itype, isSelect, sid, searchTime) values(?, ?, ?, ?, ?, ?)", stockModel.code, stockModel.sname, stockModel.itype, stockModel.isSelect, stockModel.sid, [HistoryDao get1970IntTimeFromSystem]];
        
        completion(success);
    }];
}

+ (void)deleteStockHistoryByUserID:(NSString *)stockCode completion:(Completion)completion {

    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db){
        
        BOOL success = [db executeUpdate:@"delete from stock_list where code = ?",stockCode];
        completion(success);
    }];
}

+ (void)updateStockHistory:(CustomStockModel *)stockModel completion:(Completion)completion {
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
        if (![db tableExists:@"stock_list"]) {
            [db executeUpdate:@"create table stock_list(code PRIMARY KEY, sname, itype, isSelect, sid, searchTime)"];
        }
        
        BOOL success = [db executeUpdate:@"replace into stock_list(code, sname, itype, isSelect, sid, searchTime) values(?, ?, ?, ?, ?, ?)", stockModel.code, stockModel.sname, stockModel.itype, stockModel.isSelect, stockModel.sid, [HistoryDao get1970IntTimeFromSystem]];
        
        completion(success);
    }];
}

+ (void)queryAllStockHistoryData:(void(^)(NSArray *stocks))completion {
    
    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
        
        if (![db tableExists:@"stock_list"]) {
            [db executeUpdate:@"create table stock_list(code PRIMARY KEY, sname, itype, isSelect, sid)"];
        }
        
        __block NSMutableArray * stockArray = [[NSMutableArray alloc] init];
        
        FMResultSet *rs = [db executeQuery:@"select * from users_list order by searchTime desc"];
        int count = 0;

        if ([rs next]) {
            count++;
            CustomStockModel * stockModel = [HistoryDao stockForRS:rs];
            [stockArray addObject:stockModel];
            
            if (count == kHistoryMaxNum) {
                
                [db executeUpdate:@"delete from stock_list where searchTime < ?",[rs objectForColumnName:@"searchTime"]];
            }
        }
        [rs close];
        
        completion(stockArray);
    }];
}


#pragma mark - helper

+ (CustomStockModel *)stockForRS: (FMResultSet*)rs{
    
    CustomStockModel * stock  = [[CustomStockModel alloc] init];
    
    stock.code = [rs stringForColumn:@"code"];
    stock.sname = [rs stringForColumn:@"sname"];
    stock.itype = [rs stringForColumn:@"itype"];
    stock.isSelect = [rs stringForColumn:@"isSelect"];
    stock.sid = [rs stringForColumn:@"sid"];
    
    return stock;
}

+ (int)get1970IntTimeFromSystem{
    
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970];
    
    int timeint = (int)time;
    
    return timeint;
}

@end
