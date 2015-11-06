//
//  GetCodeNavigationBar.m
//  ForU
//
//  Created by administrator on 15/10/9.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "GetCodeNavigationBar.h"
#import "Header.h"
@implementation GetCodeNavigationBar
- (instancetype)initWithNavBar:(NSString*)leftBtn andLabel:(NSString*)label andBtn:(NSString *)str{
    self=[super initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height*64/667 )];
    if(self){
        self.backgroundColor=[UIColor whiteColor];
        if(leftBtn){
            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(15,[UIScreen mainScreen].bounds.size.height*28/667 ,[UIScreen mainScreen].bounds.size.width*18/375,[UIScreen mainScreen].bounds.size.height*20/667   )];
            imageview.image=[UIImage imageNamed:leftBtn];
             [self addSubview:imageview];

            self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(15,[UIScreen mainScreen].bounds.size.height*10/667 ,[UIScreen mainScreen].bounds.size.width*40/375,[UIScreen mainScreen].bounds.size.height*45/667   )];
            
            self.leftBtn.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:self.leftBtn];
        }
        if(label){
            self.label=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/5,[UIScreen mainScreen].bounds.size.height/30,[UIScreen mainScreen].bounds.size.width*3/5,[UIScreen mainScreen].bounds.size.height/20)];
            self.label.text=label;
            [self.label setTextAlignment:NSTextAlignmentCenter];
            self.label.font=[UIFont fontWithName:@"Arial" size:17];
            self.label.textColor = [UIColor whiteColor];
            [self addSubview:self.label];
        }
        if(str){
            self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*22/25,[UIScreen mainScreen].bounds.size.height/28,[UIScreen mainScreen].bounds.size.width*1/10,[UIScreen mainScreen].bounds.size.height/20)];
                      [self.rightBtn setBackgroundImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
            self.rightBtn.contentMode = UIViewContentModeScaleAspectFit;

            [self addSubview:self.rightBtn];
        }
    }
    return self;
}

@end
