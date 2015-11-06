//
//  GetCollectionNumber.h
//  ForU
//
//  Created by administrator on 15/10/26.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCollectionNumber : NSObject
-(void)getNum:(int)userId andSuccess:(void(^)(NSMutableDictionary *dic))success;

@end
