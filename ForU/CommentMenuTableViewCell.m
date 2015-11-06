//
//  CommentMenuTableViewCell.m
//  ForU
//
//  Created by administrator on 15/11/2.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "CommentMenuTableViewCell.h"
#import "Header.h"

@implementation CommentMenuTableViewCell

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
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        
        self.lines = [[UILabel alloc]init];
        
        self.title = [[UILabel alloc] init];
        
        [self.contentView addSubview:self.iconImageView];
        
        [self.contentView addSubview:self.nicknameLabel];
        
        [self.contentView addSubview:self.contentLabel];
        
        [self.contentView addSubview:self.timeLabel];
        
        [self.contentView addSubview:self.lines];
         
        [self.contentView addSubview:self.title];
    }
    
    return self;
}
-(void)MyLayoutSubviews{
    
    [super layoutSubviews];
    
    self.iconImageView.frame = CGRectMake(2, 2, 30, 30);
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconImageView.layer.cornerRadius = 10;
    self.iconImageView.clipsToBounds = YES;
    
    self.nicknameLabel.frame = CGRectMake(40, 2, 100, 30);
    
    self.contentLabel.frame = CGRectMake(2, 34, self.contentView.frame.size.width, 30);
    
    self.lines.frame = CGRectMake(0, self.contentView.frame.size.height, self.contentView.frame.size.width, 0.5);
//    self.lines.backgroundColor = [UIColor grayColor];

    self.timeLabel.frame = CGRectMake(100, 2, SCREEN_WIDTH-110 , 10);
    
    self.title.frame = CGRectMake(10, 34+self.contentLabel.frame.size.height, self.contentView.frame.size.width-20 , 20);
    

}

@end
