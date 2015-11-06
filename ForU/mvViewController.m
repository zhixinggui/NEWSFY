//
//  mvViewController.m
//  ForU
//
//  Created by 胡礼节 on 15/11/2.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "mvViewController.h"

#import "Header.h"
@interface mvViewController ()<UIScrollViewDelegate >

@property (retain,nonatomic,readonly) UIPageControl * pageControl;

@property (copy, nonatomic)NSString *cityName;
@property (strong,nonatomic)NSMutableDictionary *infoDic;
@property (strong,nonatomic)UIScrollView *sv;
@property (assign,nonatomic)int i;
@end

@implementation mvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    
    self.sv =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    self.sv.delegate=self;
    self.sv.contentSize=CGSizeMake(self.view.frame.size.width*24/10, 0);//滑动范围
    self.sv.backgroundColor=[UIColor whiteColor];
    self.sv.showsHorizontalScrollIndicator=NO; //不显示水平滑动线
    self.sv.bounces=YES;//没有弹簧效果
    self.sv.scrollEnabled=YES;
    [self.view addSubview:self.sv];
    
    UIView *view1 =[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5,0,SCREEN_WIDTH*3/5, SCREEN_HEIGHT*4/5)];
    view1.backgroundColor=[UIColor blueColor];
    [self.sv addSubview:view1];
    
    UIView *view2 =[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*9/10, 0,SCREEN_WIDTH*3/5, SCREEN_HEIGHT*4/5)];
    view2.backgroundColor=[UIColor blackColor];
    [self.sv addSubview:view2];
    
    UIView *view3 =[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*16/10, 0,SCREEN_WIDTH*3/5, SCREEN_HEIGHT*4/5)];
    view3.backgroundColor=[UIColor redColor];
    [self.sv addSubview:view3];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    CGFloat x = self.sv.contentOffset.x;
    if(x<SCREEN_WIDTH*2/5){
        [UIView animateWithDuration:0.5 animations:^{
            self.sv.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
        }];
    }
    else if(x>SCREEN_WIDTH*2/5&&x<SCREEN_WIDTH){
        [UIView animateWithDuration:0.5 animations:^{
            self.sv.contentOffset = CGPointMake(SCREEN_WIDTH*7/10, 0);
        } completion:^(BOOL finished) {
        }];
    }
    else if (x>SCREEN_WIDTH){
        [UIView animateWithDuration:0.5 animations:^{
            self.sv.contentOffset = CGPointMake(SCREEN_WIDTH*14/10, 0);
        } completion:^(BOOL finished) {
        }];
    }
}


@end
