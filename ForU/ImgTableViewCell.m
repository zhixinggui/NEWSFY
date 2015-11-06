//
//  ImgTableViewCell.m
//  ForU
//
//  Created by administrator on 15/11/4.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "ImgTableViewCell.h"
#import "Header.h"

@implementation ImgTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 0;
        //        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.font=[UIFont fontWithName:@"Arial" size:16];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font=[UIFont fontWithName:@"Arial" size:12];
        
        self.imageview = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.imageview];
    }
    
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(10, 10, SCREEN_WIDTH*2/3-20, SCREEN_HEIGHT/13);
    
    self.timeLabel.frame = CGRectMake(10, 10+self.titleLabel.frame.size.height+10, SCREEN_WIDTH*2/3-20, 10);
    
    self.imageview.frame = CGRectMake(SCREEN_WIDTH*0.9- SCREEN_HEIGHT/8,(self.frame.size.height- SCREEN_HEIGHT/8)/2,SCREEN_HEIGHT/6, SCREEN_HEIGHT/8);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
