//
//  IdentifyViewController.m
//  ForU
//
//  Created by administrator on 15/10/9.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "IdentifyViewController.h"
#import "GetCodeNavigationBar.h"
#import "ResetViewController.h"
#import "GetCode.h"
@interface IdentifyViewController ()
@property(strong,nonatomic)GetCodeNavigationBar *navBar;
@property (strong,nonatomic)UIImageView *imageView;
@property (strong,nonatomic)UIView *backgroundView;
@property(strong,nonatomic)UILabel *phoneLabel,*codeLabel,*line1,*line2,*line3;
@property(strong,nonatomic)UITextField *phoneText,*codeText;
@property (strong,nonatomic)UIButton *getCodeBtn,*nextBtn;
@property (assign,nonatomic)BOOL isClick, click;
@property (strong,nonatomic)GetCode *getCode;
@property (strong,nonatomic)NSString *phoneNumber;
@end

@implementation IdentifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.getCode=[[GetCode alloc]init];
    [self initView];
    [self setViewDetil];
}

-(void)initView{
    self.view.backgroundColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    self.navBar=[[GetCodeNavigationBar alloc]initWithNavBar:@"back" andLabel:@"找回密码" andBtn:nil];
    [self.view addSubview:self.navBar];
    
    self.line1=[[UILabel alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height*100/667 , self.view.frame.size.width,0.5)];
    
    self.phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2/15,self.view.frame.size.height*100/667 , self.view.frame.size.width*3/15,self.view.frame.size.height*50/667 )];
    
    self.phoneText=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width*5/15,self.view.frame.size.height*100/667 , self.view.frame.size.width*8/15,self.view.frame.size.height*50/667 )];
    
    self.line2=[[UILabel alloc]initWithFrame:CGRectMake(15,self.view.frame.size.height*155/667 , self.view.frame.size.width-30,0.5)];
    
    self.codeLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*2/15,self.view.frame.size.height*160/667 , self.view.frame.size.width*3/15,self.view.frame.size.height*50/667 )];
    
    self.codeText=[[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width*5/15,self.view.frame.size.height*160/667 , self.view.frame.size.width*4/15,self.view.frame.size.height*50/667 )];
    
    self.getCodeBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*10/15,self.view.frame.size.height*165/667 , self.view.frame.size.width*4/15,self.view.frame.size.height*40/667)];
    
    self.line3=[[UILabel alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height*215/667 , self.view.frame.size.width,0.5)];
    
    self.nextBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,self.view.frame.size.height*230/667 , self.view.frame.size.width-20,self.view.frame.size.height*50/667 )];
    
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.phoneText];
    [self.view addSubview:self.codeLabel];
    [self.view addSubview:self.codeText];
    [self.view addSubview:self.getCodeBtn];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.line3];
    [self.view addSubview:self.nextBtn];

    

}
-(void)setViewDetil{
    self.view.backgroundColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    
    

    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.leftBtn.tag=1;
    
    self.navBar.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3];
    
    self.phoneLabel.text=@"手机号";
    [self.phoneLabel setTextColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1]];
    
    self.codeLabel.text=@"验证码";
    [self.codeLabel setTextColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1]];
    
    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCodeBtn setTitleColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
    self.getCodeBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
    [self.getCodeBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.getCodeBtn.layer setBorderWidth:1];
    [self.getCodeBtn.layer setMasksToBounds:YES];
    [self.getCodeBtn.layer setCornerRadius:8];
    self.getCodeBtn.tag=2;
    
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.nextBtn setBackgroundColor:[UIColor colorWithRed:220/255.0 green:87/255.0 blue:76/255.0 alpha:1]];
    [self.nextBtn.layer setMasksToBounds:YES];
    [self.nextBtn.layer setCornerRadius:3];
    self.nextBtn.tag=3;
    
    self.line1.text=@"";
    self.line1.backgroundColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:0.4];
    
    self.line2.text=@"";
    self.line2.backgroundColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:0.4];
    
    self.line3.text=@"";
    self.line3.backgroundColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:0.4];
    self.isClick=NO;
    self.click=NO;
    



  
    
}
-(void)click:(UIButton *)sender{
    if(sender.tag==1){
        [self.navigationController popViewControllerAnimated:YES];
    }
    if(sender.tag==2){
        if(self.isClick==NO){
            //如果手机号正确
            if([self isValidateMobile:self.phoneText.text]){
                self.isClick=YES;
                [self performSelector:@selector(reflashGetKeyBt:) withObject:[NSNumber numberWithInt:30] afterDelay:0];
                [self.getCode getCode:self.phoneText.text]; //调用GetCode类的获取验证码方法
            }
            else{
                UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"号码输入错误，请重新输入" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }
    if(sender.tag==3){
        if(self.click==NO){
            [self.getCode  validateCode:self.codeText.text andPhone:self.phoneText.text andWith:self];
            self.click=YES;
        }
    }
}
- (void)reflashGetKeyBt:(NSNumber *)second{
    if ([second integerValue] == 0){
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.isClick=NO;
        self.click=NO;
    }
    
    else{
        int i = [second intValue];
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%i秒后重发",i] forState:UIControlStateNormal];
        [self performSelector:@selector(reflashGetKeyBt:) withObject:[NSNumber numberWithInt:i-1] afterDelay:1];
    }
}


//判断手机号是否正确
-(BOOL) isValidateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"1[34578]\\d{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
