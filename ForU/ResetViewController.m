//
//  ResetViewController.m
//  ForU
//
//  Created by administrator on 15/10/9.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "ResetViewController.h"
#import "GetCodeNavigationBar.h"
#import "OperateDatabase.h"
#import "JudgeLoginInformation.h"
#import "UploadData.h"
#import "LoginViewController.h"
@interface ResetViewController ()
@property(strong,nonatomic)GetCodeNavigationBar *navBar;
@property (strong,nonatomic)UIImageView *imageView;
@property (strong,nonatomic)UIView *backgroundView;
@property(strong,nonatomic)UILabel *confirmLabel,*codeLabel,*line1,*line2,*line3;
@property (copy,nonatomic)NSString *phoneNumber;
@property(strong,nonatomic)UITextField *confirmText,*codeText;
@property(strong,nonatomic)UIButton *submitBtn;
@property (assign,nonatomic)BOOL click;
@end

@implementation ResetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self setViewDetail];
    
   
    
}
-(void)initView{
   
    
    self.navBar=[[GetCodeNavigationBar alloc]initWithNavBar:@"back" andLabel:@"重置密码" andBtn:nil];
    [self.view addSubview:self.navBar];
    
    self.line1=[[UILabel alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height*100/667 , self.view.frame.size.width,0.5)];
    
    self.codeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2/16,self.view.frame.size.height*100/667 , self.view.frame.size.width*5/16,self.view.frame.size.height*50/667 )];
    
    self.codeText=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width*7/16,self.view.frame.size.height*100/667 , self.view.frame.size.width*7/16,self.view.frame.size.height*50/667 )];
    
    self.line2=[[UILabel alloc]initWithFrame:CGRectMake(15,self.view.frame.size.height*155/667 , self.view.frame.size.width-30,0.5)];
    
    self.confirmLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2/16,self.view.frame.size.height*160/667 , self.view.frame.size.width*5/16,self.view.frame.size.height*50/667 )];
    
    self.confirmText=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width*7/16,self.view.frame.size.height*160/667 , self.view.frame.size.width*7/16,self.view.frame.size.height*50/667 )];
    
    self.line3=[[UILabel alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height*215/667 , self.view.frame.size.width,0.5)];
    
    self.submitBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2/16,self.view.frame.size.height*230/667 , self.view.frame.size.width*12/16,self.view.frame.size.height*50/667)];
    
    
    
    [self.view addSubview:self.confirmLabel];
    [self.view addSubview:self.confirmText];
    [self.view addSubview:self.codeLabel];
    [self.view addSubview:self.codeText];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.line3];
    [self.view addSubview:self.submitBtn];
   
    

}
-(void)setViewDetail{
    
    self.view.backgroundColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    self.navBar.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3];
    
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.leftBtn.tag=1;
    
    self.codeLabel.text=@"新密码";
    [self.codeLabel setTextColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1]];
    self.confirmLabel.text=@"确认新密码";
    [self.confirmLabel setTextColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1]];
    

    
    [self.submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitBtn setBackgroundColor:[UIColor colorWithRed:220/255.0 green:87/255.0 blue:76/255.0 alpha:0.9]];
    [self.submitBtn.layer setMasksToBounds:YES];
    [self.submitBtn.layer setCornerRadius:3];
    self.submitBtn.tag=2;
    
    self.line1.text=@"";
    self.line1.backgroundColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:0.4];
    
    self.line2.text=@"";
    self.line2.backgroundColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:0.4];
    
    self.line3.text=@"";
    self.line3.backgroundColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:0.4];
    
    
    

}
-(void)click:(UIButton *)sender{
    if(sender.tag==1){
        [self.navigationController popViewControllerAnimated:YES];
    }
    if(sender.tag==2){
       {
           //输入为空
           if([self.codeText.text isEqualToString:@" "]){
            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"密码不能为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
         }
          //两次相等
         else if([self.codeText.text isEqualToString:self.confirmText.text]){
            self.click=YES;
            JudgeLoginInformation *judge=[[JudgeLoginInformation alloc]init];
            [judge judgeUserInfo:self.phoneNumber andSuccess:^(NSMutableDictionary *dic) {
                NSMutableArray *array=[dic objectForKey:@"result"];
                if([array isKindOfClass:[NSNull class]]){
                    UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"用户尚未注册" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    self.click=NO;
                }
                else{
                    NSMutableDictionary *infoDic=[array objectAtIndex:0];
                    int user=[[infoDic objectForKey:@"userid" ]intValue];
                    //更新网络信息
                    UploadData *upload=[[UploadData alloc]init];
                    [upload uploadUserInfo:user andCulm:@"password" andValue:self.codeText.text andSuccess:^(NSMutableDictionary *dic){
//                        LoginViewController *lvc=[[LoginViewController alloc]init];
//                        [self.navigationController popToViewController:lvc animated:YES];
//                        [self presentViewController:lvc animated:YES completion:nil];
                        LoginViewController *lvc=[[LoginViewController alloc]init];
                        UINavigationController *nv=[[UINavigationController alloc]initWithRootViewController:lvc];
                        
                        [self presentViewController:nv animated:YES completion:nil];
                    }];
                    UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"重置密码成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];

                }
            }];
        }
            
        
        //两次输入不一致
        else{
            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"两次输入不一致，请重新输入" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
