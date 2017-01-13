//
//  HistoryDao.h
//  Hibor
//
//  Created by Vols on 2017/1/13.
//  Copyright © 2017年 huibo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CustomStockModel.h"

typedef void (^Completion)(BOOL success);

/**
 *  历史记录本地数据操作
 */
@interface HistoryDao : NSObject

+ (void)addStockSearchHistory:(CustomStockModel *)stockModel completion:(Completion)completion;

+ (void)deleteStockHistoryByUserID:(NSString *)stockCode completion:(Completion)completion;

+ (void)updateStockHistory:(CustomStockModel *)stockModel completion:(Completion)completion;

+ (void)queryAllStockHistoryData:(void(^)(NSArray *stocks))completion;


@end
