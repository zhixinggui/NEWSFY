//
//  LoginViewStyle.h
//  ForU
//
//  Created by administrator on 15/10/12.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewStyle : UIView
@property(nonatomic,strong)UIImageView *image;
@property (strong,nonatomic)UITextField *text;
@property(strong,nonatomic)UIButton *eyeBtn;
@property(assign,nonatomic)BOOL isclick;
-(instancetype)initViewStyle:(UIImage *)img andWithBtnImage:(NSString *)str;
-(void)click;
@end
