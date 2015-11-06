//
//  RequstData.h
//  ForU
//
//  Created by administrator on 15/10/9.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface RequstData : NSObject
- (void)requestData:(NSString *)url url:(NSMutableDictionary *)dicPara dic:(void(^)(NSMutableDictionary *dic))success;


@end
