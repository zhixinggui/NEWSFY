//
//  RequstUserInfo.h
//  ForU
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface RequstUserInfo : NSObject
- (void)requestUserInfo:(int)userId andSuccess:(void(^)(NSMutableDictionary *dic))success;


@end
