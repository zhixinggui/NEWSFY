//
//  HomeViewController.m
//  ForU
//
//  Created by administrator on 15/9/25.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "HomeViewController.h"
#import "ForUWebViewController.h"
#import "ContentViewController.h"
#import "MenuViewController.h"
#import "NormalTableViewCell.h"
#import "HACursor.h"
#import "UIView+Extension.h"
#import "HATestView.h"
#import "NavigationBar.h"
#import "RequstData.h"
#import "TitleTableViewCell.h"
#import "NormalTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "Header.h"
#import "OperateDatabase.h"
#import "CustomButton.h"
#import "CheckNet.h"
#import "UIBezierPath+ZJText.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (strong,nonatomic)UIView *maskView;
@property(strong,nonatomic)UITableView *table;
@property(strong,nonatomic)MenuViewController *mvc;
@property(strong,nonatomic) ContentViewController *contentView;
@property(strong,nonatomic)UIPanGestureRecognizer *panRecognizer;
@property (assign,nonatomic)BOOL ishandled,isclick;
@property(strong,nonatomic)NavigationBar *navBar;
@property (nonatomic,strong)UIButton  *CustomButton;
@property (nonatomic,strong)UIView  *CustomView;
@property (nonatomic,strong)SDRefreshFooterView *refreshFooter;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) NSMutableDictionary *attrs;
@property (nonatomic, strong) UIView *backAnimationView;
@end

@implementation HomeViewController{
    NSMutableArray *array;
    OperateDatabase *db;
    NSString *newsMaxId;
    NSString *newsMinId;
    NSTimer   *showTimer;
    int jiT;
    UIView *tipView;//提示View
    UILabel *labelTip ;//提示label
    int cha;
    NSMutableArray *arrayTemp1;
    BOOL menuFlag;
    CheckNet *check;
    NSTimer *timeA;
      NSTimer *timeT;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{

        [super viewDidAppear:animated];
     [self play:nil];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.tabBarController.tabBar.alpha  = 1;
    [self checkNet];
    
 
    array  = [[NSMutableArray alloc]init];
     arrayTemp1  = [[NSMutableArray alloc]init];
    cha = 0;
    menuFlag = false;
    
    self.ishandled=YES;
 [self initView];
    
           [self addMenuView];
         self.mvc.view.alpha = 0;
    self.CustomButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-90, self.view.frame.size.height*0.404, 180, 30)];


    [self.CustomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [self timeSetLabel];
    self.backAnimationView  = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*64/667, self.view.frame.size.width, SCREEN_HEIGHT-SCREEN_HEIGHT*64/667)];

    self.backAnimationView.backgroundColor = [UIColor whiteColor];
    self.backAnimationView.alpha = 0.7;
    [self.backAnimationView addSubview:self.CustomButton];
    [self.view addSubview:self.backAnimationView];
      [self.view.layer addSublayer:self.shapeLayer];//加载等待动画
   timeT = [NSTimer scheduledTimerWithTimeInterval:1
                                                     target:self
                                                   selector:@selector(timeSetLabel)
                                                   userInfo:nil
                                                    repeats:YES];
    timeA = [NSTimer scheduledTimerWithTimeInterval:3
                                             target:self
                                           selector:@selector(timeSetA)
                                           userInfo:nil
                                            repeats:YES];
    
    
}
-(void)timeSetA{

  
    
    UIBezierPath *path = [UIBezierPath zjBezierPathWithText:@"ForU" attributes:self.attrs];
    self.shapeLayer.bounds = CGPathGetBoundingBox(path.CGPath);
    self.shapeLayer.path = path.CGPath;
    [self.shapeLayer removeAllAnimations];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5f * 4;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [self.shapeLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    


    
}

-(void)timeSetLabel{
    
    NSString *s3 = @"正在努力加载中···";
    NSString *s2 = @"正在努力加载中··";
    NSString *s1 = @"正在努力加载中·";
    switch (jiT%3) {
        case 1:
            [self.CustomButton setTitle:s1 forState:UIControlStateNormal];

            break;
        case 2:
            [self.CustomButton setTitle:s2 forState:UIControlStateNormal];


            break;
            
            
        default:
            [self.CustomButton setTitle:s3 forState:UIControlStateNormal];


            break;
            
    }
    
    jiT++;
    
}

-(void)initView{
  

        [self requestNewData:^{
            
            array = arrayTemp1;
            [self.table reloadData];
       
        }];

       self.view.backgroundColor=[UIColor whiteColor];
    
    
    self.navBar=[[NavigationBar alloc]initWithNavBar:@"icon_titlebar_list@3x" ForUBtnTitle:@"ForU" rightBtnTitle:@"专题"];
 
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar.ForUBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar.rightBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar.ForUBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.navBar];
    
    
    self.table=[[UITableView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT*64/667, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_HEIGHT*64/667) style:UITableViewStylePlain];
    self.table.separatorStyle = NO;
    self.table.dataSource=self;
    self.table.delegate=self;
    self.table.showsVerticalScrollIndicator =NO;
    [self.view addSubview:self.table];
    //添加拖动手势
    self.panRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    self.panRecognizer.delegate=self;
    [self.view addGestureRecognizer:self.panRecognizer];
    [self setupHeader:self.table];
    [self setupFooter:self.table];
    
}


