//
//  NewsViewController.m
//  ForU
//
//  Created by administrator on 15/9/25.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "NewsViewController.h"
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
#import "SVProgressHUD.h"
#import "CommentController.h"
#import "tableModel.h"
#import "RequstData.h"
#import "Header.h"
#import "OperateDatabase.h"
#import "RequstData.h"
#import "tableModel.h"
#import "ChooseLoginViewController.h"

@interface NewsViewController () {UIButton *share;
    UIScrollView *scrollView;
    UIView *view1 ;
    UIView *view2 ;
    UIView *Tip1 ;
    UIView *Tip2;
    UILabel *tlabel1;
    UILabel *tlabel2;
    UIView *view0 ;
    int newscId;
    int view1Id;
    NSString *html;
    NSString *title;
    NSString *time;
    int jiT;
    BOOL favFlag;

    BOOL flag;

    UIButton *fav;
    UILabel *labeFav;
    UIButton *line;
    UIButton *line2;
    float yt;
    UIView *tabView;
    NSString *imgNext;
    NSTimer   *showTimer;
    OperateDatabase *db ;
    NSMutableDictionary *dicUserInfo;
    RequstData *request;
    
    
}
@property(strong,nonatomic)UIButton *btn;
@end

@implementation NewsViewController

- (void)viewDidLoad {
    self.backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_HEIGHT*150/667)];
    self.backgroundView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.backgroundView];
    
    
    self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.backView];
    

    favFlag = TRUE;
      [SVProgressHUD showProgress:10.0 status:@"正在加载中..."];
    request = [[RequstData alloc]init];
    labeFav = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-20, 100, 40)];
    labeFav.backgroundColor =  [UIColor colorWithRed:200/255.0 green:188/255.0 blue:156/255.0 alpha:0.8];
    labeFav.alpha = 0;
    labeFav.textAlignment = NSTextAlignmentCenter;
    self.requsetUserInfo = [[RequstLocalData alloc]init];
    dicUserInfo = [[ NSMutableDictionary  alloc]init];
    dicUserInfo = [self.requsetUserInfo requestLocalInfo];
    
    db = [[OperateDatabase alloc]init];
    
    [super viewDidLoad];
    flag = true;
    newscId = [self.newsId intValue];
    
    self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.backView];
    
    
    self.shareView=[[ShareView alloc]initWithStyle:@"" andFrame:CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.shareView.backgroundColor=[UIColor clearColor];
    self.shareView.sinaBtn.tag=1;
    self.shareView.qqBtn.tag=2;
    self.shareView.qZoneBtn.tag=3;
    self.shareView.cancelBtn.tag=4;
    [self.shareView.sinaBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView.qqBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView.qZoneBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView.cancelBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.shareView];
    

    
    self.webview0 = [[UIWebView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, HEIGHT -20)];
    self.webview0.delegate = self;
    self.webview0.scrollView.showsHorizontalScrollIndicator = NO;
    self.webview0.scrollView.bounces = NO;
    
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, WIDTH,  HEIGHT-20)];
    scrollView.backgroundColor = [UIColor whiteColor];
    view0 = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, HEIGHT -20)];
    
    view0.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:view0];
    
    
    
    //放上去的内容限制的移动范围 [UIScreen mainScreen].bounds.size.height/5
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(WIDTH,HEIGHT);
    //scrollView.C
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentOffset = CGPointMake(0,10);
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    //    scrollView.bounces = NO;
    //    self.mys.bounces = NO;//设置scroll遇到边框不滑动
    
    
    scrollView.alpha = 0;
    
    
    [self.view addSubview:scrollView];
    
    
    
    
    
    
    
    //下面的加载界面
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self requestPost:newscId andTagView:0];//初次加载数据
    
    
    
    
    
    tlabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    
    tlabel2.font=[UIFont fontWithName:@"Arial" size:15];
    
    
    
    
    tabView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-40, WIDTH, 40)];
    
    
    
    tabView.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    
    
    
    
    [self.view addSubview:tabView];
    //tabar按钮
    UIButton *leftBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,WIDTH*1/5,  40)];
    
    [leftBack setImage:[UIImage imageNamed:@"News_Navigation_Arrow_Highlight@3x.png"] forState:UIControlStateNormal];
    
    leftBack.contentMode = UIViewContentModeScaleAspectFill;
    [tabView addSubview:leftBack];
    
    [leftBack addTarget:self action:@selector(clickBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *downBack = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH*1/5,0,  WIDTH*1/5,40)];
    
    [downBack setImage:[UIImage imageNamed:@"News_Navigation_Next_Highlight@3x.png"] forState:UIControlStateNormal];
    
    downBack.contentMode = UIViewContentModeScaleAspectFill;
    [tabView addSubview:downBack];
    [downBack addTarget:self action:@selector(downNext) forControlEvents:UIControlEventTouchUpInside];
    //收藏按钮
    
    fav =[ [UIButton alloc]initWithFrame:CGRectMake(WIDTH*2/5,0,  WIDTH*1/5,40)];
        
    fav.contentMode = UIViewContentModeScaleAspectFill;
    [tabView addSubview:fav];
    [fav addTarget:self action:@selector(favClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //Comment
    
    
    
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    UIButton *comment =[ [UIButton alloc]initWithFrame:CGRectMake(WIDTH*3/5,0,  WIDTH*1/5,HEIGHT*0.06)];
    [comment setImage:[UIImage imageNamed:@"News_Navigation_Comment_Highlight@3x.png"] forState:UIControlStateNormal];
    comment.contentMode = UIViewContentModeScaleAspectFill;
    [tabView addSubview:comment];
    [comment addTarget:self action:@selector(turnToCommentView) forControlEvents:UIControlEventTouchUpInside];
    


    //
    share =[ [UIButton alloc]initWithFrame:CGRectMake(WIDTH*4/5,0,  WIDTH*1/5,HEIGHT*0.06)];
    [share setImage:[UIImage imageNamed:@"News_Navigation_Share_Highlight@3x"] forState:UIControlStateNormal];
    share.contentMode = UIViewContentModeScaleAspectFill;
    [tabView addSubview:share];
    [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    share.tag=5;
        [self followRollingScrollView:self.webview0];
    
    
    [self.view addSubview:labeFav];
    
    [self setupHeader:scrollView];
    [self setupFooter:scrollView];
    
    //button背景图片
    
    [self setFavButton];
  
    
}
#pragma mark--刷新

- (void)setupHeader:(UIScrollView *)table
{
    
    self.introViewup =[[UIView alloc]initWithFrame: CGRectMake(70, 12,SCREEN_WIDTH-70, 48) ];
    
    self.titleLabelup=[[UILabel alloc]initWithFrame: CGRectMake(5,0,WIDTH*0.7,60 )];
    self.titleLabelup.font=[UIFont fontWithName:@"Arial" size:15];
    self.titleLabelup.numberOfLines=0;
    
    
    self.imageViewup=[[UIImageView alloc]initWithFrame: CGRectMake(WIDTH*0.7,0, WIDTH*0.3,60)];
    
    
    self.imageViewup.contentMode = UIViewContentModeScaleAspectFit;
    
    self.introViewup.backgroundColor = [UIColor whiteColor];
    
    
    
    self.titleLabelup.frame= CGRectMake(5,0,self.introViewup.frame.size.width*0.7,48 );
    self.imageViewup.frame =  CGRectMake(self.introViewup.frame.size.width*0.7,0, self.introViewup.frame.size.width*0.3,48);
    
    [self.introViewup addSubview:self.titleLabelup];
    [self.introViewup addSubview:self.imageViewup];
    
    
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    
    [refreshHeader addSubview:self.introViewup];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:table];
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    
    refreshHeader.beginRefreshingOperation = ^{
        
        
        NSTimer *myTimer;
        if ( ([self.newsmaxid intValue]- newscId)>0) {
            
            [ UIView animateWithDuration:0.2 animations:^{
                scrollView.alpha = 0;
                
                
            }];
            newscId++;
            [self requestPost:newscId andTagView:0];
            myTimer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(Time1) userInfo:nil repeats:NO];
            [self setFavButton];
        }
        
        
        [weakRefreshHeader endRefreshing];
    };
    
    // 进入页面自动加载一次数据
    
    
}
-(void)Time1{
    [ UIView animateWithDuration:0.2 animations:^{
        scrollView.alpha = 1;
        
        
    }];
}

