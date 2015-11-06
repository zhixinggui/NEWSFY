//
//  AboutForUViewController.m
//  ForU
//
//  Created by administrator on 15/10/17.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "AboutForUViewController.h"
#import "Header.h"

@interface AboutForUViewController ()

@property(strong,nonatomic)GetCodeNavigationBar *navBar;

@end

@implementation AboutForUViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

//初始化页面
-(void)initView{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navBar = [[GetCodeNavigationBar alloc] initWithNavBar:@"返回" andLabel:@"ForU" andBtn:nil];
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.backgroundColor=[UIColor colorWithRed:195/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:self.navBar];
    
    UIButton *LogoBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-40, self.view.frame.size.height/5, 80, 80)];
    [LogoBtn setBackgroundImage:[UIImage imageNamed:@"ForULogo"] forState:UIControlStateNormal];
    [LogoBtn addTarget:self action:@selector(Clicked) forControlEvents:UIControlEventTouchUpInside];
    [LogoBtn.layer setMasksToBounds:YES];
    LogoBtn.layer.cornerRadius = 25;
    [self.view addSubview:LogoBtn];
    
    UITextView *aboutMe = [[UITextView alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height/5+LogoBtn.frame.size.height+40, self.view.frame.size.width-40, self.view.frame.size.height*2/5+10)];
    aboutMe.text = @"内容来源最丰富，涵盖微博，新闻，热点,建立最人性化的推送机制。ForU基于“今日头条”模式，涵盖微博，新闻，知乎日报精选等多个热门门户的内容，用户不必去多个APP查看今日热点事件，只需ForU一个APP即可查看所有热门新闻，打造史上内容最丰富的APP。ForU的最大功能是根据用户的阅读习惯，慢慢为用户精选出用户最喜欢的新闻内容，为用户建立一个模型，让用户对此APP爱不释。";
    aboutMe.textColor = [UIColor grayColor];
    aboutMe.font = [UIFont systemFontOfSize:15];
    aboutMe.editable = NO;//不可编辑
    aboutMe.scrollEnabled = NO;//不可滑动
    aboutMe.userInteractionEnabled = NO;//用户不能交互

    [self.view addSubview:aboutMe];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-5, self.view.frame.size.height-40, 10, 10)];
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = [UIColor grayColor];
    [btn addTarget:self action:@selector(Clicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 20)];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Copyright © 2015年 胡,吕,骆 All rights reserved.";
    
    NSString *title = @"胡,吕,骆";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(18, title.length)];
    
    
    label.attributedText = str;
    
    
    [self.view addSubview:label];
}

-(void)Clicked{
    CGPoint point = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/8);
    NSArray *titles = @[@"组长:胡礼节", @"组员:吕康", @"组员:骆亮"];
    NSArray *images = @[];
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:titles images:images];
    pop.selectRowAtIndex = ^(NSInteger index){
    };
    [pop show];
}

//按钮点击事件
-(void)click:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
