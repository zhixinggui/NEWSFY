//
//  DeleteMyCommentNewsService.h
//  ForU
//
//  Created by administrator on 15/11/2.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface DeleteMyCommentNewsService : NSObject

-(void)deleteMyComment:(NSMutableDictionary*)dic andMessage:(void(^)(NSMutableDictionary*success))success;

@end
