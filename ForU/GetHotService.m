//
//  GetHotService.m
//  ForU
//
//  Created by administrator on 15/10/29.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "GetHotService.h"

@implementation GetHotService

-(void)Gethot:(NSMutableDictionary *)dic andMessage:(void (^)(NSMutableDictionary *))success{
 
    NSString *key = @"8f22036eed44dcc16c360292a098c7ce";
    NSString *urlStr = [NSString stringWithFormat:@"http://op.juhe.cn/onebox/news/words?key=%@",key];
    
    NSString *url = @"http://115.29.176.50/interface/getHot.php";
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *Operation, NSData *data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        success(dic);
    } failure:^(AFHTTPRequestOperation *RequestOperation, NSError *error) {
        //        NSLog(@"请求失败:%@",error);
        NSLog(@"请求失败");
    }];
}

@end
