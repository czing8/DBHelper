//
//  AccountDao.h
//  DBDemo
//
//  Created by Vols on 14/11/3.
//  Copyright (c) 2014年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

typedef void (^Completion)(BOOL success);

@interface AccountDao : NSObject

//插入一条数据
+ (void)insertAccount:(AccountModel *)account completion:(Completion)completion;

//插入多条数据
+ (void)insertAccounts:(NSArray *)accounts completion:(Completion)completion;



+ (void)deleteAccountByUserID:(NSString *)userID completion:(Completion)completion;

+ (void)updateAccount:(AccountModel *)account completion:(Completion)completion;

+ (void)queryAccountByUserID:(NSString *)userID completion:(void(^)(AccountModel *account))completion;

+ (void)queryAccountByPhoneNum:(NSString *)phoneNum completion:(void(^)(AccountModel *account))completion;


@end