#pragma mark--刷新

- (void)setupHeader:(UITableView *)table
{
    self.table = table;
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:table];
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             cha = 0;
            
            [self requestNewData:^(void){
                labelTip.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
                tipView.backgroundColor = RGB(214, 213, 246);
                tipView.alpha = 1;
                array = arrayTemp1;
               
                [weakRefreshHeader endRefreshing];
                [table reloadData];
                
                newsMaxId =[[array objectAtIndex:0] valueForKey:@"newsid"];
                
                newsMinId =[[array objectAtIndex:array.count-1] valueForKey:@"newsid"];
                

            }];
            
            
        });
    };
    
    // 进入页面自动加载一次数据
    
}

- (void)setupFooter:(UITableView *)table

{

    
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    self.refreshFooter= refreshFooter;
    [self.refreshFooter addToScrollView:table];
    __weak SDRefreshFooterView *weakRefreshHeader = self.refreshFooter;
    __weak typeof(self) weakSelf = self;
    refreshFooter.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            
            
            
            cha = cha+12;
            [self requestNewData:^(void){
                

                
                NSMutableArray *tempArray = [[NSMutableArray alloc]init];
                [tempArray addObjectsFromArray:array];
                [tempArray addObjectsFromArray:arrayTemp1];
                
                array = [[NSMutableArray alloc]init];
                [array addObjectsFromArray:tempArray];
                
                               [weakSelf.table reloadData];
                [weakRefreshHeader endRefreshing];
                
                newsMaxId =[[array objectAtIndex:0] valueForKey:@"newsid"];
                
                newsMinId =[[array objectAtIndex:array.count-1] valueForKey:@"newsid"];
                


            }];
                    });
    };
    
    
}



