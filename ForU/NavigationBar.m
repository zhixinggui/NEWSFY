//
//  NavigationBar.m
//  ForU
//
//  Created by administrator on 15/9/21.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "NavigationBar.h"
#import "Header.h"
@implementation NavigationBar

- (instancetype)initWithNavBar:(NSString*)leftBtn ForUBtnTitle:(NSString*)ForUBtn rightBtnTitle:(NSString*)rightBtn{
    self=[super initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height*64/667 )];
    if(self){
        
        self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height/10 )];
        self.imageView.image=[UIImage imageNamed:@"top_navigation_background@2x.png"];
        self.imageView.alpha = 0.8;
        [self addSubview:self.imageView];
        if(leftBtn){
            UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.02,[UIScreen mainScreen].bounds.size.height/40+10  ,[UIScreen mainScreen].bounds.size.width/9,[UIScreen mainScreen].bounds.size.height/20  )];
            imageview.image=[UIImage imageNamed:@"icon_titlebar_list@2x"];
            [self addSubview:imageview];
            
            self.leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,[UIScreen mainScreen].bounds.size.height*15/667  ,[UIScreen mainScreen].bounds.size.width/6,[UIScreen mainScreen].bounds.size.height*45/667  )];
            [self addSubview:self.leftBtn];
        }
        if(ForUBtn){
            self.ForUBtn=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3-1,SCREEN_HEIGHT*32/667-[UIScreen mainScreen].bounds.size.height/45 +10,[UIScreen mainScreen].bounds.size.width/6 ,[UIScreen mainScreen].bounds.size.height/20 )];
            [self.ForUBtn setTitle:ForUBtn forState:UIControlStateNormal];
            [self.ForUBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self addSubview:self.ForUBtn];
        }
        if(rightBtn){
            self.rightBtn=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2+1,SCREEN_HEIGHT*32/667-[UIScreen mainScreen].bounds.size.height/45+10,[UIScreen mainScreen].bounds.size.width/6 ,[UIScreen mainScreen].bounds.size.height/20 )];
            [self.rightBtn setTitle:rightBtn forState:UIControlStateNormal];
            [self.rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self addSubview:self.rightBtn];
            
        }
        self.label=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-1,SCREEN_HEIGHT*32/667-[UIScreen mainScreen].bounds.size.height/54+10, 2,[UIScreen mainScreen].bounds.size.height/27  )];
        [self.label setBackgroundColor:RGB(222, 222, 222)];
        [self addSubview:self.label];
        
    }
    
    return self;
}


@end
