//
//  SearchNewsService.m
//  searchNews
//
//  Created by administrator on 15/10/13.
//  Copyright © 2015年 Or_luo. All rights reserved.
//

#import "SearchNewsService.h"

@implementation SearchNewsService

//搜索数据库新闻
-(void)requestNews:(NSMutableDictionary *)dic andquery:(void (^)(NSMutableDictionary *))success{
    NSMutableDictionary *resultDic=[[NSMutableDictionary alloc]init];
    NSString *title=[dic objectForKey:@"title"];
    if (title==nil) {
        title=@"";
    }
    NSString *requestNumber = [dic objectForKey:@"requestNumber"];
    
    [resultDic setValue:title forKey:@"title"];
    [resultDic setValue:requestNumber forKey:@"requestNumber"];
    
    NSString *url=@"http://115.29.176.50/interface/SearchNews.php";
    
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
