//
//  TitleTableViewCell.m
//  ForU
//
//  Created by administrator on 15/10/10.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "TitleTableViewCell.h"
#import "Header.h"
@implementation TitleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.timeLabel = [[UILabel alloc]init];
        self.title=[[UILabel alloc]init];
        self.line=[[UILabel alloc]init];
        self.TitleTimeView=[[UIView alloc]init];
         self.comment = [[UILabel alloc]init];
    }
    return self;
}
- (void)layoutSubviews{
    
    int fontsize ;
    int  fontsizeT;
    if (SCREEN_HEIGHT>700) {
        fontsize = 12;
        fontsizeT = 20;
    }else if (SCREEN_HEIGHT>600){
        fontsize = 11;
        fontsizeT = 18;
    }else if (SCREEN_HEIGHT>500){
        fontsize = 11;
        fontsizeT = 17;    }else if (SCREEN_HEIGHT>400){
            fontsize = 11;
            fontsizeT = 16;    }
    
    
    
    self.title.frame=CGRectMake(10,self.contentView.frame.size.height/10 ,self.contentView.frame.size.width-20 , self.contentView.frame.size.height*3/5);
    self.title.font=[UIFont fontWithName:@"Arial" size:fontsizeT];
    self.title.numberOfLines=0;
    self.title.textColor = RGB(42, 54, 68);
    self.title.textAlignment = NSTextAlignmentCenter;
   
    
    
    NSString *str1 = self.title.text;
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:str1 attributes:@{ NSFontAttributeName: self.title.font }];
    
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){self.title.frame.size.width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    

    self.title.frame = CGRectMake(SCREEN_WIDTH*0.015,0 ,SCREEN_WIDTH*0.963 ,  ceilf(rect.size.height));
    
    
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.title.text] ;
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc]init];
    [para setLineSpacing:2.5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, [self.title.text length])];
    self.title.attributedText = attributedString;
    [self.title sizeToFit];
    
    
    
    
    self.line.frame=CGRectMake(SCREEN_WIDTH*0.015,self.contentView.frame.size.height-1 ,self.contentView.frame.size.width-20 , 1);
    self.line.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.contentView addSubview:self.line];
     self.timeLabel.frame=CGRectMake(SCREEN_WIDTH*0.015,self.title.frame.size.height+2 ,self.contentView.frame.size.width*2/3 , self.contentView.frame.size.height*1/5);
    self.timeLabel.font=[UIFont fontWithName:@"Arial" size:fontsize];
    self.timeLabel.numberOfLines=0;
    self.timeLabel.textColor = RGB(156, 156, 156);

    float height = self.title.frame.size.height+self.timeLabel.frame.size.height+2;
    float width = self.title.frame.size.width;
    
    self.TitleTimeView.frame = CGRectMake(SCREEN_WIDTH*0.015,(self.contentView.frame.size.height-height)/2,width,height);
    
    
    
    
    
    
    
    //    计算commentfame
    
    NSString *str2 = @"";
    
    NSAttributedString *attributedTextc = [[NSAttributedString alloc] initWithString:str2 attributes:@{ NSFontAttributeName: self.comment.font }];
    
    CGRect rectC = [attributedTextc boundingRectWithSize:(CGSize){self.comment.frame.size.width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    

    
    
    
    
    self.comment.frame=CGRectMake(SCREEN_WIDTH-ceilf(rectC.size.width)-SCREEN_WIDTH*0.045,self.title.frame.size.height+2 , ceilf(rectC.size.width)+2,  ceilf(rectC.size.height)+4);
    self.comment.font=[UIFont fontWithName:@"Arial" size:10];
    self.comment.numberOfLines=0;
    
    self.comment.textColor = RGB(156, 156, 156);

    self.comment.layer.cornerRadius = self.comment.frame.size.height/2;
    self.comment.text = @"1903条评论";
    

    
    
    
    [self.TitleTimeView addSubview:self.timeLabel];
    [self.TitleTimeView addSubview:self.title];
     [self.TitleTimeView addSubview:self.comment];

    [self.contentView addSubview:self.TitleTimeView];

    

}

@end
