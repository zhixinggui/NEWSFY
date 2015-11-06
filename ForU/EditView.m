//
//  EditView.m
//  ForU
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "EditView.h"

@implementation EditView
-(instancetype)initWithStyle:(NSString *)str andFrame:(CGRect)frame andSourse:(int)i{
    self =[super initWithFrame:frame];
    if(self){
        self.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
            self.title=[[UILabel alloc]initWithFrame:CGRectMake(10, 0,self.frame.size.width-20 , self.frame.size.height/4)];
           self.title.font=[UIFont fontWithName:@"Arial" size:16];
           self.title.text=str;
           self.title.textColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1];
//           self.title.textAlignment=NSTextAlignmentCenter;
           [self addSubview:self.title];

        self.editText=[[UITextView alloc]initWithFrame:CGRectMake(10,self.frame.size.height/4 ,self.frame.size.width-20 , self.frame.size.height/2-10)];
        self.editText.layer.masksToBounds=YES;
        [self.editText.layer setCornerRadius:6];
        self.editText.font=[UIFont fontWithName:@"Arial" size:17];
        self.editText.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.editText];
        

           self.cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width*3/5,self.frame.size.height*3/4 ,self.frame.size.width/5-10 , self.frame.size.height/4-10)];
           self.cancelBtn.layer.masksToBounds=YES;
           [self.cancelBtn.layer setCornerRadius:6];
           [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
           [self.cancelBtn setTitleColor:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:172/255.0 alpha:1] forState:UIControlStateNormal];
           [self addSubview:self.cancelBtn];
       
           self.sureBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width*4/5,self.frame.size.height*3/4 ,self.frame.size.width/5-10 , self.frame.size.height/4-10)];
           self.sureBtn.layer.masksToBounds=YES;
           [self.sureBtn.layer setCornerRadius:6];
           self.sureBtn.backgroundColor=[UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1];
           [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
           [self.sureBtn setTitleColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:0.8] forState:UIControlStateNormal];
           [self addSubview:self.sureBtn];
        
        
        
        
        if (i==3) {
            self.commentBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,self.frame.size.height*3/4 ,self.frame.size.width/5+50 , self.frame.size.height/4-10)];
            self.commentBtn.layer.masksToBounds=YES;
            [self.commentBtn.layer setCornerRadius:6];
         
            [self.commentBtn setTitle:@"查看精彩评论" forState:UIControlStateNormal];
            [self.commentBtn setTitleColor:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:172/255.0 alpha:1] forState:UIControlStateNormal];

            [self addSubview:self.commentBtn];
            

        }
        
        
    }
    return self;

}


@end
