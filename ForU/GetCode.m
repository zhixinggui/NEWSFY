//
//  GetCode.m
//  ForU
//
//  Created by administrator on 15/10/8.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "GetCode.h"
#import "HomeViewController.h"
#import "ResetViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import <SMS_SDK/CountryAndAreaCode.h>
#import "JudgeLoginInformation.h"
#import "RequstUserInfo.h"
#import "OperateDatabase.h"
#import "Register.h"
#import "RequstData.h"
@implementation GetCode


//获取验证码
-(void)getCode:(NSString *)str{
    
        [SMS_SDK getVerificationCodeBySMSWithPhone:str zone:@"86" result:^(SMS_SDKError *error) {
            if (!error) {
            
            NSLog(@"验证码发送成功");
            
        }else{
            
            NSLog(@"%@",error);
            
        }
            
        }];
    }

//验证
-(void)validateCode:(NSString *)str andPhone:(NSString *)phoneNumber andWith:(UIViewController *)view{
    
    if (str.length != 4) {
        
        UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"验证码格式错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
        [SMS_SDK commitVerifyCode:str result:^(enum SMS_ResponseState state) {
            if (state == 1) {
                ResetViewController *rvc=[[ResetViewController alloc]init];
                [rvc setValue:phoneNumber forKey:@"phoneNumber"];
                [view.navigationController pushViewController:rvc animated:YES];
//                [view presentViewController:rvc animated:YES completion:nil];
                
            }else if (state == 0) {
                UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"验证码输入错误，请重新输入" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }];
        
    }

}
-(void)reValidateCode:(NSString *)str  andPhoneNumber:(NSString *)string andPassword:(NSString *)password andWith:(UIViewController *)view{
    if (str.length != 4) {
        UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"验证码格式错误" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        
        [SMS_SDK commitVerifyCode:str result:^(enum SMS_ResponseState state) {
            if (state == 1) {
                
                JudgeLoginInformation *judge=[[JudgeLoginInformation alloc]init];
                [judge judgeUserInfo:string andSuccess:^(NSMutableDictionary *dic){
                    NSMutableArray *array=[dic objectForKey:@"result"];
                    //若数据库中没有该条信息，则可以注册
                    if([array isKindOfClass:[NSNull class]]){
                        Register *re=[[Register alloc]init];
                        //调用注册方法将信息添加到服务器
                        [re judgeRegister:string andPassword:str andSuccess:^(NSMutableDictionary *dic) {
                            
                            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"注册成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                            
                            //再次调用获取信息得方法
                            [judge judgeUserInfo:string andSuccess:^(NSMutableDictionary *dic) {
                                NSMutableArray *ary=[dic objectForKey:@"result"];
                                NSMutableDictionary *dic1=[ary objectAtIndex:0];
                                OperateDatabase *operate=[[OperateDatabase alloc]init];
                                //移除user表中信息
                                [operate deleteData];
                                //将新注册用户的信息存到数据库
                                [operate insertData:dic1];
                                
                                NSString *url = @"http://115.29.176.50/interface/index.php/Home/GetTest/insertTagByuserId";
                                NSMutableDictionary *parameters =[[NSMutableDictionary alloc]init];
                                
                                [parameters setValue:[[[dic valueForKey:@"result"] valueForKey:@"userid"] objectAtIndex:0]forKey:@"userId"];
                                
                                
                                
                                [parameters setValue:@"hulijieluolianglvkang015" forKey:@"key"];
                                
                                RequstData *request = [[RequstData alloc]init];
                                [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){
                                    
                                    
                                }];
                                HomeViewController *hvc=[[HomeViewController alloc]init];
                                UINavigationController *nv=[[UINavigationController alloc]initWithRootViewController:hvc];
                                
                                [view presentViewController:nv animated:YES completion:nil];

                                
                            }];
                            
                        }];
                        
                        
                        
                    }
                    else{
                        UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"用户已注册，请登录" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                        
                    }
                }];
                
            }else if (state == 0) {
                UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"验证码输入错误，请重新输入" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }];
        
    }

}
@end