//点击事件
-(void)click:(UIButton*)sender{
    
    //点击ForU按钮
    if([sender.titleLabel.text isEqualToString:@"ForU"]){
        if(self.isclick==YES){
        [self.navBar.ForUBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.navBar.rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 animations:^{
            [self.contentView.view setFrame:CGRectMake(SCREEN_WIDTH,SCREEN_HEIGHT*64/667 ,SCREEN_WIDTH,SCREEN_HEIGHT-SCREEN_HEIGHT*64/667)];
            [self.table setFrame:CGRectMake(0,SCREEN_HEIGHT*64/667, SCREEN_WIDTH,SCREEN_HEIGHT-SCREEN_HEIGHT*64/667)];
        } completion:^(BOOL finished) {
        }];
        //将内容页移除以释放内存
        [self.contentView removeFromParentViewController];
        self.isclick=NO;
        }
    }
    //点击专题按钮
    else if([sender.titleLabel.text isEqualToString:@"专题"]){
        //当按钮未被点击时
        if(self.isclick==NO){
            [self.mvc removeFromParentViewController];
           [self addContentView];//当点击专题按钮时，将内容页面添加到View上

            [self addMenuView];

           [self.navBar.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
           [self.navBar.ForUBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
           [UIView animateWithDuration:0.5 animations:^{
            [self.contentView.view setFrame:CGRectMake(0,self.view.frame.size.height/10 ,self.view.frame.size.width, self.view.frame.size.height)];
            [self.table setFrame:CGRectMake(-self.view.frame.size.width,self.view.frame.size.height/10, self.view.frame.size.width, self.view.frame.size.height)];
            
         } completion:^(BOOL finished) {
        }];
            self.isclick=YES;
        }
        else{
        }
       
        
        
    }
    //点击home按钮
    else{
        
        if (self.mvc.view.alpha==0) {
             self.mvc.view.alpha = 1;
        }
        
        if (menuFlag) {
            [self addMenuView];
            menuFlag = false;
        }
        
        [UIView animateWithDuration:0.5 animations:^{
        
            
            [self.mvc.view setFrame:CGRectMake(0,0 ,self.view.frame.size.width, self.view.frame.size.height)];
                self.tabBarController.tabBar.alpha  = 0;
        } completion:^(BOOL finished) {
        

        }];
    }
}

//手势添加事件
-(void)handlePan:(UIGestureRecognizer*)sender{
    if (self.mvc.view.alpha==0) {
        self.mvc.view.alpha = 1;
    }
    CGFloat translation = [self.panRecognizer translationInView:self.view].x;
    if (menuFlag) {
          [self addMenuView];
        menuFlag = false;
    }
  
    
    if(self.ishandled==YES){
        if(translation>0&&translation<self.view.frame.size.width*3/5){

            [UIView animateWithDuration:0.5 animations:^{
                [self.mvc.view setFrame:CGRectMake(-self.view.frame.size.width*3/5+translation,0 ,self.view.frame.size.width, self.view.frame.size.height)];
                self.tabBarController.tabBar.alpha  = 1;
                
                

            }];
                   }
    }
    
    //拖动结束时
    if(self.panRecognizer.state==UIGestureRecognizerStateEnded){
        if(translation>self.view.frame.size.width/5){
            [UIView animateWithDuration:0.5 animations:^{
                     self.tabBarController.tabBar.alpha  = 0;
                [self.mvc.view setFrame:CGRectMake(0,0 ,self.view.frame.size.width, self.view.frame.size.height)];
            } completion:^(BOOL finished) {
           

            }];
            
            
            self.ishandled=NO;
        }
        else{
            [UIView animateWithDuration:0.5 animations:^{
                [self.mvc.view setFrame:CGRectMake(-self.view.frame.size.width*3/5,0 ,self.view.frame.size.width*3/5, self.view.frame.size.height)];
                self.tabBarController.tabBar.alpha  = 1;

              
                            } completion:^(BOOL finished) {
                                
                                [self.mvc.view removeFromSuperview];
                                [self.mvc removeFromParentViewController];
                                menuFlag = TRUE;
                           
                                
                                             }];
            
        
            self.ishandled=YES;
        }
    }
}
//实现UITableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic= [array objectAtIndex:indexPath.row];
    
    
    NSString *string=[dic objectForKey:@"newsfirstimg"];
    
    
    
    if([string isEqualToString:@""]){
        return self.view.frame.size.height/8;

    }else
    return self.view.frame.size.height/6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"table";
    static NSString *str1=@"table1";
    
    [UIView  animateWithDuration:1.0 animations:^(void){
        [self.CustomView removeFromSuperview];
        [showTimer isValid];
        
    }];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        dic= [array objectAtIndex:indexPath.row];

        
        NSString *string=[dic objectForKey:@"newsfirstimg"];

    
        
        if([string isEqualToString:@""]){
            TitleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
            if(cell==nil){
                cell=[[TitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            }
            cell.timeLabel.text = [dic objectForKey:@"newstime"];
            cell.title.text=[dic objectForKey:@"newstitle"];
            
            return cell;
            
        }
        else{
            NormalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str1];
            if(cell==nil){
                cell=[[NormalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
            }
            
            
            
            
            
            [cell.image sd_setImageWithURL:[NSURL URLWithString:string]
                          placeholderImage:[UIImage imageNamed:@"watingImag.png"]];
            cell.title.text=[dic objectForKey:@"newstitle"];
            cell.timeLabel.text=[dic objectForKey:@"newstime"];
            
            
            return cell;
        }

    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ForUWebViewController *nvc=[[ForUWebViewController alloc]init];
    
    nvc.newsId =[[NSString stringWithFormat:@"%ld",(long)indexPath.row] intValue];
    nvc.newsminid = 0;
    nvc.newsmaxid =[[NSString stringWithFormat:@"%ld", (unsigned long)array.count] intValue] -1;
    nvc.newsArray = array;
    nvc.newsstyleid = [[array objectAtIndex:indexPath.row] valueForKey:@"newsstyleid"];
    [self.navigationController pushViewController:nvc animated:YES];

}

//添加子控制器
-(void)addContentView{

      self.contentView=[[ContentViewController alloc]init];
      [self addChildViewController:self.contentView];
      self.contentView.view.frame=CGRectMake(self.view.frame.size.width, self.view.frame.size.height/10,self.view.frame.size.width ,self.view.frame.size.height );

      [self.view addSubview:self.contentView.view];

}
//添加菜单栏子控制器
-(void)addMenuView{
    self.mvc=[[MenuViewController alloc]init];
    [self addChildViewController:self.mvc];

    self.mvc.view.frame=CGRectMake( -self.view.frame.size.width,0 , self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.mvc.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)insertData:(NSMutableArray *)arrayT{
    NSDictionary *dicT;
    db= [[OperateDatabase alloc]init];

    for (int  i=0; i<arrayT.count; i++) {
        dicT = [arrayT objectAtIndex:i];
        if ([db checkNews:[dicT valueForKey:@"newstitle"]]) {
            [db insertNewsData:dicT];
            
        }
        
        
    }
    
}
- (void)requestNewData:(void (^)(void))finishBlock{
    
    RequstLocalData *re = [[RequstLocalData alloc]init];
    NSMutableDictionary *dicUser =  [[NSMutableDictionary alloc]init];
    dicUser =  [re requestLocalInfo];
    
    
    
    
    NSString *key = @"hulijieluolianglvkang015";
    
    NSString *userid = [dicUser valueForKey:@"userid"] ;
    if (!userid) {
        userid = @"1";
    }
    
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:key forKey:@"key"];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:[NSString stringWithFormat:@"%d",cha] forKey:@"cha"];

    NSString *url = @"http://115.29.176.50/interface/index.php/Home/GetForUData/search";
    RequstData *request=[[RequstData alloc]init];
    
    
    
    [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){

        NSString *s =[dic1 objectForKey:@"error_code"];
        if ([s isEqualToString:@"0"]) {
            
            arrayTemp1 = [dic1 valueForKey:@"result"];
            
            
            [self insertData:arrayTemp1];
            
          
            finishBlock();
            [UIView animateWithDuration:2 animations:^(void){
                [timeA invalidate];
                [timeT invalidate];
                [self.shapeLayer removeFromSuperlayer];
                [self.backAnimationView removeFromSuperview];
            }];
            
            newsMaxId =[[array objectAtIndex:0] valueForKey:@"newsid"];
            
            newsMinId =[[array objectAtIndex:array.count-1] valueForKey:@"newsid"];
            
            
            
        }else if ([s isEqualToString:@"2"]){
         
              finishBlock();
            [UIView animateWithDuration:2 animations:^(void){
                [timeA invalidate];
                [timeT invalidate];
                [self.shapeLayer removeFromSuperlayer];
                [self.backAnimationView removeFromSuperview];
            }];

        }

        
        
        
        
        
        
        
    }];

    
    
}

- (void)play:(id)sender
{
   
        UIBezierPath *path = [UIBezierPath zjBezierPathWithText:@"ForU" attributes:self.attrs];
        self.shapeLayer.bounds = CGPathGetBoundingBox(path.CGPath);
        self.shapeLayer.path = path.CGPath;
        [self.shapeLayer removeAllAnimations];
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 0.5f * 4;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [self.shapeLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
    
}

-(CAShapeLayer *)shapeLayer
{
    if (_shapeLayer == nil)
    {
        _shapeLayer = [CAShapeLayer layer];
        
        CGSize size = self.view.frame.size;
        CGFloat height = 250;
        
        _shapeLayer.frame = CGRectMake(0, (size.height - height)*0.422, size.width , height);
        _shapeLayer.geometryFlipped = YES;
        _shapeLayer.strokeColor = [UIColor blackColor].CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;;
        _shapeLayer.lineWidth = 2.0f;
        _shapeLayer.lineJoin = kCALineJoinRound;
    }
    return _shapeLayer;
}

-(NSMutableDictionary *)attrs
{
    if (_attrs == nil)
    {
        _attrs = [[NSMutableDictionary alloc] init];
        [_attrs setValue:[UIFont boldSystemFontOfSize:50] forKey:NSFontAttributeName];
    }
    return _attrs;
}

- (void)checkNet
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 移动数据
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 无线网络
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    

    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case 0:{
                [self faileNet];
                
                break;}
                
            default:
               ;break;
                
                
        }
    }];
    
}
-(void)faileNet{
    UILabel *alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-15, 2000, 30)];
    alertLabel.text = @"网络不佳,请求失败";
    [self.view addSubview:alertLabel];

        [alertLabel removeFromSuperview];
        

    
}
@end
