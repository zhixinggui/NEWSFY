//
//  UserViewController.h
//  ForU
//
//  Created by administrator on 15/10/12.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol userDelegate<NSObject>
- (void)returnMessage:(NSDictionary*)message andImage:(UIImage *)image;
@end
@interface UserViewController : UIViewController<userDelegate>


@end
