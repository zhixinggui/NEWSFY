//
//  CommentTableViewCell.m
//  ForU
//
//  Created by 胡礼节 on 15/10/12.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "Header.h"
@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.favView = [[UIView alloc]init];
        
        self.iconImageView = [[UIImageView alloc]init];
        
        self.nicknameLabel = [[UILabel alloc]init];
        
        self.contentLabel = [[UILabel alloc]init];
        
        self.jubao = [[UIButton  alloc]init];
        self.contentLabel.numberOfLines = 0;
        
        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.timeLabel = [[UILabel alloc]init];
         self.lines = [[UILabel alloc]init];
        [self.contentView addSubview:self.jubao];
        
        [self.contentView addSubview:self.iconImageView];
        
        [self.contentView addSubview:self.nicknameLabel];
        
        [self.contentView addSubview:self.contentLabel];
        
        [self.contentView addSubview:self.timeLabel];
             [self.contentView addSubview:self.lines];
        
        self.fav = [[UIButton alloc]init];
        
        self.favTimes = [[UILabel alloc]init];

        [self.favView addSubview:self.fav];
        
        [self.favView addSubview:self.favTimes];

        
//        [self.contentView addSubview:self.favView];
        

    }
    
    return self;
}
-(void)MyLayoutSubviews{
    
    [super layoutSubviews];
    
    self.favView.frame = CGRectMake(SCREEN_WIDTH *0.7, SCREEN_HEIGHT *0.01, SCREEN_WIDTH * 0.28, SCREEN_HEIGHT * 0.06);
        self.favView.backgroundColor = [UIColor purpleColor];
    self.iconImageView.frame = CGRectMake(2, 2, 30, 30);
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImageView.layer.cornerRadius = 10;
    
    self.iconImageView.clipsToBounds = YES;
    self.nicknameLabel.frame = CGRectMake(40, 2, 100, 30);
    
    self.contentLabel.frame = CGRectMake(2, 34, self.contentView.frame.size.width, 30);
      self.lines.frame = CGRectMake(64,0, SCREEN_WIDTH, 1);
    self.timeLabel.frame = CGRectMake(10, 10, 10, 10);
    self.jubao.frame =  CGRectMake(SCREEN_WIDTH *0.8, SCREEN_HEIGHT *0.01, SCREEN_WIDTH * 0.18, SCREEN_HEIGHT * 0.06);
    

    self.fav.frame = CGRectMake(100, 0, 20, 30);
    self.favTimes.frame = CGRectMake(0, 0, 20, 30);
//    self.contentView.frame
    //    self.lineLabel.frame = CGRectMake(10, 10, 10, 20);
}


@end