- (void)setupFooter:(UIScrollView *)table

{
    
    
    
    self.introView = [[UIView alloc]initWithFrame:CGRectMake(70,  12, WIDTH-70, 48 )];
    
    self.titleLabel=[[UILabel alloc]initWithFrame: CGRectMake(5,0,   self.introViewup.frame.size.width*0.7,45 )];
    self.titleLabel.font=[UIFont fontWithName:@"Arial" size:15];
    self.titleLabel.numberOfLines=0;
    
    
    self.imageView=[[UIImageView alloc]initWithFrame: CGRectMake(self.introView.frame.size.width*0.7,0,  self.introView.frame.size.width*0.3,45)];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.introView.backgroundColor = [UIColor whiteColor];
    [self.introView addSubview:self.titleLabel];
    [self.introView addSubview:self.imageView];
    
    
    
    
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    
    [refreshFooter addSubview:   self.introView];
    self.refreshFooter= refreshFooter;
    
    [self.refreshFooter addToScrollView:table];
    SDRefreshFooterView *weakRefreshHeader = self.refreshFooter;
    
    refreshFooter.beginRefreshingOperation = ^{
        
        
        
        
        
        NSTimer *myTimer;
        if ( ( newscId-[self.newsminid intValue]-1)>0) {
            [ UIView animateWithDuration:0.2 animations:^{
                scrollView.alpha = 0;
                
                
            }];
            newscId--;
            [self requestPost:newscId andTagView:0];
          
            myTimer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(Time1) userInfo:nil repeats:NO];
               [self setFavButton];
            
        }
        
        
        
        
        
        
        
        [weakRefreshHeader endRefreshing];
        
        
    };
    
    
}





