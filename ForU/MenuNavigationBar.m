//
//  MenuNavigationBar.m
//  ForU
//
//  Created by administrator on 15/9/23.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "MenuNavigationBar.h"

@implementation MenuNavigationBar

- (instancetype)initWithNavBar:(NSString*)leftBtn andLabel:(NSString*)label{
    self=[super initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,64 )];
    if(self){
        self.backgroundColor=[UIColor whiteColor];
        if(leftBtn){

            self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(15,[UIScreen mainScreen].bounds.size.height/25 ,[UIScreen mainScreen].bounds.size.width*1/15,[UIScreen mainScreen].bounds.size.height/25   )];
            [self.leftBtn setImage:[UIImage imageNamed:leftBtn] forState:UIControlStateNormal];

            self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(15,[UIScreen mainScreen].bounds.size.height*30/667 ,[UIScreen mainScreen].bounds.size.width*18/375,[UIScreen mainScreen].bounds.size.height*22/667   )];
            [self.leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];

            [self addSubview:self.leftBtn];
        }
        if(label){
            self.label=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*1/15+15+10,[UIScreen mainScreen].bounds.size.height/30,[UIScreen mainScreen].bounds.size.width/4,[UIScreen mainScreen].bounds.size.height/20)];
            self.label.text=label;
            [self.label setTextAlignment:NSTextAlignmentLeft];
            self.label.font=[UIFont fontWithName:@"Arial" size:15];
            [self addSubview:self.label];
        }
    }
     return self;
}

@end
