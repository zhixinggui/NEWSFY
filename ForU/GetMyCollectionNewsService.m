//
//  GetMyCollectionNewsService.m
//  ForU
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "GetMyCollectionNewsService.h"

@implementation GetMyCollectionNewsService

-(void)requestCollectionNews:(NSMutableDictionary *)dic andResult:(void (^)(NSMutableDictionary *))success{
    NSMutableDictionary *resultDic=[[NSMutableDictionary alloc]init];
    NSString *userId=[dic objectForKey:@"userId"];
    NSString *requestNumber=[dic objectForKey:@"requestNumber"];
//    NSString *newsId=[dic objectForKey:@"newsId"];
//    NSString *newsStyleId=[dic objectForKey:@"newsStyleId"];
//    NSString *collectionId=[dic objectForKey:@"collectionId"];
    
    [resultDic setValue:userId forKey:@"userId"];
    [resultDic setValue:requestNumber forKey:@"requestNumber"];
//    [resultDic setValue:newsId forKey:@"newsId"];
//    [resultDic setValue:newsStyleId forKey:@"newsStyleId"];
    
    NSString *url=@"http://115.29.176.50/interface/test.php";
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:resultDic success:^(AFHTTPRequestOperation * RequestOperation, NSData *data) {
        NSMutableDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        success(dic);
    } failure:^(AFHTTPRequestOperation *RequestOperation, NSError * error) {
        NSLog(@"请求失败：%@",error);
    }];
}

@end
