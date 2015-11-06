//
//  InsertFeedbackService.h
//  ForU
//
//  Created by administrator on 15/10/17.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsertFeedbackService : NSObject

-(void)insertFeedback:(NSMutableDictionary*)dic andMessage:(void(^)(NSMutableDictionary*success))success;

@end
