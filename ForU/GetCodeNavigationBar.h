//
//  GetCodeNavigationBar.h
//  ForU
//
//  Created by administrator on 15/10/9.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetCodeNavigationBar : UIView
@property(nonatomic,strong)UIButton *leftBtn,*rightBtn;
@property (nonatomic, strong)UILabel *label;
- (instancetype)initWithNavBar:(NSString*)leftBtn andLabel:(NSString*)label andBtn:(NSString *)str;
@end
