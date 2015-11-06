//
//  deleteFootPrintService.h
//  ForU
//
//  Created by administrator on 15/10/21.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface deleteFootPrintService : NSObject

-(void)deleteFootPrint:(NSMutableDictionary*)dic andMessage:(void(^)(NSMutableDictionary*success))success;

@end
