//
//  UserViewController.m
//  ForU
//
//  Created by administrator on 15/10/12.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "UserViewController.h"
#import "ChooseLoginViewController.h"
#import "HomeViewController.h"
#import "GetCodeNavigationBar.h"
#import "CollectionViewController.h"
#import "AccountViewController.h"
#import "RequstLocalData.h"
#import "OperateDatabase.h"
#import "GetCollectionNumber.h"
#import "mvCollectionViewController.h"
#import "HLJViewLayout.h"
@interface UserViewController ()
@property(strong,nonatomic)GetCodeNavigationBar *navBar;
@property(strong,nonatomic)UIImageView *img;
@property(strong,nonatomic)UIButton *portraitBtn,*collectionBtn,*followBtn,*fansBtn,*loginBtn;
@property (strong,nonatomic)UILabel *nameLabel,*collectionLabel,*followLabel,*fansLabel, *line1,*line2,*line3,*autographLabel;
@property (copy,nonatomic)NSString *autograph,*nickName,*phoneNumber;
@property (copy,nonatomic)UIImage *image;
@property (strong,nonatomic)NSMutableDictionary *infoDic;
@property (assign,nonatomic)BOOL profileClick;
@end

@implementation UserViewController
-(void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor=[UIColor whiteColor];
    [self.loginBtn setTitle:@"" forState:UIControlStateNormal];
    self.autograph=@" ";
    self.nickName=@"";
    self.collectionLabel.text = @"";
    self.autographLabel.text=@" ";
    self.image=[UIImage imageNamed:@"pic1.jpg"];
    OperateDatabase *operate=[[OperateDatabase alloc]init];
    [operate check];//判断本地数据库User表是否为空
    if(operate.click==YES){//为空
        self.profileClick=NO; //若为空则头像按钮不可点击
        self.nickName=@"请登录";
        [self initView];
        self.nameLabel.text=self.nickName;
        self.collectionLabel.text = @"0";
        self.autographLabel.text=@" ";
        self.img.image=self.image;
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        
    }
    else{
        [self requestDatebase];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    }
-(void)requestDatebase{
    self.profileClick=YES;
    RequstLocalData *request=[[RequstLocalData alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic =  [request requestLocalInfo];

        self.infoDic=dic;
        //获取用户名，昵称，头像，手机号
        self.nickName=[self.infoDic objectForKey:@"nickName"];
        if([self.nickName isEqualToString:@""]){
            self.nickName=@"U";
        }
        else{
            self.nickName=[self.infoDic objectForKey:@"nickName"];
        }
        
        self.autograph=[self.infoDic objectForKey:@"autograph"];
        if([self.autograph isEqualToString:@""]){
            self.autograph=@" ";
        }
        else{
            self.autograph=[self.infoDic objectForKey:@"autograph"];
        }

        self.phoneNumber=[self.infoDic objectForKey:@"phoneNumber"];
        //根据图片URL地址取图片
        NSString *imagePath=[self.infoDic objectForKey:@"icon"];
        if([imagePath isEqualToString:@""]){
            self.image=[UIImage imageNamed:@"pic1.jpg"];
            self.img.image=[UIImage imageNamed:@"pic1.jpg"];

        }
        else{
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imagePath];   // 保存文件的名称
            
            UIImage *img = [UIImage imageWithContentsOfFile:filePath];
            self.image=img;
        }
    //    获取ID
    NSString *userid=[dic objectForKey:@"userid"];
    int userID =[userid intValue];
    
    //获取搜藏数
    GetCollectionNumber *getNum=[[GetCollectionNumber alloc]init];
    [getNum getNum:userID andSuccess:^(NSMutableDictionary *dic) {
    ;
        
        if([dic objectForKey:@"result"] ==[NSNull null]){
            self.collectionLabel.text=@"0";
        }
        else{
                self.collectionLabel.text=[dic objectForKey:@"result"];
        }    }];
    
    
        [self initView];
        self.nameLabel.text=self.nickName;
        self.autographLabel.text=self.autograph;
        self.img.image=self.image;
        [self.loginBtn setTitle:@"设置" forState:UIControlStateNormal];

}
- (void)initView{
    self.navBar=[[GetCodeNavigationBar alloc]initWithNavBar:@"back" andLabel:@"个人主页" andBtn:nil] ;
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
     self.navBar.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3];
    self.navBar.leftBtn.tag=1;
    [self.view addSubview:self.navBar];
    
    self.img=[[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*64/667,self.view.frame.size.width ,self.view.frame.size.height*300/667) ];
    
    [self.view addSubview:self.img];
    
    self.portraitBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,self.view.frame.size.height*334/667 ,self.view.frame.size.height*60/667 ,self.view.frame.size.height*60/667 )];
    self.portraitBtn.layer.masksToBounds=YES;
    [self.portraitBtn.layer setCornerRadius:6];
    [self.portraitBtn setBackgroundImage:self.image forState:UIControlStateNormal];
    [self.portraitBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.portraitBtn.tag=2;
    [self.view addSubview:self.portraitBtn];
    
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.height*60/667+15,self.view.frame.size.height*335/667 ,self.view.frame.size.width/2 ,self.view.frame.size.height*30/667 )];
   
    [self.view addSubview:self.nameLabel];
    
    self.loginBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*285/375,self.view.frame.size.height*369/667 ,self.view.frame.size.width*80/375 , self.view.frame.size.height*20/667)];
    [self.loginBtn setTitleColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
    [self.loginBtn.layer setBorderWidth:1.0];
    [self.loginBtn.layer setBorderColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:0.7].CGColor];
    self.loginBtn.layer.masksToBounds=YES;
    [self.loginBtn.layer setCornerRadius:10];
    [self.loginBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.tag=6;
    [self.view addSubview:self.loginBtn];
    
    self.collectionBtn=[[UIButton alloc]initWithFrame:CGRectMake(10,self.view.frame.size.height*410/667 ,self.view.frame.size.width*35/375 , self.view.frame.size.height*20/667)];
    self.collectionBtn.tag=3;
    [self initBtn:@"收藏" andBtn:self.collectionBtn];
    
    self.collectionLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*35/375+15,self.view.frame.size.height*410/667 ,self.view.frame.size.width*15/375 , self.view.frame.size.height*20/667)];
   
    self.collectionLabel.font=[UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:self.collectionLabel];
    
    self.line1=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*51/375+14,self.view.frame.size.height*410/667 ,1 , self.view.frame.size.height*20/667)];
    self.line1.text=@"";
    self.line1.backgroundColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1];
    [self.view addSubview:self.line1];
    
    self.followBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*55/375+15,self.view.frame.size.height*410/667 ,self.view.frame.size.width*35/375 , self.view.frame.size.height*20/667)];
    self.followBtn.tag=4;
    [self initBtn:@"关注" andBtn:self.followBtn];
    
    self.followLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*95/375+15,self.view.frame.size.height*410/667 ,self.view.frame.size.width*15/375 , self.view.frame.size.height*20/667)];
    self.followLabel.text=@"0";
    self.followLabel.font=[UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:self.followLabel];
    
    self.line2=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*111/375+14,self.view.frame.size.height*410/667 ,1 , self.view.frame.size.height*20/667)];
    self.line2.text=@"";
    self.line2.backgroundColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1];
    [self.view addSubview:self.line2];
    
    
    self.fansBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*115/375+15,self.view.frame.size.height*410/667 ,self.view.frame.size.width*35/375 , self.view.frame.size.height*20/667)];
    self.fansBtn.tag=5;
    [self initBtn:@"粉丝" andBtn:self.fansBtn];
    
    self.fansLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*155/375+15,self.view.frame.size.height*410/667 ,self.view.frame.size.width*15/375 , self.view.frame.size.height*20/667)];
    self.fansLabel.text=@"0";
    self.fansLabel.font=[UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:self.fansLabel];
    
    self.autographLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,self.view.frame.size.height*440/667 ,self.view.frame.size.width-20 , self.view.frame.size.height*20/667)];
    self.autographLabel.font=[UIFont fontWithName:@"Arial" size:13];
    
    self.autographLabel.textColor=[UIColor  colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1];
    [self.view addSubview:self.autographLabel];
    
    self.line3=[[UILabel alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height*470/667 ,self.view.frame.size.width , 1)];
    self.line3.text=@"";
    self.line3.backgroundColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:172/255.0 alpha:0.5];
    [self.view addSubview:self.line3];
    


    
}
-(void)initBtn:(NSString *)str andBtn:(UIButton *)btn {
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)click:(UIButton *)sender{
    if(sender.tag==1){
        
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
        


    }
    
    if(sender.tag==2){
        //账户管理
        if(self.profileClick==YES){
          AccountViewController *avc=[[AccountViewController alloc]init];
          avc.delegate=self;
          [avc setValue:self.image forKey:@"image"];
          [avc setValue:self.nickName forKey:@"nickName"];
          [avc setValue:self.autograph forKey:@"autograph"];
          [avc setValue:self.phoneNumber forKey:@"phoneNumber"];
            [self.navigationController pushViewController:avc animated:YES];
            

        }
        else{
            ChooseLoginViewController *lvc=[[ChooseLoginViewController alloc]init];
                 [self.navigationController pushViewController:lvc animated:YES];
 
        }
    }
    if(sender.tag==3){
        //收藏
        CollectionViewController *cvc=[[CollectionViewController alloc]init];
        [self.navigationController pushViewController:cvc animated:YES];

    }
    if(sender.tag==4){
        //关注
        UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"功能尚未开放，敬请期待>_<" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    if(sender.tag==5){
        //粉丝
        UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"功能尚未开放，敬请期待>_<" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    if(sender.tag==6){
        //登录按钮
        if([sender.titleLabel.text isEqualToString:@"登录"]){
           ChooseLoginViewController *lvc=[[ChooseLoginViewController alloc]init];
           [self.navigationController pushViewController:lvc animated:YES];
        }
        else{
            AccountViewController *avc =[[AccountViewController alloc]init];
            [self.navigationController pushViewController:avc animated:YES];
        }

    }
}

- (void)returnMessage:(NSDictionary*)message andImage:(UIImage *)image{
    self.nameLabel.text=[message objectForKey:@"昵称"];
    self.autographLabel.text=[message objectForKey:@"签名"];
    self.image=image;
    [self.portraitBtn setBackgroundImage:self.image forState:UIControlStateNormal];
}


@end
