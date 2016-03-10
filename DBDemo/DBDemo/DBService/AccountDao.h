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

+ (void)insertAccount:(AccountModel *)account completion:(Completion)completion;

+ (void)deleteAccountByUserID:(NSString *)userID completion:(Completion)completion;

+ (void)updateAccount:(AccountModel *)account completion:(Completion)completion;

+ (void)queryAccountByUserID:(NSString *)userID completion:(void(^)(AccountModel *account))completion;

+ (void)queryAccountByPhoneNum:(NSString *)phoneNum completion:(void(^)(AccountModel *account))completion;


@end
