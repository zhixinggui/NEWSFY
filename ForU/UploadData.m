//
//  UploadData.m
//  ForU
//
//  Created by administrator on 15/10/18.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "UploadData.h"
#import "AFNetworking.h"
@implementation UploadData
- (void)uploadUserInfo:(int)userId  andCulm:(NSString *)culmstr andValue:(NSString *)valuestr andSuccess:(void(^)(NSMutableDictionary *dic))success{
    NSString *key = @"hulijieluolianglvkang015";
    NSString *table=@"userinfo";
    NSString * userID=[NSString stringWithFormat:@"%d",userId];
    NSString *culm=culmstr;
    NSString *value=valuestr;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:key forKey:@"key"];
    [parameters setObject:table forKey:@"table"];
    [parameters setObject:userID forKey:@"userID"];
    [parameters setObject:culm forKey:@"culm"];
    [parameters setObject:value  forKey:@"value"];
  
     AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
      manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     [manager POST:@"http://115.29.176.50/interface/index.php/Home/ForU/upDateUserInfor" parameters:parameters success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
    {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        

        NSLog(@"更新成功");
        success(dic);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"更新失败!");
    }];
}


@end
