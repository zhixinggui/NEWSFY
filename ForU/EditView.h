//
//  EditView.h
//  ForU
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditView : UIView
@property(strong,nonatomic)UILabel *title;
@property(strong,nonatomic)UITextView *editText;
@property(strong,nonatomic)UIButton *sureBtn,*cancelBtn,*commentBtn;
-(instancetype )initWithStyle:(NSString *)str andFrame:(CGRect)frame andSourse:(int )i;

@end
