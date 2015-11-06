//
//  RequstData.m
//  ForU
//
//  Created by administrator on 15/10/9.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "RequstData.h"

@implementation RequstData
-(void)requestData:(NSString *)url url:(NSMutableDictionary *)dicPara dic:(void (^)(NSMutableDictionary *))success{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//     manager.requestSerializer.timeoutInterval=40;//网络请求时间超过15秒自动返回失败
    [manager POST:url parameters:dicPara success:^(AFHTTPRequestOperation *requestOperation, NSData *data) {
        
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        success(dic);
        
    } failure:^(AFHTTPRequestOperation * requestOperation, NSError * error) {
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        [dic setValue:@"2" forKey:@"error_code"];
        

        
          success(dic);
    }];
    
    
}

@end
