//
//  LoginViewStyle.m
//  ForU
//
//  Created by administrator on 15/10/12.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "LoginViewStyle.h"

@implementation LoginViewStyle
-(instancetype)initViewStyle:(UIImage *)img andWithBtnImage:(NSString *)str{
    self=[super init];
    if(self){
        self.isclick=NO;
        if(img){
            self.image=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5,[UIScreen mainScreen].bounds.size.width*30/375 ,[UIScreen mainScreen].bounds.size.height*50/667-10 )];
            self.image.image=img;
            [self addSubview:self.image];
        }
        self.text=[[UITextField alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*50/375, 5,[UIScreen mainScreen].bounds.size.width*280/375 ,[UIScreen mainScreen].bounds.size.height*50/667-10 )];
        [self addSubview:self.text];
        if(str){
            self.text.secureTextEntry=YES;
            self.eyeBtn=[[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*280/375, 15,[UIScreen mainScreen].bounds.size.width*30/375 ,[UIScreen mainScreen].bounds.size.height*50/667-30 )];
            [self.eyeBtn setBackgroundImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
            [self.eyeBtn setBackgroundColor:[UIColor whiteColor]];
            [self addSubview:self.eyeBtn];
        }
    }
    return self;
}
-(void)click{
    if(self.isclick==NO){
        self.text.secureTextEntry=NO;
        self.isclick=YES;
    }
    else{
        self.text.secureTextEntry=YES;
        self.isclick=NO;
    }
}


@end
