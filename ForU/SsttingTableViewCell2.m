//
//  SsttingTableViewCell2.m
//  ForU
//
//  Created by administrator on 15/10/19.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "SsttingTableViewCell2.h"

@implementation SsttingTableViewCell2

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.label=[[UILabel alloc]init];
        self.image2=[[UIImageView alloc]init];
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
    
    self.image2.frame=CGRectMake(self.contentView.frame.size.width-self.contentView.frame.size.height+20,15 ,8, self.contentView.frame.size.height-30);

//    self.image2.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.image2];
    
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
