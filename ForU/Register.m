//
//  Register.m
//  ForU
//
//  Created by administrator on 15/10/19.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "Register.h"
#import "AFNetworking.h"
@implementation Register
- (void)judgeRegister:(NSString *)phoneNumber andPassword:(NSString *)pass andSuccess:(void(^)(NSMutableDictionary *dic))success{
    NSString *key=@"hulijieluolianglvkang015";
    NSString *phone=phoneNumber;
    NSString *password=pass;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:key forKey:@"key"];
    [parameters setObject:phone forKey:@"phone"];
    [parameters setObject:password forKey:@"password"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://115.29.176.50/interface/index.php/Home/ForU/test" parameters:parameters success:^(AFHTTPRequestOperation *requestOperation, NSData *data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"注册成功");
        success(dic);
    } failure:^(AFHTTPRequestOperation * requestOperation, NSError * error) {
        NSLog(@"回调失败");
    }];
}

//第三方登录插入
-(void)loginByother:(NSString *)culmName andValue:(NSString *)str andSuccess:(void(^)(NSMutableDictionary *dic))success{
    NSString *key=@"hulijieluolianglvkang015";
    NSString *culm=culmName;
    NSString *value=str;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:key forKey:@"key"];
    [parameters setObject:culm forKey:@"culm"];
    [parameters setObject:value forKey:@"value"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:@"http://115.29.176.50/interface/index.php/Home/ForU/insertsina" parameters:parameters success:^(AFHTTPRequestOperation *requestOperation, NSData *data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"注册成功");
        success(dic);
    } failure:^(AFHTTPRequestOperation * requestOperation, NSError * error) {
        NSLog(@"回调失败");
    }];

}

@end
