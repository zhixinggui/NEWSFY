//
//  OperateDatabase.h
//  ForU
//
//  Created by administrator on 15/10/16.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperateDatabase : NSObject
-(void)creatDatebase;
-(void)insertData:(NSMutableDictionary *)dic;
-(void)deleteData;//删除行
-(void)check; //判断是否空
-(void)selectNewsid;//获取用户id
-(void)updateIcon:(NSString*)data;//更新头像
-(void)updatePassword:(NSString *)str; //更新密码
-(void)updateAutograph:(NSString *)str;//修改签名
-(void)updateNickname:(NSString *)str;//修改昵称
-(void)insertNewsData:(NSDictionary *)dic;
- (BOOL)checkNews:(NSString *)title;
- (NSMutableArray*)getNews:(NSString *)newsstyleid;
- (NSDictionary*)getOneNews:(NSDictionary *)newsPara;

@property (assign,nonatomic)BOOL click;
@property (copy,nonatomic) NSString * userid;

@end
