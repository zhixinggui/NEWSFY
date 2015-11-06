//
//  SettingTableViewCell3.m
//  ForU
//
//  Created by administrator on 15/10/19.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "SettingTableViewCell3.h"

@implementation SettingTableViewCell3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.label=[[UILabel alloc]init];
        self.line = [[UILabel alloc] init];
    }
    return self;
}
- (void)layoutSubviews{
    

    
    self.label.frame=CGRectMake(self.contentView.frame.size.width/2-60,10,120, self.contentView.frame.size.height-20);
//    self.label.backgroundColor = [UIColor grayColor];
//    self.label.font=[UIFont fontWithName:@"Arial" size:15];
    
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.textColor = [UIColor redColor];
    [self.contentView addSubview:self.label];
    
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
