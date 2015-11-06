//
//  MessageViewController.m
//  ForU
//
//  Created by administrator on 15/9/23.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "MessageViewController.h"
#import "MenuNavigationBar.h"
@interface MessageViewController ()<UIScrollViewDelegate>
@property(strong,nonatomic)GetCodeNavigationBar *navBar;
@property (strong,nonatomic)UIButton *commentBtn,*informBtn;
@property (strong,nonatomic)UILabel *label;
@property (strong,nonatomic)UIView *commentView,*informView;
@property (strong,nonatomic)UIScrollView *mainScroll;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];

    [self initView];
}
-(void)initView{
    self.navBar = [[GetCodeNavigationBar alloc] initWithNavBar:@"返回" andLabel:@"评论/通知" andBtn:nil];
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.backgroundColor=[UIColor colorWithRed:195/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:self.navBar];
    
    self.commentBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/10, self.view.frame.size.height/10,self.view.frame.size.width*3/10 ,self.view.frame.size.height/10-10 )];
    [self.commentBtn setTitle:@"评论我的" forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.commentBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.commentBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
    [self.view addSubview:self.commentBtn];
    
    self.informBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/5,self.view.frame.size.height/10 ,self.view.frame.size.width*3/10 , self.view.frame.size.height/10-10)];
    [self.informBtn setTitle:@"通知" forState:UIControlStateNormal];
    [self.informBtn setTitleColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
    self.informBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
    [self.informBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.informBtn];
    
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height/5-10 ,self.view.frame.size.width ,1 )];
    self.label.text=@"";
    self.label.backgroundColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:172/255.0 alpha:1];
    [self.view addSubview:self.label];
    
  
    //ScrollView设置
    self.mainScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height/5-9 ,self.view.frame.size.width ,self.view.frame.size.height )];
    self.mainScroll.delegate=self;
    self.mainScroll.pagingEnabled=YES; //分页效果
    self.mainScroll.showsHorizontalScrollIndicator=NO; //隐藏水平滚动条
    self.mainScroll.contentSize=CGSizeMake(self.view.frame.size.width*2,self.view.frame.size.height ); //设置滚动范围
    [self.view addSubview:self.mainScroll];
    self.commentView=[[UIView alloc]initWithFrame:CGRectMake(0,0 ,self.view.frame.size.width ,self.view.frame.size.height )];
//    self.commentView.backgroundColor=[UIColor grayColor];
    UIImageView *comment = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/10, self.view.frame.size.width/2, self.view.frame.size.height/3)];
    comment.image = [UIImage imageNamed:@"评论.jpg"];
    [self.commentView addSubview:comment];
    [self.mainScroll addSubview:self.commentView];
    UILabel *commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/10+comment.frame.size.height+10, self.view.frame.size.width, 20)];
    commentLabel.text = @"暂时还没有评论,加油评论吧~";
    commentLabel.font = [UIFont systemFontOfSize:15];
    commentLabel.textAlignment = NSTextAlignmentCenter;
    commentLabel.textColor = [UIColor grayColor];
    [self.mainScroll addSubview:commentLabel];
    
    
    self.informView=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width,0  ,self.view.frame.size.width ,self.view.frame.size.height )];
    [self.mainScroll addSubview:self.informView];
    
    UIImageView *inform = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/10, self.view.frame.size.width/2, self.view.frame.size.height/3)];
    inform.image = [UIImage imageNamed:@"通知.jpg"];
    [self.informView addSubview:inform];
    
    UILabel *informLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width, self.view.frame.size.height/10+inform.frame.size.height+10, self.view.frame.size.width, 20)];
    informLabel.text = @"暂时还没有通知哟 ~ ~";
    informLabel.font = [UIFont systemFontOfSize:15];
    informLabel.textAlignment = NSTextAlignmentCenter;
    informLabel.textColor = [UIColor grayColor];
    [self.mainScroll addSubview:informLabel];

    
    
    
}
//按钮点击事件处理
-(void)click:(UIButton *)sender{
    if([sender.titleLabel.text isEqualToString:@"评论我的"]){
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.informBtn setTitleColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            self.mainScroll.contentOffset=CGPointMake(0, 0);
        } completion:^(BOOL finished) {
        }];
    }
    else if([sender.titleLabel.text isEqualToString:@"通知"]){
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.commentBtn setTitleColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
       
        [UIView animateWithDuration:0.5 animations:^{
        self.mainScroll.contentOffset=CGPointMake(self.view.frame.size.width, 0);
        } completion:^(BOOL finished) {
        }];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];

    }
}



//ScrollView滑动结束时调用该方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat x=self.mainScroll.contentOffset.x;
    if(x==self.view.frame.size.width){
       [self.commentBtn setTitleColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
       [ self.informBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    else{
        [self.informBtn setTitleColor:[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1] forState:UIControlStateNormal];
        [ self.commentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
