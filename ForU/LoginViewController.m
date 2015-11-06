//
//  LoginViewController.m
//  ForU
//
//  Created by administrator on 15/9/21.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "LoginViewController.h"
#import "SelectLogin.h"
#import "UMSocial.h"
#import "RegisterViewController.h"
#import "HomeViewController.h"
#import "IdentifyViewController.h"
#import "LoginViewStyle.h"
#import "GetCodeNavigationBar.h"
#import "RequstUserInfo.h"
#import "OperateDatabase.h"
#import "JudgeLoginInformation.h"
#import "DownImageModel.h"
#import "Header.h"
#import "HLJViewLayout.h"
#import "mvCollectionViewController.h"
#define mainSize    [UIScreen mainScreen].bounds.size

#define offsetLeftHand      58

#define rectLeftHand        CGRectMake(58-offsetLeftHand, 90, 40, 65)
#define rectLeftHandGone    CGRectMake(mainSize.width / 2 - 100, self.phoneNumberView.frame.origin.y - 22, 40, 40)

#define rectRightHand       CGRectMake(imgLogin.frame.size.width / 2 + 60, 90, 40, 65)
#define rectRightHandGone   CGRectMake(mainSize.width / 2 + 65, self.phoneNumberView.frame.origin.y - 22, 40, 40)



@interface LoginViewController ()<UITextFieldDelegate>
{
   LoginShowType showType;
}
@property(strong,nonatomic)GetCodeNavigationBar *navBar;
@property(strong,nonatomic)UIButton *loginBtn,*registerBtn,*forgetBtn;
@property (strong,nonatomic)UIImageView *imageView,*imgLeftHand,* imgRightHand,* imgLeftHandGone,* imgRightHandGone,*headImg;
@property (strong,nonatomic)UIView  *backgroundView;
@property (strong,nonatomic)UILabel *lineLabel;
@property (strong,nonatomic)LoginViewStyle  *passwordView,*phoneNumberView;
@property(strong,nonatomic)SelectLogin *selectLogin;
@property (assign,nonatomic)BOOL loginClick;

@end

