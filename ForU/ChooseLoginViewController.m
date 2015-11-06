//
//  ChooseLoginViewController.m
//  ForU
//
//  Created by administrator on 15/10/12.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "ChooseLoginViewController.h"
#import "GetCodeNavigationBar.h"
#import "LoginViewController.h"
#import "SelectLogin.h"
@interface ChooseLoginViewController ()
@property(strong,nonatomic)GetCodeNavigationBar *navBar;
@property(strong,nonatomic)UIImageView *backgroundImg;
@property (strong,nonatomic)UIButton *phoneBtn,*sinaBtn,*QQBtn;
@property(strong,nonatomic)SelectLogin *selectLogin;
@end

@implementation ChooseLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectLogin=[[SelectLogin alloc]init];
    [self initView];
    
}
-(void)initView{
    
    self.backgroundImg=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    self.backgroundImg.image=[UIImage imageNamed:@"FY.jpg"];
    [self.view addSubview:self.backgroundImg];
    self.navBar=[[GetCodeNavigationBar alloc]initWithNavBar:@"back" andLabel:@"选择登录方式" andBtn:nil];
    self.navBar.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.leftBtn.tag=1;
    [self.view addSubview:self.navBar];
    
    self.phoneBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/8,self.view.frame.size.height*380/667 ,self.view.frame.size.width*6/8 ,self.view.frame.size.height*50/667 )];
    self.phoneBtn.tag=2;
    [self initBtn:@"手机号登录" andWithBtn:self.phoneBtn];
    
    self.sinaBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/8,self.view.frame.size.height*450/667 ,self.view.frame.size.width*6/8 ,self.view.frame.size.height*50/667 )];
    self.sinaBtn.tag=3;
    [self initBtn:@"新浪微博登录" andWithBtn:self.sinaBtn];
    
    self.QQBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/8,self.view.frame.size.height*520/667 ,self.view.frame.size.width*6/8 ,self.view.frame.size.height*50/667 )];
    self.QQBtn.tag=4;
    [self initBtn:@"手机QQ登录" andWithBtn:self.QQBtn];
    
    
    
    
}
-(void)initBtn:(NSString *)str andWithBtn:(UIButton *)sender{
    [sender setTitle:str forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    sender.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
    [sender setTitleColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
    sender.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7];
    sender.layer.masksToBounds=YES;
    [sender.layer setCornerRadius:5];
    [self.view addSubview:sender];
}
-(void)click:(UIButton *)sender{
    if(sender.tag==1){
        [self.navigationController popViewControllerAnimated:YES];
    }
    if(sender.tag==2){
        LoginViewController *lvc=[[LoginViewController alloc]init];
        [self.navigationController pushViewController:lvc animated:YES];

    }
    if(sender.tag==3){
        [self.selectLogin LoginBySina:self];
    }
    if(sender.tag==4){
        [self.selectLogin LoginByQQ:self];
    }
    
}


@end
