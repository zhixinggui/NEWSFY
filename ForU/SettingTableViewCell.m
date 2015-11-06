//
//  SettingTableViewCell.m
//  ForU
//
//  Created by administrator on 15/10/12.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.label=[[UILabel alloc]init];
        self.labelDetail=[[UILabel alloc]init];
        self.line = [[UILabel alloc] init];
        self.image = [[UIImageView alloc] init];
    }
    return self;
}
- (void)layoutSubviews{
    
    self.image.frame = CGRectMake(10,10,self.contentView.frame.size.height-20, self.contentView.frame.size.height-20);
//    self.image.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.image];
    
    
    
    self.label.frame=CGRectMake(10+self.contentView.frame.size.height-20+10,10,120, self.contentView.frame.size.height-20);
//    self.label.backgroundColor = [UIColor grayColor];
//    self.label.font=[UIFont fontWithName:@"Arial" size:15];
    self.label.numberOfLines=0;
    self.label.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.label];
    
    self.labelDetail.frame=CGRectMake(self.contentView.frame.size.width-210,10 ,200, self.contentView.frame.size.height-20);
//    self.labelDetail.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    self.labelDetail.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.labelDetail];
    
    self.line.frame=CGRectMake(0, self.contentView.frame.size.height,self.contentView.frame.size.width, 0.5);
    self.line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.line];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
