//
//  DBHelper.m
//  HaierSmart
//
//  Created by Vols on 16/3/9.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import "DBHelper.h"

NSString * const DBFile = @"hibor.db";

@implementation DBHelper

+ (DBHelper *)sharedDB{
    static DBHelper *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (id)init{
    if (self = [super init]) {
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _dbPath = [docPath stringByAppendingPathComponent:DBFile];
        
        _dbQueue =  [FMDatabaseQueue databaseQueueWithPath:_dbPath];
    }
    return self;
}

@end