- (void)initweb:(int)TagView{
    
    
    
    
    
    
    NSString *headHtml = [NSString stringWithFormat:@"%@%d%@%d%@%f%s%d%@%f%@%f%@", @"<html><meta name='viewport' content='width=device-width; initial-scale=1.0; maximum-scale=1.0;'><head><style type=\"text/css\">div#nextIntro {background-color:#99bbbb;};body{text-align:justify ;text-justify:inter-word;background-color: whitecolor;font-family:'LTHYSZK';margin-top: 0px;margin-left: 0px;margin-right: 0px;line-height:",28,@"px;font-color:#ff0000;font-size:", 16,
                          
                          @"px;word-wrap:break-word;overflow:hidden;}img {border:1px solid #eee;max-width:" ,WIDTH- 25,"px;width:expression(this.width > 270 ? '270px' : this.widt+'px');overflow:hidden;}a{color:#0E89E1;text-decoration: none;font-size:",
                          
                          
                          
                          
                          16,@";}table{table-layout: fixed;}td{word-break: break-all; word-wrap:break-word;}video{border:1px solid #eee;max-width:",WIDTH - 30,@"px;max-height:",(WIDTH-30)*0.562,@"px;width:expression(this.width > 270 ? '270px' : this.widt+'px');overflow:hidden;}</style></head><body>"];
    
    
    
    NSString *topHtml = @"";
    //标题
    NSString * strTitle = title;
    NSString *titleHtml = @"";
    NSString * strSource = @"ForU采集";;
    NSString  * strTime = time;
    
    
    titleHtml = [NSString stringWithFormat:@"%@%d%@%@%@",@"<br><table width=\"100%\"border=\"0\"cellpadding=\"0\"cellspacing=\"0\"><tr><td width=\"4\"valign=\"middle\" ></td><td valign=\"middle\"><div style=\"padding-left:10px;padding-right:10px;\"><span style='font-size:", 21+3 ,@"px;'>",strTitle,@"</span>"@"</div></td></tr>"];
    NSString *timeSourceHtml = [NSString stringWithFormat:@"%@%d%@%@%@%d%@%@%@",@"<tr><td width=\"4\"></td><td valign=\"right\"><div style=\"padding:10px;\"><span style='font-size:", 10 ,@"px;color:gray;'>",strSource,@"</span><span>&nbsp;&nbsp;&nbsp;&nbsp;</span><span style='font-size:", 10+2 ,@"px;color:gray;'>",strTime,@"</span></div></td></tr></table>"];
    titleHtml = [NSString stringWithFormat:@"%@%@",titleHtml,timeSourceHtml];
    
    
    
    
    
    
    
    
    
    //html 结束
    NSString *bottomHtml = @"</body></html>";
    
    NSString *content = [NSString stringWithFormat:@"%@%@%@",@"<div style='padding-left:5px;padding-right:5px;'><font style='color:#555555;'>",html,@"</font></div>"];
    NSString *allHtml = [NSString stringWithFormat:@"%@%@%@%@%@",headHtml,topHtml,titleHtml,content,bottomHtml];
    //    NSString *allHtml = [NSString stringWithFormat:@"%@%@%@",temH,html,bottomHtml];
    
    
    
    
    if (TagView == 0) {
        
//        [self.webview0 loadHTMLString:content baseURL:nil];
        self.webview0.backgroundColor = [UIColor whiteColor];
        
        
        [self.webview0 loadHTMLString:allHtml baseURL:nil];
        
        [view0 addSubview:self.webview0 ];
    }
    
    [self inserFoot];
    
}

