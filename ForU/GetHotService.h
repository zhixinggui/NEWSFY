//
//  GetHotService.h
//  ForU
//
//  Created by administrator on 15/10/29.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface GetHotService : NSObject

-(void)Gethot:(NSMutableDictionary*)dic andMessage:(void(^)(NSMutableDictionary*success))success;

@end
