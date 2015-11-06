//
//  Register.h
//  ForU
//
//  Created by administrator on 15/10/19.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Register : NSObject
- (void)judgeRegister:(NSString *)phoneNumber andPassword:(NSString *)pass andSuccess:(void(^)(NSMutableDictionary *dic))success;

-(void)loginByother:(NSString *)culm andValue:(NSString *)value andSuccess:(void(^)(NSMutableDictionary *dic))success;
@end
