//
//  SearchHistoryDao.h
//  DBDemo
//
//  Created by Vols on 2017/1/13.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DBHelper.h"
#import "AccountModel.h"

typedef void (^SuccessBlock)(BOOL success);

typedef NS_ENUM(NSUInteger, HistoryType) {
    
    HistoryType100 = 100,
    HistoryType101,
    HistoryType102,
};

/**
 *  历史记录本地数据操作
 */
@interface SearchHistoryDao : NSObject

+ (void)insertSearchAccountHistory:(AccountModel *)model historyType:(HistoryType)historyType successBlock:(SuccessBlock)completion;

+ (void)deleteAccountHistoryBy:(NSString *)userId historyType:(HistoryType)historyType successBlock:(SuccessBlock)completion;

+ (void)deleteAllHistoryType:(HistoryType)historyType successBlock:(SuccessBlock)completion ;

+ (void)updateAccountHistory:(AccountModel *)model historyType:(HistoryType)historyType successBlock:(SuccessBlock)completion;

+ (void)queryAccountHistoryType:(HistoryType)historyType historyData:(void(^)(NSArray *stocks))completion;


@end
