//
//  login.m
//  ForU
//
//  Created by administrator on 15/9/28.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "login.h"
#import "UMSocial.h"
@implementation login
-(void)loginWithSina{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
    
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
    
    //获取好友列表
    [[UMSocialDataService defaultDataService] requestSnsFriends:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsFriends is %@",response.data);
    }];

}
@end
