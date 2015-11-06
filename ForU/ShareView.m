//
//  ShareView.m
//  ForU
//
//  Created by administrator on 15/10/26.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "ShareView.h"

@implementation ShareView
-(instancetype)initWithStyle:(NSString *)str andFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if(self){
    
        
        self.shareview = [[UIView alloc]initWithFrame:CGRectMake(15,self.frame.size.height*7/10 ,self.frame.size.width-30 ,self.frame.size.height*2/10-15 )];
        self.shareview.backgroundColor=[UIColor whiteColor];
        self.shareview.layer.masksToBounds=YES;
        [self.shareview.layer setCornerRadius:8];
        [self addSubview:self.shareview];
        
        self.sinaBtn =[[UIButton alloc]initWithFrame:CGRectMake(30,10 ,(self.shareview.frame.size.width-60)/5 ,self.shareview.frame.size.height/2)];
        self.sinaBtn.layer.masksToBounds=YES;
        [self.sinaBtn.layer setCornerRadius:8];
        [self.sinaBtn setBackgroundImage:[UIImage imageNamed:@"sinaImg"] forState:UIControlStateNormal];
        [self.shareview addSubview:self.sinaBtn];
        self.sinaLabel = [[UILabel alloc]initWithFrame:CGRectMake(30,self.shareview.frame.size.height/2+10 ,(self.shareview.frame.size.width-60)/5 ,self.shareview.frame.size.height/3)];
        self.sinaLabel.text=@"新浪微博";
        self.sinaLabel.textAlignment=NSTextAlignmentCenter;
        self.sinaLabel.font=[UIFont fontWithName:@"Arial" size:14];
        [self.shareview addSubview:self.sinaLabel];
        
        
        self.qqBtn =[[UIButton alloc]initWithFrame:CGRectMake((self.shareview.frame.size.width-60)*2/5+30,10 ,(self.shareview.frame.size.width-60)/5 ,self.shareview.frame.size.height/2)];
        self.qqBtn.layer.masksToBounds=YES;
        [self.qqBtn.layer setCornerRadius:8];
       [self.qqBtn setBackgroundImage:[UIImage imageNamed:@"qqImage"] forState:UIControlStateNormal];
        [self.shareview addSubview:self.qqBtn];
        
        self.qqLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.shareview.frame.size.width-60)*2/5+30,self.shareview.frame.size.height/2+10 ,(self.shareview.frame.size.width-60)/5 ,self.shareview.frame.size.height/3)];
        self.qqLabel.text=@"腾讯qq";
        self.qqLabel.textAlignment=NSTextAlignmentCenter;
        self.qqLabel.font=[UIFont fontWithName:@"Arial" size:14];
        [self.shareview addSubview:self.qqLabel];
        
        self.qZoneBtn =[[UIButton alloc]initWithFrame:CGRectMake((self.shareview.frame.size.width-60)*4/5+30,10 ,(self.shareview.frame.size.width-60)/5 ,self.shareview.frame.size.height/2)];
        self.qZoneBtn.layer.masksToBounds=YES;
        [self.qZoneBtn.layer setCornerRadius:8];
        [self.qZoneBtn setBackgroundImage:[UIImage imageNamed:@"qZone.jpg"] forState:UIControlStateNormal];
        
        [self.shareview addSubview:self.qZoneBtn];
        self.qZoneLabel= [[UILabel alloc]initWithFrame:CGRectMake((self.shareview.frame.size.width-60)*4/5+30,self.shareview.frame.size.height/2+10 ,(self.shareview.frame.size.width-60)/5 ,self.shareview.frame.size.height/3)];
        self.qZoneLabel.text=@"qq空间";
        self.qZoneLabel.textAlignment=NSTextAlignmentCenter;
        self.qZoneLabel.font=[UIFont fontWithName:@"Arial" size:14];
        [self.shareview addSubview:self.qZoneLabel];

        self.cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(15,self.frame.size.height*9/10 ,self.frame.size.width-30 , self.frame.size.height/10-10)];
        self.cancelBtn.layer.masksToBounds=YES;
        self.cancelBtn.backgroundColor=[UIColor whiteColor];
        [self.cancelBtn.layer setCornerRadius:8];
        [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelBtn setTitleColor:[UIColor colorWithRed:220/255.0 green:87/255.0 blue:76/255.0 alpha:1] forState:UIControlStateNormal];
        [self addSubview:self.cancelBtn];
        
        
    }
    return self;
    

    
}


@end
