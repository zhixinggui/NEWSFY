//
//  RequstLocalData.m
//  ForU
//
//  Created by administrator on 15/10/16.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "RequstLocalData.h"
#import "FMDB.h"
@implementation RequstLocalData

//从本地数据库取出USER表的信息存入字典
- (NSMutableDictionary *)requestLocalInfo{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
    if (![db open]) {
        NSLog(@"数据库打开失败！");
    }
    NSInteger tg=1;
    NSString *num=[NSString stringWithFormat:@"%ld",(long)tg];
    NSString *userid=[db stringForQuery:@"SELECT userid FROM USER WHERE Id=?",num];
    NSString *password=[db stringForQuery:@"SELECT password FROM USER WHERE Id=?",num];
    NSString *nickName=[db stringForQuery:@"SELECT nickName FROM USER WHERE Id=?",num];
    NSString *phoneNumber=[db stringForQuery:@"SELECT phoneNumber FROM USER WHERE Id=?",num];
    NSString *icon=[db stringForQuery:@"SELECT icon FROM USER WHERE Id=?",num];
    NSString *autograph=[db stringForQuery:@"SELECT autograph FROM USER WHERE Id=?",num];
    NSString *sina=[db stringForQuery:@"SELECT sina FROM USER WHERE Id=?",num];
    NSString *qq=[db stringForQuery:@"SELECT qq FROM USER WHERE Id=?",num];
    NSString *weichat=[db stringForQuery:@"SELECT weichat FROM USER WHERE Id=?",num];
    NSString *tag=[db stringForQuery:@"SELECT tag FROM USER WHERE Id=?",num];
    
    
    
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setValue:userid forKey:@"userid"];
    [dic setValue:password forKey:@"password"];
    [dic setValue:nickName forKey:@"nickName"];
    [dic setValue:phoneNumber forKey:@"phoneNumber"];
    [dic setValue:icon forKey:@"icon"];
    [dic setValue:autograph forKey:@"autograph"];
    [dic setValue:sina forKey:@"sina"];
    [dic setValue:qq forKey:@"qq"];
    [dic setValue:weichat forKey:@"weichat"];
    [dic setValue:tag forKey:@"tag"];
  [db close];
    return dic;
    
  
}
@end
