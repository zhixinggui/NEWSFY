//
//  CheckNet.m
//  ForU
//
//  Created by administrator on 15/10/27.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "CheckNet.h"
#import "AFNetworking.h"
@implementation CheckNet
- (void)checkNet
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 移动数据
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 无线网络
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    
    self.check=NO;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
       
        switch (status) {
            case 0:self.check=NO;break;
            default:self.check=YES;break;
                
                
        }
    }];

}



@end