- (void)requestPost:(int)newsId andTagView:(int)tagView{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:self.newsstyleid forKey:@"newsStyleId"];
    
    [parameters setObject:[NSString stringWithFormat:@"%d",newsId] forKey:@"newsId"];
    
    NSDictionary *result = [db getOneNews:parameters];
    html = [result valueForKey:@"newscontent"];
    title = [result valueForKey:@"newstitle"];
    time = [result valueForKey: @"newstime"];
    imgNext =[result valueForKey: @"newsfirstimg"];
    
    if (tagView!=100) {
         [SVProgressHUD showProgress:10.0 status:@"正在加载中..."];
        [self initweb:tagView];
        
        
    }
    if (newsId == (newscId+1)) {
        [self setViewContentup];
        
    }else if(newsId == (newscId-1))
    {  [self setViewContent];
        
    }
    
    
    
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView1{
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
    
    
    flag = false;
    tabView.alpha = 1;
    

}
- (void)webViewDidFinishLoad:(UIWebView *)webView1
{
        [SVProgressHUD dismiss];
    [ UIView animateWithDuration:1 animations:^{
        
        
        scrollView.alpha = 1;
    }];
    scrollView.alpha = 1;
    
    flag = true;
    
    
    
    [self setViews:2];
    [self setViews:1];
    
}



//设置跟随滚动的滑动试图
-(void)followRollingScrollView:(UIView *)scrollView1
{
    self.theScrollerView = scrollView1;
    
    self.panGesture = [[UIPanGestureRecognizer alloc] init];
    self.panGesture.delegate=self;
    self.panGesture.minimumNumberOfTouches = 1;
    [self.panGesture addTarget:self action:@selector(handlePanGesture:)];
    [self.theScrollerView addGestureRecognizer:self.panGesture];
    
    self.overLay = [[UIView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    self.overLay.alpha=0;
    self.overLay.backgroundColor=self.navigationController.navigationBar.barTintColor;
    [self.navigationController.navigationBar addSubview:self.overLay];
    [self.navigationController.navigationBar bringSubviewToFront:self.overLay];
}

#pragma mark - 兼容其他手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - 手势调用函数
-(void)handlePanGesture:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translation = [panGesture translationInView:[self.theScrollerView superview]];

    //显示
    if (translation.y >= 5) {
        if (self.isHidden) {
            [UIView animateWithDuration:0.2 animations:^{
                tabView.alpha = 1;
                
            }];
            
            
        }
        self.isHidden= NO;
        
    }
    
    //隐藏
    if (translation.y <= -20) {
        if (!self.isHidden) {
            
            
            [UIView animateWithDuration:0.2 animations:^{
                tabView.alpha = 0;
                
            }];
            self.isHidden=YES;
        }
    }
    
    
    
}
- (void)setViews:(int)tag{
    if (tag == 2) {//上拉
        if (([self.newsmaxid intValue]-newscId)>0) {
            [self requestPost:newscId+1 andTagView:100];
            
        }else{
            self.titleLabelup.text = @"这已经是第一条了";
        }
        
    }else{
        if (( newscId-[self.newsminid intValue]-1)>0) {
            [self requestPost:newscId-1 andTagView:100];
        }else{//下拉最后一条判断
            self.titleLabel.text = @"这已经是列表里最后一条了";
        }
        
    }
    
    
}
- (void)setViewContent{
    self.titleLabel.text = title;
    
    
    
    NSURL *photourl = [NSURL URLWithString:imgNext];
    //url请求实在UI主线程中进行的
    UIImage *images = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];//通过网络url获取uiimage
    
    self.imageView.image = images;
    
}
- (void)setViewContentup{
    self.titleLabelup.text = title;
    
    
    
    NSURL *photourl = [NSURL URLWithString:imgNext];
    //url请求实在UI主线程中进行的
    UIImage *images = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];//通过网络url获取uiimage
    
    self.imageViewup.image = images;
    
}

