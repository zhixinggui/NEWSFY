//
//  SearchNewsService.h
//  searchNews
//
//  Created by administrator on 15/10/13.
//  Copyright © 2015年 Or_luo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface SearchNewsService : NSObject

-(void)requestNews:(NSMutableDictionary *)dic andquery:(void (^)(NSMutableDictionary *success))success;

@end
