//
//  DBManager.h
//  DBDemo
//
//  Created by Vols on 14/11/3.
//  Copyright (c) 2014年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMDatabaseAdditions.h"

@interface DBManager : NSObject

@property (nonatomic, strong) FMDatabaseQueue * dbQueue;
@property (nonatomic, strong) NSString * dbPath;

+ (DBManager *)sharedDBManager;

@end