-(void)clickBack:(UIButton *)sender{
    [SVProgressHUD dismiss];

    [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(void)favClick{
    
    
    if (favFlag) {
        favFlag = FALSE;
        if ([dicUserInfo valueForKey:@"userid"]) {
            NSMutableDictionary *parameters1 = [[NSMutableDictionary alloc]init];
            [parameters1 setObject:self.newsstyleid forKey:@"newsStyleId"];
            
            [parameters1 setObject:[NSString stringWithFormat:@"%d",newscId] forKey:@"newsId"];
            
            NSDictionary *result = [db getOneNews:parameters1];
            
            
            NSString *url = @"http://115.29.176.50/interface/index.php/Home/ForU/getFav";
            NSMutableDictionary *parameters =[[NSMutableDictionary alloc]init];
            
            [parameters setValue:[dicUserInfo valueForKey:@"userid"] forKey:@"userId"];
            [parameters setValue:[NSString stringWithFormat:@"%d",newscId] forKey:@"newsId"];
            [parameters setValue:@"hulijieluolianglvkang015" forKey:@"key"];
            [parameters setValue:@"collection" forKey:@"table"];
            [parameters setValue:[result valueForKey:@"newsstyleid"] forKey:@"newsStyleId"];
            [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){
                
                NSString *s =[dic1 objectForKey:@"error_code"];
                
                
                if ([s isEqualToString:@"0"]) {
                    
                    [fav setImage:[UIImage imageNamed:@"News_Faved@2x.png"] forState:UIControlStateNormal];
                    //取消收藏
                    
                    
                    
                    NSString *url = @"http://115.29.176.50/interface/index.php/Home/ForU/deleteFavByUserIdAndNewsId";
                    
                    NSMutableDictionary *parameters =[[NSMutableDictionary alloc]init];
                    [parameters setValue:[dicUserInfo valueForKey:@"userid"] forKey:@"userId"];
                    [parameters setValue:[NSString stringWithFormat:@"%d",newscId] forKey:@"newsId"];
                    [parameters setValue:[result valueForKey:@"newsstyleid"] forKey:@"newsStyleId"];
                    [parameters setValue:@"hulijieluolianglvkang015" forKey:@"key"];
                    [parameters setValue:@"collection" forKey:@"table"];
                    [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){
                        [fav setImage:[UIImage imageNamed:@"News_Fav_Highlight@2x.png"] forState:UIControlStateNormal];
                        labeFav.alpha = 1;
                        
                        favFlag = TRUE;
                        labeFav.text = @"移情别恋了";
                        [UIView animateWithDuration:2.2 animations:^{
                            labeFav.alpha = 0;
                            
                        }];
                        
                        
                    }];
                    
                    
                }else{
                    
                    NSString *url = @"http://115.29.176.50/interface/index.php/Home/ForU/insertCollection";
                    NSMutableDictionary *parameters =[[NSMutableDictionary alloc]init];
                    
                    NSMutableDictionary *parameters1 = [[NSMutableDictionary alloc]init];
                    [parameters1 setObject:self.newsstyleid forKey:@"newsStyleId"];
                    
                    [parameters1 setObject:[NSString stringWithFormat:@"%d",newscId] forKey:@"newsId"];
                    
                    NSDictionary *result = [db getOneNews:parameters1];
                    [parameters setValue:@"collection" forKey:@"table"];
                    
                    [parameters setValue:[dicUserInfo valueForKey:@"userid"] forKey:@"userId"];
                    [parameters setValue:[NSString stringWithFormat:@"%d",newscId] forKey:@"newsId"];
                    [parameters setValue:[result valueForKey:@"newsstyleid"] forKey:@"newsStyleId"];
                    [parameters setValue:[result valueForKey:@"newstitle"] forKey:@"newsTitle"];
                    [parameters setValue:[result valueForKey:@"newsfirstimg"] forKey:@"newsFirstImg"];
                    [parameters setValue:[result valueForKey:@"newscontent"] forKey:@"newsContent"];
                    [parameters setValue:[result valueForKey:@"newstime"] forKey:@"newsTime"];
                    
                    
                    [parameters setValue:@"hulijieluolianglvkang015" forKey:@"key"];
                    [parameters setValue:@"collection" forKey:@"table"];
                    
                    [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){
                        
                        
                        [fav setImage:[UIImage imageNamed:@"News_Faved@2x.png"] forState:UIControlStateNormal];
                        
                        
                        labeFav.alpha = 1;
                        
                         favFlag = TRUE;
                        labeFav.text = @"真有品位";
                        [UIView animateWithDuration:2.2 animations:^{
                            labeFav.alpha = 0;
                            
                        }];
                    }];
                    
                    
                }
            }];
            
            
        }else
        {
             favFlag = TRUE;
            
            ChooseLoginViewController *ch = [[ChooseLoginViewController alloc]init];
            [self.navigationController pushViewController:ch animated:YES];

        }
        

    }
    
}
-(void)downNext{
    if (flag) {
        NSTimer *myTimer;
        if ( ( newscId-[self.newsminid intValue]-1)>0) {
            [ UIView animateWithDuration:0.2 animations:^{
                scrollView.alpha = 0;
                
                
            }];
            newscId--;
            [self requestPost:newscId andTagView:0];
            
            myTimer = [NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(Time1) userInfo:nil repeats:NO];
            [self setFavButton];
        }

    }
    
}
-(void)setFavButton{
    
    
    
    if ([[dicUserInfo valueForKey:@"userid"] isEqualToString:@""]) {
        [fav setImage:[UIImage imageNamed:@"News_Fav_Highlight@2x.png"] forState:UIControlStateNormal];
    }else{
        NSMutableDictionary *parameters1 = [[NSMutableDictionary alloc]init];
        [parameters1 setObject:self.newsstyleid forKey:@"newsStyleId"];
        
        [parameters1 setObject:[NSString stringWithFormat:@"%d",newscId] forKey:@"newsId"];
        
        NSDictionary *result = [db getOneNews:parameters1];
        NSString *url = @"http://115.29.176.50/interface/index.php/Home/ForU/getFav";
        NSMutableDictionary *parameters =[[NSMutableDictionary alloc]init];
        
        [parameters setValue:[dicUserInfo valueForKey:@"userid"] forKey:@"userId"];
        [parameters setValue:[NSString stringWithFormat:@"%d",newscId] forKey:@"newsId"];
        [parameters setValue:@"hulijieluolianglvkang015" forKey:@"key"];
         [parameters setValue:[result valueForKey:@"newsstyleid"] forKey:@"newsStyleId"];
        [parameters setValue:@"collection" forKey:@"table"];
        [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){
            
            NSString *s =[dic1 objectForKey:@"error_code"];
            
            
            if ([s isEqualToString:@"0"]) {

                [fav setImage:[UIImage imageNamed:@"News_Faved@2x.png"] forState:UIControlStateNormal];
                

            }else{
                [fav setImage:[UIImage imageNamed:@"News_Fav_Highlight@2x.png"] forState:UIControlStateNormal];

            }
        }];
        
    }

}

