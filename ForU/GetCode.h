//
//  GetCode.h
//  ForU
//
//  Created by administrator on 15/10/8.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GetCode : NSObject
@property(assign,nonatomic)  BOOL state;
-(void)getCode:(NSString *)str;
//-(void)validateCode:(NSString *)str andWith:(UIViewController *)view;
-(void)validateCode:(NSString *)str andPhone:(NSString *)phoneNumber andWith:(UIViewController *)view;
-(void)reValidateCode:(NSString *)str andPhoneNumber:(NSString *)string andPassword:(NSString *)password andWith:(UIViewController *)view;
@end
