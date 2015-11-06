//
//  MenuNavigationBar.h
//  ForU
//
//  Created by administrator on 15/9/23.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuNavigationBar : UIView
@property(nonatomic,strong)UIButton *leftBtn;
@property (nonatomic, strong)UILabel *label;
- (instancetype)initWithNavBar:(NSString*)leftBtn andLabel:(NSString*)label;
@end
