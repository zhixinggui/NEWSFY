//
//  MLVIewCViewController.h
//  ForU
//
//  Created by 胡礼节 on 15/10/26.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    MLTransitionAnimationTypePush, //push
    MLTransitionAnimationTypePop, //pop
} MLTransitionAnimationType;

@interface MLVIewCViewController : UIViewController<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) MLTransitionAnimationType type;
@end
