//
//  SelectLogin.m
//  ForU
//
//  Created by administrator on 15/10/8.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "SelectLogin.h"
#import "UMSocial.h"
#import "UserViewController.h"
#import "JudgeLoginInformation.h"
#import "RequstUserInfo.h"
#import "OperateDatabase.h"
#import "Register.h"
#import "RequstData.h"
#import "DownImageModel.h"
@implementation SelectLogin
-(void)LoginBySina:(UIViewController *)view{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(view,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){

        
        if(response.responseCode==UMSResponseCodeSuccess){
        
        //获取授权后信息
        [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
            

            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            NSString *str=snsAccount.usid;
           
    
            [self testInfor:str andculm:@"sina" andView:view];
            
        }];
        }
    });
    
}
-(void)LoginByQQ:(UIViewController *)view{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.loginClickHandler(view,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        // 获取用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];

            NSString *str=snsAccount.usid;
            [self testInfor:str andculm:@"qq" andView:view];
           
        }});
    //finished ,do it
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
       
        
        
    }];

    
}

-(void)testInfor:(NSString *)str andculm:(NSString*)string andView:(UIViewController *)view{
    JudgeLoginInformation *judge=[[JudgeLoginInformation alloc]init];
      [judge judge:string andValue:str andSuccess:^(NSMutableDictionary *dic)  {
        NSMutableArray *array=[dic objectForKey:@"result"];
        //若不存在该信息,调用插入方法
        if([array isKindOfClass:[NSNull class]]){
            Register *re=[[Register alloc]init];
            [re loginByother:string andValue:str andSuccess:^(NSMutableDictionary *dic) {
                
                //再次调用获取信息得方法
                [judge judge:string andValue:str andSuccess:^(NSMutableDictionary *dic) {
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
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    UserViewController *uvc=[[UserViewController alloc]init];
                    [view.navigationController pushViewController:uvc animated:YES];

                }];
            }];
        }
        else{
            //取出该行信息，存入数据库
            NSMutableDictionary *infoDic=[array objectAtIndex:0];
            int userid=[[infoDic objectForKey:@"userid" ]intValue];
            RequstUserInfo *requestInfo=[[RequstUserInfo alloc]init];
            OperateDatabase *operate=[[OperateDatabase alloc]init];
            //移除user表中信息
            [operate deleteData];
            //userid由输入的号码查询用户表获取
            [requestInfo requestUserInfo:userid andSuccess:^(NSMutableDictionary *dic){
                //插入数据到本地数据库
                [operate insertData:dic];
                
                
                
                DownImageModel *downLoadModel = [[DownImageModel alloc]init];
                [downLoadModel downLoad:[dic valueForKey:@"icon"]];
                
                
                
                UserViewController *uvc=[[UserViewController alloc]init];
                [view.navigationController pushViewController:uvc animated:YES];
//                [view presentViewController:uvc animated:YES completion:nil];
            }];
        }
        
    }];
    

    
}

@end
