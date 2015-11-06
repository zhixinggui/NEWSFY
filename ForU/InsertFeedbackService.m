//
//  InsertFeedbackService.m
//  ForU
//
//  Created by administrator on 15/10/17.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "InsertFeedbackService.h"
#import "AFNetworking.h"

@implementation InsertFeedbackService
-(void)insertFeedback:(NSMutableDictionary *)dic andMessage:(void (^)(NSMutableDictionary *))success{
    NSString *url = @"http://115.29.176.50/interface/InsertFeedback.php";
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *Operation, NSData *data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        success(dic);
        NSLog(@"%@",dic);
    } failure:^(AFHTTPRequestOperation *RequestOperation, NSError *error) {
        NSLog(@"请求失败:%@",error);
    }];
}


@end
