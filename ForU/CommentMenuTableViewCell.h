//
//  CommentMenuTableViewCell.h
//  ForU
//
//  Created by administrator on 15/11/2.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface CommentMenuTableViewCell : UITableViewCell

@property (strong,nonatomic) UIView *favView;

@property (strong,nonatomic) UIImageView *iconImageView;

@property (strong,nonatomic) UILabel *nicknameLabel;

@property (strong,nonatomic) UILabel *contentLabel;

@property (strong,nonatomic) UILabel *timeLabel;

@property (strong,nonatomic) UIButton *fav;
@property (strong,nonatomic) UILabel *favTimes;
@property (strong,nonatomic) UILabel *lines;

@property(strong,nonatomic)UILabel *title;


@end
