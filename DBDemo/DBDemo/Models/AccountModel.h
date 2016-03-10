//
//  AccountModel.h
//  DBDemo
//
//  Created by Vols on 14/11/3.
//  Copyright (c) 2014年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *phoneNum;

@property (nonatomic, strong) NSString *nickname; //个人备注昵称
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *flavor;   //口味

@property (nonatomic, assign) NSUInteger gender;
@property (nonatomic, strong) NSString *signature;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
