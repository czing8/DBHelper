//
//  DataCenter.h
//  DBDemo
//
//  Created by Vols on 14/11/3.
//  Copyright (c) 2014年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccountModel.h"
#import "AccountDao.h"

@interface DataCenter : NSObject

@property (nonatomic, strong) AccountModel *curAccount;
@property (nonatomic, strong) NSString * curUserID;


+ (DataCenter *)shared;

@end
