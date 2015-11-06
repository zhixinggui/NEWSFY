//
//  UserTableViewCell.m
//  ForU
//
//  Created by administrator on 15/10/13.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "UserTableViewCell.h"

@implementation UserTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
       self.leftLabel=[[UILabel alloc]init];
        self.rightLabel=[[UILabel alloc]init];
        self.line=[[UILabel alloc]init];
    }
    return self;
}
- (void)layoutSubviews{
    self.leftLabel.frame=CGRectMake(15,self.contentView.frame.size.height/10 ,self.contentView.frame.size.width/4 , self.contentView.frame.size.height*4/5);
    self.leftLabel.font=[UIFont fontWithName:@"Arial" size:15];
    self.leftLabel.textColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1];
    [self.contentView addSubview:self.leftLabel];
    
    self.rightLabel.frame=CGRectMake(self.contentView.frame.size.width*1/4+15,self.contentView.frame.size.height/10 ,self.contentView.frame.size.width*3/4-30 ,self.contentView.frame.size.height*4/5);
    self.rightLabel.font=[UIFont fontWithName:@"Arial" size:16];
    self.rightLabel.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:172/255.0 alpha:1];
    self.rightLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:self.rightLabel];
    self.line.frame=CGRectMake(15,self.contentView.frame.size.height-0.3 ,self.contentView.frame.size.width-15 , 0.3);
    self.line.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
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