-(void)inserFoot{
    
    
    
    
    
    
    
    NSString *url = @"http://115.29.176.50/interface/index.php/Home/GetTest/insertFoot";
    NSMutableDictionary *parameters =[[NSMutableDictionary alloc]init];
    
    NSMutableDictionary *parameters1 = [[NSMutableDictionary alloc]init];
    [parameters1 setObject:self.newsstyleid forKey:@"newsStyleId"];
    
    [parameters1 setObject:[NSString stringWithFormat:@"%d",newscId] forKey:@"newsId"];
    
    NSDictionary *result = [db getOneNews:parameters1];
    [parameters setValue:@"collection" forKey:@"table"];
    
    [parameters setValue:[dicUserInfo valueForKey:@"userid"] forKey:@"userId"];
    [parameters setValue:[NSString stringWithFormat:@"%d",newscId] forKey:@"newsId"];
    [parameters setValue:[result valueForKey:@"newsstyleid"] forKey:@"newsStyleId"];
    [parameters setValue:[result valueForKey:@"newstitle"] forKey:@"newsTitle"];
    [parameters setValue:[result valueForKey:@"newsfirstimg"] forKey:@"newsFirstImg"];
    
    [parameters setValue:[result valueForKey:@"newstime"] forKey:@"newsTime"];
    
    
    [parameters setValue:@"hulijieluolianglvkang015" forKey:@"key"];
    [parameters setValue:@"footprint" forKey:@"table"];
    
    [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){
       
        
    }];

    NSString *culm =[NSString stringWithFormat:@"Tag%@",[result valueForKey:@"newsstyleid"]];
    
    [parameters setValue:culm forKey:@"culm"];

    url = @"http://115.29.176.50/interface/index.php/Home/GetTest/insertTag";
    
        [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){

    
        }];
}
-(void)share:(UIButton *)sender{
    Share *shareWay=[[Share alloc]init];
    NSMutableDictionary *parameters1 = [[NSMutableDictionary alloc]init];
    [parameters1 setObject:self.newsstyleid forKey:@"newsStyleId"];
    
    [parameters1 setObject:[NSString stringWithFormat:@"%d",newscId] forKey:@"newsId"];
    
    NSDictionary *result = [db getOneNews:parameters1];
    tableModel *tableM = [[tableModel alloc]init];

    NSDictionary *dicT = [tableM getTableTurn];
    NSString *table = [dicT valueForKey:self.newsstyleid ];
    NSString *url = [NSString stringWithFormat:@"http://115.29.176.50/interface/index.php/Home/ForU/shar?table=%@&newsId=%d",table,newscId];

    if(sender.tag==1){
        //分享到新浪
        
        
 [shareWay shareToSina:[result valueForKey:@"newstitle"] andImg:[UIImage imageNamed:@"watingImag"] andURL:url andView:self];
      
    }
    if(sender.tag==2){
        //分享到qq
        [shareWay shareToQQ:[result valueForKey:@"newstitle"] andImg:[UIImage imageNamed:@"watingImag"] andURL:url andView:self];

    }
    if(sender.tag==3){
        //分享到qZone
       

        [shareWay shareToQZone:[result valueForKey:@"newstitle"] andImg:[UIImage imageNamed:@"watingImag"] andURL:url andView:self];
        


    }
    if(sender.tag==4){
        
        
        [UIView animateWithDuration:0.5 animations:^{
            self.backView.backgroundColor=[UIColor clearColor];
            [self.view sendSubviewToBack:self.backView];
        } completion:^(BOOL finished) {
        }];
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.shareView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [self.view sendSubviewToBack:self.shareView];
            
        } completion:^(BOOL finished) {
        }];
    }
    if(sender.tag==5){
        //弹出分享页
        
        [self.view bringSubviewToFront:self.backView];
        [UIView animateWithDuration:0.5 animations:^{
            self.backView.backgroundColor=RGBAA(42, 54, 68, 0.5);
        } completion:^(BOOL finished) {
        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.shareView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [self.view bringSubviewToFront:self.shareView];
            
        } completion:^(BOOL finished) {
        }];
    }
    
    
    
    
}
-(void)initEditView:(NSString *)str{
    self.editView=[[EditView alloc]initWithStyle:str andFrame:CGRectMake(0, SCREEN_HEIGHT+SCREEN_HEIGHT*150/667, SCREEN_WIDTH,SCREEN_HEIGHT*150/667 ) andSourse:3];
    [self.editView.sureBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.editView.sureBtn.tag=7;
    [self.editView.cancelBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.editView.cancelBtn.tag=8;
    [self.editView.commentBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.editView.commentBtn.tag=9;
    self.editView.editText.delegate=self;
      self.editView.sureBtn.userInteractionEnabled = FALSE;
    self.editView.sureBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.editView];
    
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    self.keyboardHeight=height;
    
    [self.backgroundView setFrame:CGRectMake(0,0 ,SCREEN_WIDTH,SCREEN_HEIGHT-self.keyboardHeight-SCREEN_HEIGHT*150/667 )];
    [self.editView setFrame:CGRectMake(0,SCREEN_HEIGHT-self.keyboardHeight-SCREEN_HEIGHT*150/667 ,SCREEN_WIDTH,SCREEN_HEIGHT*150/667 )];
    
}
//当键盘消失时
- (void) keyboardWillHide:(NSNotification *) notif
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.editView setFrame:CGRectMake(0,SCREEN_HEIGHT-SCREEN_HEIGHT*150/667 ,SCREEN_WIDTH,SCREEN_HEIGHT*150/667 )];
        [self.backgroundView setFrame:CGRectMake(0,0 ,SCREEN_WIDTH,SCREEN_HEIGHT-SCREEN_HEIGHT*150/667 )];
        
    } completion:^(BOOL finished) {
    }];
}

