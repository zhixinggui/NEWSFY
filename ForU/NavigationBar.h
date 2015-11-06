//
//  NavigationBar.h
//  ForU
//
//  Created by administrator on 15/9/21.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationBar : UIView
@property (nonatomic, strong)UILabel *label;
@property(nonatomic,strong)UIButton *leftBtn,*ForUBtn,*rightBtn;

@property (nonatomic, strong)UIImageView *imageView;
- (instancetype)initWithNavBar:(NSString*)leftBtnImg ForUBtnTitle:(NSString*)ForUBtn rightBtnTitle:(NSString*)rightBtn;


@end