@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginClick=NO;
    self.selectLogin=[[SelectLogin alloc]init];
    [self setView];
    [self setViewDetail];

}
-(void)setView{
    self.view.backgroundColor=[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    
    self.navBar=[[GetCodeNavigationBar alloc]initWithNavBar:@"back" andLabel:@"手机号登录" andBtn:nil] ;
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.leftBtn.tag=1;
    self.navBar.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.4];
    [self.view addSubview:self.navBar];
    
    self.phoneNumberView =[[LoginViewStyle alloc]initViewStyle:[UIImage imageNamed:@"user@2x"] andWithBtnImage:nil];
    self.phoneNumberView.frame=CGRectMake(self.view.frame.size.width/15,self.view.frame.size.height*260/667 ,self.view.frame.size.width*13/15 ,self.view.frame.size.height*50/667 );
    self.phoneNumberView.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    self.phoneNumberView.text.delegate=self;
    
    self.lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/15,self.view.frame.size.height*310/667 ,self.view.frame.size.width*13/15 ,1 )];
    
    self.passwordView =[[LoginViewStyle alloc]initViewStyle:[UIImage imageNamed:@"password"] andWithBtnImage:@"eye"];
    self.passwordView.frame=CGRectMake(self.view.frame.size.width/15,self.view.frame.size.height*310/667+1 ,self.view.frame.size.width*13/15 ,self.view.frame.size.height*50/667);
    self.passwordView.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    self.passwordView.text.delegate=self;
    [self.passwordView.eyeBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.passwordView.eyeBtn.tag=7;

    self.loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/15,self.view.frame.size.height*390/667 ,self.view.frame.size.width*13/15 ,self.view.frame.size.height*50/667 )];
    
    self.forgetBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/15,self.view.frame.size.height*450/667 ,self.view.frame.size.width*4/15 ,self.view.frame.size.height*30/667 )];
    self.registerBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*10/15,self.view.frame.size.height*450/667 ,self.view.frame.size.width*4/15 ,self.view.frame.size.height*30/667 )];
    [self initPic];
 
    
    
    [self.view addSubview:self.phoneNumberView];
    [self.view addSubview:self.passwordView];
    
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.forgetBtn];
    
}
//动画面
-(void)initPic{
    UIImageView* imgLogin = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100,self.view.frame.size.height*150/667 ,200 ,self.view.frame.size.height*120/667)];
    imgLogin.image = [UIImage imageNamed:@"head"];
    imgLogin.layer.masksToBounds = YES;
    [self.view addSubview:imgLogin];
    
    self.imgLeftHand = [[UIImageView alloc] initWithFrame:rectLeftHand];
    self.imgLeftHand.image = [UIImage imageNamed:@"lefthand"];
    [imgLogin addSubview:self.imgLeftHand];
    
    self.imgRightHand = [[UIImageView alloc] initWithFrame:rectRightHand];
    self.imgRightHand.image = [UIImage imageNamed:@"righthand"];
    [imgLogin addSubview:self.imgRightHand];
    
    

    
    self.imgLeftHandGone = [[UIImageView alloc] initWithFrame:rectLeftHandGone];
    self.imgLeftHandGone.image = [UIImage imageNamed:@"ground"];
    [self.view addSubview:self.imgLeftHandGone];
    
    self.imgRightHandGone = [[UIImageView alloc] initWithFrame:rectRightHandGone];
    self.imgRightHandGone.image = [UIImage imageNamed:@"ground"];
    [self.view addSubview:self.imgRightHandGone];
}
-(void)setViewDetail{
    
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor=[UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1];
    [self.loginBtn.layer setMasksToBounds:YES];
    [self.loginBtn.layer setCornerRadius:6];
    [self.loginBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.tag=2;
    
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1]  forState:UIControlStateNormal];
    [self.registerBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
    self.registerBtn.tag=3;
    
    [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetBtn setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    [self.forgetBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.forgetBtn.tag=4;
}
-(void)click:(UIButton *)sender{
    if(sender.tag==1){
        //回到上一页
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if(sender.tag==2){
        if(self.loginClick==NO){
         self.loginClick=YES;
         JudgeLoginInformation *judge=[[JudgeLoginInformation alloc]init];
         [judge judgeUserInfo:self.phoneNumberView.text.text andSuccess:^(NSMutableDictionary *dic){
             NSMutableArray *array=[dic objectForKey:@"result"];
            if([array isKindOfClass:[NSNull class]]){
                UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"用户尚未注册" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                self.loginClick=NO;
            }
            else{
                NSMutableDictionary *infoDic=[array objectAtIndex:0];
                 NSString *password=[infoDic objectForKey:@"password"];
                if([self.passwordView.text.text isEqualToString:password]){
                    NSLog(@"%@",infoDic);
                    
                    int userid=[[infoDic objectForKey:@"userid" ]intValue];
                    
                    NSLog(@"%d",userid);
               
                    
                    
                    RequstUserInfo *requestInfo=[[RequstUserInfo alloc]init];
                    OperateDatabase *operate=[[OperateDatabase alloc]init];
                   //移除user表中信息
                   [operate deleteData];
                   //userid由输入的号码查询用户表获取
                   [requestInfo requestUserInfo:userid andSuccess:^(NSMutableDictionary *dic){
                    //插入数据到本地数据库

                   [operate insertData:dic];
                       
                       
                       DownImageModel *downLoadModel = [[DownImageModel alloc]init];
                       [downLoadModel downLoad:[dic valueForKey:@"icon"]];
                       
                       
                       HomeViewController *hvc=[[HomeViewController alloc]init];
                       
                       
                       //a.初始化一个tabBar控制器
                       UITabBarController *tb=[[UITabBarController alloc]init];
                       //设置控制器为Window的根控制器
                       [tb.tabBar setTintColor:[UIColor redColor]];
                       
                       HLJViewLayout *layout = nil;
                       layout = [[HLJViewLayout alloc] initWithAnim:HJCarouselAnimLinear];
                       layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
                       
                       
                       
                       layout.itemSize = CGSizeMake(380, 450);
                       mvCollectionViewController *c2 = [[mvCollectionViewController alloc] initWithCollectionViewLayout:layout];
                       
                       c2.view.backgroundColor=[UIColor brownColor];
                       c2.tabBarItem.title=@"视界";
                       c2.tabBarItem.image=[UIImage imageNamed:@"tabbar_icon_media_normal@2x"];
                       //    c2.tabBarItem.selectedImage =[UIImage imageNamed:@"tabbar_icon_media_highlight@2x"];
                       
                       
                       
                       
                       hvc.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_news_normal@2x"];
                       hvc.tabBarItem.selectedImage =[UIImage imageNamed:@"tabbar_icon_news_highlight@2x"];
                       hvc.tabBarItem.title = @"新闻";
                       
                       
                       
                       tb.tabBar.backgroundColor =RGB(244, 244, 244);
                       
                       
                       
                       tb.viewControllers=@[hvc,c2];
                       
                       UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:tb];
                       
                       
                       
                       
                       [self presentViewController:nv animated:YES completion:nil];
                       

                }];
                
            }
            
            else{
                self.loginClick=NO;
                UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"密码错误请重新输入" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            }
            
            
        }];
        }
        else{
            
        }
    }
    if(sender.tag==3){
        //注册页
        RegisterViewController *rvc=[[RegisterViewController alloc]init];
               [self.navigationController pushViewController:rvc animated:YES];
//        [self presentViewController:rvc animated:YES completion:nil];
        }
    if(sender.tag==4){
        //找回密码页
        IdentifyViewController *ivc=[[IdentifyViewController alloc]init];
               [self.navigationController pushViewController:ivc animated:YES];
//        [self presentViewController:ivc animated:YES completion:nil];
        
    }
    if(sender.tag==7){
        [self.passwordView click];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//动画
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.secureTextEntry==NO) {
        if (showType != JxbLoginShowType_PASS)
        {
            showType = JxbLoginShowType_USER;
            return;
        }
        showType = JxbLoginShowType_USER;
        [UIView animateWithDuration:0.5 animations:^{
            self.imgLeftHand.frame = CGRectMake(self.imgLeftHand.frame.origin.x - offsetLeftHand, self.imgLeftHand.frame.origin.y + 30, self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height);
            
            self.imgRightHand.frame = CGRectMake(self.imgRightHand.frame.origin.x + 48, self.imgRightHand.frame.origin.y + 30, self.imgRightHand.frame.size.width, self.imgRightHand.frame.size.height);
            
            
            self.imgLeftHandGone.frame = CGRectMake(self.imgLeftHandGone.frame.origin.x - 70, self.imgLeftHandGone.frame.origin.y, 40, 40);
            
            self.imgRightHandGone.frame = CGRectMake(self.imgRightHandGone.frame.origin.x + 30, self.imgRightHandGone.frame.origin.y, 40, 40);
            
            
        } completion:^(BOOL b) {
        }];
        
    }
    else  {
        if (showType == JxbLoginShowType_PASS)
        {
            showType = JxbLoginShowType_PASS;
            return;
        }
        showType = JxbLoginShowType_PASS;
        [UIView animateWithDuration:0.5 animations:^{
            self.imgLeftHand.frame = CGRectMake(self.imgLeftHand.frame.origin.x + offsetLeftHand, self.imgLeftHand.frame.origin.y - 30, self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height);
            self.imgRightHand.frame = CGRectMake(self.imgRightHand.frame.origin.x - 48, self.imgRightHand.frame.origin.y - 30, self.imgRightHand.frame.size.width,self.imgRightHand.frame.size.height);
            
            
            self.imgLeftHandGone.frame = CGRectMake(self.imgLeftHandGone.frame.origin.x + 70, self.imgLeftHandGone.frame.origin.y, 0, 0);
            
           self. imgRightHandGone.frame = CGRectMake(self.imgRightHandGone.frame.origin.x - 30, self.imgRightHandGone.frame.origin.y, 0, 0);
            
        } completion:^(BOOL b) {
        }];
    }
}

//收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return 0;
    }
    return YES;
}





@end
