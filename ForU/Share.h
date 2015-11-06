//
//  Share.h
//  ForU
//
//  Created by administrator on 15/10/26.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocial.h"
@interface Share : NSObject<UMSocialUIDelegate>
-(void)shareToSina:(NSString *)content andImg:(UIImage *)image andURL:(NSString *)url andView:(UIViewController *)view;
-(void)shareToQQ:(NSString *)content andImg:(UIImage *)image andURL:(NSString *)url andView:(UIViewController *)view;
-(void)shareToQZone:(NSString *)content andImg:(UIImage *)image andURL:(NSString *)url andView:(UIViewController *)view;
@end
