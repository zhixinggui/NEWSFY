//
//  ViewController.m
//  ForU
//
//  Created by 胡礼节 on 15/8/29.
//  Copyright (c) 2015年 胡礼节. All rights reserved.
//1313

#import "ViewController.h"
#import "HomeViewController.h"
#import "Header.h"
#import "mvViewController.h"
#import "OperateDatabase.h"
#import "Header.h"
#import "HLJViewLayout.h"
#import "mvCollectionViewController.h"
@interface ViewController ()
{
    NSTimer *timer;
}
@property (strong,nonatomic)UIImageView *backImage;
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.backImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backImage.image=[UIImage imageNamed:@"FY.jpg"];
    [self.view addSubview:self.backImage];
    
    //判断本地数据库是否存在,不存在就创建数据库
    OperateDatabase *requestLocal=[[OperateDatabase alloc]init];
    [requestLocal creatDatebase ];


}
-(void)test{
    
    
    
    //a.初始化一个tabBar控制器
    UITabBarController *tb=[[UITabBarController alloc]init];
    //设置控制器为Window的根控制器
    [tb.tabBar setTintColor:[UIColor redColor]];
    
    //b.创建子控制器

    

    HLJViewLayout *layout = nil;
    layout = [[HLJViewLayout alloc] initWithAnim:HJCarouselAnimLinear];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    
    layout.itemSize = CGSizeMake(380, 450);
    mvCollectionViewController *c2 = [[mvCollectionViewController alloc] initWithCollectionViewLayout:layout];
    
    c2.view.backgroundColor=[UIColor brownColor];
    c2.tabBarItem.title=@"视界";
    c2.tabBarItem.image=[UIImage imageNamed:@"tabbar_icon_media_normal@2x"];
//    c2.tabBarItem.selectedImage =[UIImage imageNamed:@"tabbar_icon_media_highlight@2x"];
  

    
    HomeViewController *hvc = [[HomeViewController alloc] init];
    hvc.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_news_normal@2x"];
    hvc.tabBarItem.selectedImage =[UIImage imageNamed:@"tabbar_icon_news_highlight@2x"];
    hvc.tabBarItem.title = @"新闻";
    [timer invalidate];
    
    timer =nil;
    
    tb.tabBar.backgroundColor =RGB(244, 244, 244);
    


    tb.viewControllers=@[hvc,c2];

    [self.navigationController pushViewController:tb animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(test) userInfo:nil repeats:NO];
}

@end