- (void)turnToCommentView {
    if ([dicUserInfo valueForKey:@"userid"]) {
       
        [self initEditView:@"我的评论："];
        self.editView.tag=1;
        [UIView animateWithDuration:0.5 animations:^{
            [self.editView.editText becomeFirstResponder];
        } completion:^(BOOL finished) {
        }];
        
        //蒙版
        [UIView animateWithDuration:0.8 animations:^{
            [self.view bringSubviewToFront:self.backgroundView];
            self.backgroundView.backgroundColor=RGBAA(42, 54, 68, 0.5);
        } completion:^(BOOL finished) {
        }];

        
    }else{
        ChooseLoginViewController *ch = [[ChooseLoginViewController alloc]init];
        [self.navigationController pushViewController:ch animated:YES];

    }

    
    
}

//评论框确定事件
-(void)click:(UIButton *)sender{
    if(sender.tag==7){
        
        [self.view sendSubviewToBack:self.backgroundView];
        
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.backgroundView.backgroundColor=[UIColor clearColor];
            
            [self.view sendSubviewToBack:self.backgroundView];
            
        } completion:^(BOOL finished) {
            
            
            
        
            
            NSMutableDictionary *parametersnews = [[NSMutableDictionary alloc]init];
            [parametersnews setObject:self.newsstyleid forKey:@"newsStyleId"];
            
            
            [parametersnews setValue:[NSString stringWithFormat:@"%d",newscId] forKey:@"newsId"];
            
            NSDictionary *result = [db getOneNews:parametersnews];


      
            

            
            //将评论存入数据库
            
            NSString *url = @"http://115.29.176.50/interface/index.php/Home/ForU/inertComment";
            NSMutableDictionary *parameters =[[NSMutableDictionary alloc]init];

            [parameters setValue:[dicUserInfo valueForKey:@"userid"] forKey:@"userId"];
            [parameters setValue:[dicUserInfo valueForKey:@"nickName"] forKey:@"usernickName"];
            [parameters setValue:[dicUserInfo valueForKey:@"icon"] forKey:@"icon"];
            
            
            [parameters setValue:[dicUserInfo valueForKey:@"icon"] forKey:@"icon"];
            [parameters setValue:[NSString stringWithFormat:@"%@",[result valueForKey:@"newstitle"]] forKey:@"newstitle"];

            
            

            [parameters setValue:[NSString stringWithFormat:@"%d",newscId] forKey:@"newsId"];
            [parameters setValue:self.newsstyleid  forKey:@"newsStyleId"];
            [parameters setValue:[NSString stringWithFormat:@"%@", self.editView.editText.text ]forKey:@"commentValue"];
            
            [parameters setValue:@"hulijieluolianglvkang015" forKey:@"key"];
            [parameters setValue:@"ForUnewscomment" forKey:@"table"];
            [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){
                
                NSString *s =[dic1 objectForKey:@"error_code"];
                
                
                if ([s isEqualToString:@"0"]) {
                    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-15, 100, 30)];
                    la.textColor = [UIColor whiteColor];
                    la.textAlignment = NSTextAlignmentCenter;
                    la.backgroundColor = [UIColor lightGrayColor ];
                    la.text = @"评论成功";
                    [self.view addSubview:la];
                    [UIView animateWithDuration:2 animations:^(void){
                        la.alpha = 0;
                    }];
                    
                    
                }else{
                    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-15, 100, 30)];
                    la.textColor = [UIColor whiteColor];
                    la.textAlignment = NSTextAlignmentCenter;
                    la.backgroundColor = [UIColor lightGrayColor ];
                    la.text = @"举报失败";
                    [self.view addSubview:la];
                    [UIView animateWithDuration:2 animations:^(void){
                        la.alpha = 0;
                    }];
                    
                    
        
                    
                }
            }];
            
            
        }];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.editView.editText resignFirstResponder];
            [self.editView setFrame:CGRectMake(0,SCREEN_HEIGHT+ SCREEN_HEIGHT*150/667 ,SCREEN_WIDTH, SCREEN_HEIGHT*150/667)];
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        } completion:^(BOOL finished) {
        }];
    }
    if(sender.tag==8){
        //取消编辑
        [UIView animateWithDuration:0.5 animations:^{
            
            self.backgroundView.backgroundColor=[UIColor clearColor];
            [self.view sendSubviewToBack:self.backgroundView];
            
        } completion:^(BOOL finished) {
        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            [self.editView.editText resignFirstResponder];
            [self.editView setFrame:CGRectMake(0,SCREEN_HEIGHT+SCREEN_HEIGHT*150/667 ,SCREEN_WIDTH, SCREEN_HEIGHT*150/667)];
        } completion:^(BOOL finished) {
        }];
        
    }
    
    if (sender.tag == 9) {
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.backgroundView.backgroundColor=[UIColor clearColor];
            [self.view sendSubviewToBack:self.backgroundView];
            
        } completion:^(BOOL finished) {
        }];
        
        [UIView animateWithDuration:0.1 animations:^{
            [self.editView.editText resignFirstResponder];
            [self.editView setFrame:CGRectMake(0,SCREEN_HEIGHT+SCREEN_HEIGHT*150/667 ,SCREEN_WIDTH, SCREEN_HEIGHT*150/667)];
        } completion:^(BOOL finished) {
            CommentController *cvc = [[CommentController alloc]init];
            

            cvc.newsid =[NSString stringWithFormat:@"%d",newscId];
            cvc.newsstyleid = self.newsstyleid ;
            [self.navigationController pushViewController:cvc animated:YES];
            
            
            
        }];
    }
    
    
}
- (void)textViewDidChangeSelection:(UITextView *)textView{
    
    if ( [self.editView.editText.text  isEqualToString:@""]) {
        self.editView.sureBtn.userInteractionEnabled = FALSE;
        self.editView.sureBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
          }else {
              self.editView.sureBtn.backgroundColor=[UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1];
  
        self.editView.sureBtn.userInteractionEnabled = TRUE;
    }

    
}

@end
