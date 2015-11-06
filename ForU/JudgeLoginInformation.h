//
//  JudgeLoginInformation.h
//  ForU
//
//  Created by administrator on 15/10/18.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JudgeLoginInformation : NSObject
- (void)judgeUserInfo:(NSString *)str andSuccess:(void(^)(NSMutableDictionary *dic))success;
- (void)judge:(NSString *)culmStr andValue:(NSString *)valueStr andSuccess:(void(^)(NSMutableDictionary *dic))success;
@end
