//
//  Share.m
//  ForU
//
//  Created by administrator on 15/10/26.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "Share.h"
#import "UMSocial.h"
@implementation Share
-(void)shareToSina:(NSString *)content andImg:(UIImage *)image andURL:(NSString *)url andView:(UIViewController *)view{
    

    content = [NSString stringWithFormat:@"%@%@",content,url];
   
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:content image:image location:nil urlResource:nil presentedController:view completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"分享成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];

    
}

-(void)shareToQQ:(NSString *)content andImg:(UIImage *)image andURL:(NSString *)url andView:(UIViewController *)view{
    [UMSocialData defaultData].extConfig.qqData.title = @"分享到QQ";
    [UMSocialData defaultData].extConfig.qqData.url = url;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:content image:image location:nil urlResource:nil presentedController:view completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"分享成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
}
-(void)shareToQZone:(NSString *)content andImg:(UIImage *)image andURL:(NSString *)url andView:(UIViewController *)view{
    [UMSocialData defaultData].extConfig.qqData.title = @"分享到QQ空间";
    [UMSocialData defaultData].extConfig.qzoneData.url = url;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:content image:image location:nil urlResource:nil presentedController:view completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"分享成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
  
}
@end
