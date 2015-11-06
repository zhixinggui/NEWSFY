//
//  GetMyCollectionNewsService.h
//  ForU
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface GetMyCollectionNewsService : NSObject

-(void)requestCollectionNews:(NSMutableDictionary *)dic andResult:(void(^)(NSMutableDictionary *success))success;

@end
