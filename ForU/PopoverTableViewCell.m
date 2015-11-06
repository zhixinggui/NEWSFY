//
//  PopoverTableViewCell.m
//  ForU
//
//  Created by administrator on 15/10/19.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "PopoverTableViewCell.h"

@implementation PopoverTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.label=[[UILabel alloc]init];
    }
    return self;
}
- (void)layoutSubviews{
 
    self.label.frame=CGRectMake(self.contentView.frame.size.width/2-40,10,80, self.contentView.frame.size.height-20);
//    self.label.backgroundColor = [UIColor grayColor];
    self.label.font = [UIFont systemFontOfSize:16];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
