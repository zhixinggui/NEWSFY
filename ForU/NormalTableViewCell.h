//
//  NormalTableViewCell.h
//  ForU
//
//  Created by administrator on 15/9/22.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalTableViewCell : UITableViewCell
@property(strong,nonatomic)UIImageView *image;
@property(strong,nonatomic)UILabel *title,*type,*line,*timeLabel,*comment;
@property(strong,nonatomic)UIView *TitleTimeView;
//- (void)NewlayoutSubviews;

@end
