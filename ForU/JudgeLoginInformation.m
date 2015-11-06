//
//  JudgeLoginInformation.m
//  ForU
//
//  Created by administrator on 15/10/18.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "JudgeLoginInformation.h"
#import "AFNetworking.h"
@implementation JudgeLoginInformation
- (void)judgeUserInfo:(NSString *)str andSuccess:(void(^)(NSMutableDictionary *dic))success{
    NSString *key=@"hulijieluolianglvkang015";
    NSString *phonenumber=str;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:key forKey:@"key"];
    [parameters setObject:phonenumber forKey:@"phonenumber"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://115.29.176.50/interface/index.php/Home/ForU/Login" parameters:parameters success:^(AFHTTPRequestOperation *requestOperation, NSData *data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        success(dic);
    } failure:^(AFHTTPRequestOperation * requestOperation, NSError * error) {
        NSLog(@"回调失败");
    }];
}

- (void)judge:(NSString *)culmStr andValue:(NSString *)valueStr andSuccess:(void(^)(NSMutableDictionary *dic))success{
    NSString *key=@"hulijieluolianglvkang015";
    NSString *culm=culmStr;
    NSString *value=valueStr;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:key forKey:@"key"];
    [parameters setObject:value forKey:@"value"];
    [parameters setObject:culm forKey:@"culm"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://115.29.176.50/interface/index.php/Home/ForU/Loginby" parameters:parameters success:^(AFHTTPRequestOperation *requestOperation, NSData *data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        success(dic);
    } failure:^(AFHTTPRequestOperation * requestOperation, NSError * error) {
        NSLog(@"回调失败");
    }];

}


@end
