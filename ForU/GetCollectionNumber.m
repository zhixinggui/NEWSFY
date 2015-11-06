//
//  GetCollectionNumber.m
//  ForU
//
//  Created by administrator on 15/10/26.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "GetCollectionNumber.h"
#import "AFNetworking.h"

@implementation GetCollectionNumber
-(void)getNum:(int)userId andSuccess:(void(^)(NSMutableDictionary *dic))success{
    NSString *key = @"hulijieluolianglvkang015";
    NSString * userID=[NSString stringWithFormat:@"%d",userId];
    NSLog(@"%@",userID);
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:key forKey:@"key"];
    [parameters setObject:userID forKey:@"userID"];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://115.29.176.50/interface/index.php/Home/ForU/getFavNum" parameters:parameters success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
         success(dic);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"获取信息失败!");
     }];
}
@end
