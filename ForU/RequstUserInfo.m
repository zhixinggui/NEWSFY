//
//  RequstUserInfo.m
//  ForU
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "RequstUserInfo.h"

@implementation RequstUserInfo

//根据用户ID获取用户信息
- (void)requestUserInfo:(int)userId andSuccess:(void(^)(NSMutableDictionary *dic))success{
    NSString *key = @"hulijieluolianglvkang015";
    NSString *table=@"userinfo";
    NSString * userID=[NSString stringWithFormat:@"%d",userId];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:key forKey:@"key"];
    [parameters setObject:table forKey:@"table"];
    [parameters setObject:userID forKey:@"userID"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://115.29.176.50/interface/index.php/Home/ForU/getUserInfo" parameters:parameters success:^(AFHTTPRequestOperation *requestOperation, NSData *data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSMutableArray *ary=[dic objectForKey:@"result"];
        NSMutableDictionary *infodic=[ary objectAtIndex:0];
        success(infodic);
        
    } failure:^(AFHTTPRequestOperation * requestOperation, NSError * error) {
    }];
}


@end
