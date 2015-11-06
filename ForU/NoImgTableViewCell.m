//
//  NoImgTableViewCell.m
//  ForU
//
//  Created by administrator on 15/11/4.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "NoImgTableViewCell.h"
#import "Header.h"

@implementation NoImgTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 0;
        //        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.font=[UIFont fontWithName:@"Arial" size:16];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font=[UIFont fontWithName:@"Arial" size:12];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeLabel];
        
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, SCREEN_HEIGHT/13);
    
    self.timeLabel.frame = CGRectMake(10, 10+self.titleLabel.frame.size.height+10, SCREEN_WIDTH*2/3-20, 10);
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
