//
//  mvTableViewCell.h
//  ForU
//
//  Created by 胡礼节 on 15/11/3.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mvTableViewCell : UITableViewCell
@property(strong,nonatomic)UIImageView *image;
@property(strong,nonatomic)UILabel *title,*type,*line,*timeLabel,*comment;
@property(strong,nonatomic)UIView *TitleTimeView;
@end
