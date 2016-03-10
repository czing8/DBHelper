//
//  AccountModel.m
//  DBDemo
//
//  Created by Vols on 14/11/3.
//  Copyright (c) 2014年 Vols. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

- (id)initWithAttributes:(NSDictionary *)attributes{
    if (self = [super init]) {
        if (attributes[@"user_id"] != nil) {
            self.userID = attributes[@"user_id"];
        }
        
//        后台数据没有返回phone，登陆时成功后手动把phone加进去
        if (attributes[@"phoneNum"] != nil) {
            self.phoneNum = attributes[@"phoneNum"];
        }
        
        if (attributes[@"nickname"] != nil) {
            self.nickname = attributes[@"nickname"];
        }
        
        if (attributes[@"flavor"] != nil) {
            self.flavor = attributes[@"flavor"];
        }
        
        if (attributes[@"bmonth"] != nil && attributes[@"bday"] != nil) {
            self.birthday = [NSString stringWithFormat:@"%@-%@", attributes[@"bmonth"], attributes[@"bday"]];
        }
    }
    return self;
}


@end
