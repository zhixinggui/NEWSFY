//
//  ShareView.h
//  ForU
//
//  Created by administrator on 15/10/26.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView
@property(strong,nonatomic)UIView *shareview;
@property(strong,nonatomic)UIButton *sinaBtn,*qqBtn,*qZoneBtn,*cancelBtn;
@property(strong,nonatomic)UILabel *sinaLabel,*qqLabel,*qZoneLabel;
-(instancetype)initWithStyle:(NSString *)str andFrame:(CGRect)frame;
@end
