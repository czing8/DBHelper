//
//  DBManager.m
//  DBDemo
//
//  Created by Vols on 14/11/3.
//  Copyright (c) 2014年 Vols. All rights reserved.
//

#import "DBManager.h"

NSString * const DBFile = @"haiersmart.db";

@implementation DBManager

+ (DBManager *)sharedDBManager{
    static DBManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init{
    if (self = [super init]) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _dbPath = [docPath stringByAppendingPathComponent:@"data.db"];
        
        NSLog(@"Path::%@", _dbPath);
        _dbQueue =  [FMDatabaseQueue databaseQueueWithPath:_dbPath];
    }
    return self;
}

@end
