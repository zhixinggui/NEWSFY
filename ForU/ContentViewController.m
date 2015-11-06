//
//  ContentViewController.m
//  ForU
//
//  Created by administrator on 15/9/25.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "ContentViewController.h"
#import "NewsViewController.h"
#import "NormalTableViewCell.h"
#import "TitleTableViewCell.h"
#import "HACursor.h"
#import "UIView+Extension.h"
#import "HATestView.h"
#import "RequstData.h"
#import "Header.h"
#import "SDRefresh.h"
#import "CustomButton.h"
#import "OperateDatabase.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "tableModel.h"
#import "UIBezierPath+ZJText.h"



@interface ContentViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, assign)BOOL isclick;
@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;//刷新脚
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;//刷新
@property (nonatomic,strong)UIButton  *CustomButton;//加载等待页面
@property (nonatomic,strong)UIView  *CustomView;//
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) NSMutableDictionary *attrs;
@property (nonatomic, strong) UIView *backAnimationView;

@end

@implementation ContentViewController{
    NSMutableDictionary *dicNews;
    NSDictionary *dic;
    NSTimer   *showTimer;
    NSMutableDictionary *dicOfjudgeData;
    int jiT;
    int TagDataJi;
    NSMutableDictionary *ReDataDic;
    OperateDatabase *db;
    NSMutableDictionary *maxNewsId;
    NSMutableDictionary *minNewsId;
    BOOL Rflag;
    int NewNewsNum;
    UIView *tipView;
    UILabel *labelTip ;
    NSString *tagNumOfReData;
    NSMutableDictionary *dicTitle;//标题字典
    NSTimer *timeA;
    NSTimer *timeT;
    BOOL aJudge;
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self play:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    TagDataJi = 0;
    Rflag = TRUE;
 
    
    
    db= [[OperateDatabase alloc]init];
    dic=[[NSDictionary alloc]init];
    dicTitle = [[NSMutableDictionary alloc]init];
    ReDataDic = [[NSMutableDictionary alloc]init];
    maxNewsId  = [[NSMutableDictionary alloc]init];
    minNewsId  = [[NSMutableDictionary alloc]init];
    
    [self iniDicTitle];
     [self initView];
    [self setAnimation];
    
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *newsid=[minNewsId objectForKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
    
    NSInteger row = [indexPath row];
    
    if (row==(self.array.count -3)&&Rflag&&![tagNumOfReData isEqualToString: [NSString stringWithFormat:@"%ld" ,(long)indexPath.row]]) {
        
        tagNumOfReData =[NSString stringWithFormat:@"%ld" ,(long)indexPath.row];
        
        
        [self getMoreData:tableView andNewsId:newsid];
        Rflag = FALSE;
    }
    
}





-(void)initView{
    self.titles = [[NSMutableArray alloc]init];
    dicNews = [[NSMutableDictionary alloc]init];
    self.dicArray = [[NSMutableArray alloc]init];
    for (int i =1;  i<100;i++) {
        [self.dicArray addObject:@""];
    }
    //获取已有完整路径 plist获取标题
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"titlesList.plist"];
    //输入写入
    NSMutableDictionary *titile = [[NSMutableDictionary alloc]initWithContentsOfFile:filename];
    //设置属性值,没有的数据就新建，已有的数据就修改。
    [self.titles addObjectsFromArray:[titile valueForKey:@"arr"]];
    
    HACursor *cursor = [[HACursor alloc]init];
    cursor.frame = CGRectMake(0, 0, self.view.frame.size.width ,self.view.frame.size.height );
    cursor.titles = self.titles;
    cursor.pageViews = [self createPageViews];
    //设置navBar背景色
    [cursor setBackgroundColor:RGB(244, 244, 244)];
    //设置根滚动视图的高度
    cursor.rootScrollViewHeight = SCREEN_HEIGHT-SCREEN_HEIGHT*64/667-50 ;
    //默认值是白色
    cursor.titleNormalColor = [UIColor blackColor];
    //默认值是白色
    cursor.titleSelectedColor = [UIColor redColor];
    //是否显示排序按钮
    cursor.showSortbutton = YES;
    //默认的最小值是5，小于默认值的话按默认值设置
    cursor.minFontSize = 15;
    [self.view addSubview:cursor];
    tipView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 30)];
    
    labelTip = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    
    
    
    [tipView addSubview:labelTip];
    labelTip.font=[UIFont fontWithName:@"Arial" size:15];
    labelTip.numberOfLines=0;
    
    labelTip.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipView];
    
    tipView.alpha = 0;
}
- (NSMutableArray *)createPageViews{
    self.pageViews = [NSMutableArray array];
    
    dicOfjudgeData =[[NSMutableDictionary alloc]init];
    
    for (NSInteger i = 1; i <= self.titles.count; i++) {
        
        UITableView *table= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  SCREEN_HEIGHT-SCREEN_HEIGHT*64/667-25) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = NO;
        table.showsVerticalScrollIndicator=NO;
        table.tag = i;
        [dicOfjudgeData setValue:@"false" forKey:[NSString stringWithFormat: @"%ld",(long)table.tag]];
        [self requestData:table];
        [self.pageViews addObject:table];
        [self setupHeader:table];
        [self setupFooter:table];
        
        
        
        
    }
    return self.pageViews;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    NSString *judge  =[dicOfjudgeData valueForKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
    if ([judge isEqualToString:@"true"]) {
        self.array = [self.dicArray objectAtIndex:tableView.tag];
        
    }
    
    return [self.array count];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *string=[dic objectForKey:@"newsfirstimg"];
    [ReDataDic setValue:[dic objectForKey:@"newsid"] forKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];

    if([string isEqualToString:@""]){
        return self.view.frame.size.height/7;
        
    }else
        return self.view.frame.size.height/6;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (aJudge) {
        [timeA invalidate];
        [timeT invalidate];
        [self.shapeLayer removeFromSuperlayer];
        [self.backAnimationView removeFromSuperview];
        aJudge = FALSE;

    }
    
    static NSString *str=@"table";
    static NSString *str1=@"table1";
    [UIView  animateWithDuration:1.0 animations:^(void){
        [self.CustomView removeFromSuperview];
        [showTimer isValid];
        
    }];
    
    NSString *judge  =[dicOfjudgeData valueForKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
    if ([judge isEqualToString:@"false"]) {
        [self setAnimation];
        
        UITableViewCell *cellU;
        
        cellU = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
        
        
        cellU.textLabel.text = @"";
        return cellU;
        
        
    }else {
        
        
        NSArray *tempArray = [self.dicArray objectAtIndex:tableView.tag];
        
        dic= [tempArray objectAtIndex:indexPath.row];
        
        //url请求实在UI主线程中进行的
        
        
        NSString *string=[dic objectForKey:@"newsfirstimg"];
        [ReDataDic setValue:[dic objectForKey:@"newsid"] forKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
        
        
        if([string isEqualToString:@""]){
            TitleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
            if(cell==nil){
                cell=[[TitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            }
            cell.timeLabel.text = [dic valueForKey:@"newstime"];
            cell.title.text=[dic valueForKey:@"newstitle"];
            
            return cell;
            
        }else{
            NormalTableViewCell *cellN=[tableView dequeueReusableCellWithIdentifier:str1];
            //        if(cellN==nil){
            cellN=[[NormalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str1];
            //                }
            
            
            
            
            
            [cellN.image sd_setImageWithURL:[NSURL URLWithString:string]
                           placeholderImage:[UIImage imageNamed:@"watingImag.png"]];
            NSString *titleS =[dic valueForKey:@"newstitle"];
            
            cellN.title.text=titleS
            ;
            cellN.timeLabel.text=[dic valueForKey:@"newstime"];
            
            
            return cellN;
        }
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *tempArray = [self.dicArray objectAtIndex:tableView.tag];
    dic= [tempArray objectAtIndex:indexPath.row];
    NSString *newsidd = [dic objectForKey:@"newsid"];
    NewsViewController *nvc=[[NewsViewController alloc]init];
    
    nvc.newsId = [NSString stringWithFormat:@"%@",newsidd];
    nvc.newsminid = [minNewsId valueForKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
    nvc.newsmaxid = [maxNewsId valueForKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
    nvc.newsstyleid = [dic valueForKey:@"newsstyleid"];
    [self.navigationController pushViewController:nvc animated:YES];

}
//下拉刷新
- (void)requestNewData:(UITableView *)tableView and:(void (^)(void))finishBlock{
    NSString *table;//表名
    
    
    
    
    
    
    table = [dicTitle valueForKey:[self.titles objectAtIndex:tableView.tag-1]];
    
    
    
    
    NSString *key = @"hulijieluolianglvkang015";
    
    
    
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:key forKey:@"key"];
    [parameters setObject:table forKey:@"table"];
    
    
    NSString *url = @"http://115.29.176.50/interface/index.php/Home/ForU/searchNewNewsByTable";
    RequstData *request=[[RequstData alloc]init];
    
    
    
    [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){
        
        NSString *s =[dic1 objectForKey:@"error_code"];
        
        
        
        if ([s isEqualToString:@"0"]) {
            
            self.array=[dic1 objectForKey:@"result"];
            NSDictionary *dicTData =[self.array objectAtIndex: self.array.count-1] ;
            NewNewsNum  =[[dicTData valueForKey:@"newsid"] intValue] - [[maxNewsId valueForKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]]intValue] ;
            if (self.array.count>0) {
                [self insertData:self.array];
                
            }
            
        }else{
            NewNewsNum = 0;
        }
        
        finishBlock();
        
        
        
        self.array = [db getNews:[[self.array objectAtIndex:0] valueForKey:@"newsstyleid"]];
        NSString *newsMaxId =[[self.array objectAtIndex:0] valueForKey:@"newsid"];
        [maxNewsId setValue:newsMaxId forKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
        NSString *newsMinId =[[self.array objectAtIndex:self.array.count-1] valueForKey:@"newsid"];
        [minNewsId setValue:newsMinId forKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
        
        [ self.dicArray replaceObjectAtIndex:tableView.tag  withObject:self.array];//替换数组
        [dicOfjudgeData setValue:@"true" forKey:[NSString stringWithFormat: @"%ld",(long)tableView.tag]];
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }];
    
    
}
//自动刷新
-(void)getMoreData:(UITableView *)tableView andNewsId:(NSString *)newsid {
    NSString *table;//表名
    
    table = [dicTitle valueForKey:[self.titles objectAtIndex:tableView.tag-1]];
    
    NSString *key = @"hulijieluolianglvkang015";
    
    NSString *url = @"http://115.29.176.50/interface/index.php/Home/ForU/searchNewNewsByTableAndNewsId";
    RequstData *request=[[RequstData alloc]init];
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:key forKey:@"key"];
    [parameters setObject:table forKey:@"table"];
    [parameters setObject:newsid forKey:@"newsId"];
    
    [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){
        NSString *s =[dic1 objectForKey:@"error_code"];
        
        if ([s isEqualToString:@"0"]) {
            self.array=[dic1 objectForKey:@"result"];
            
            if (self.array.count>0) {
                [self insertData:self.array];
                
            }
            
        }
        
        self.array = [db getNews:[[self.array objectAtIndex:0] valueForKey:@"newsstyleid"]];
        NSString *newsMaxId =[[self.array objectAtIndex:0] valueForKey:@"newsid"];
        newsMaxId = [NSString stringWithFormat:@"%d",[newsMaxId intValue]+1];
        
        [maxNewsId setValue:newsMaxId forKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
        NSString *newsMinId =[[self.array objectAtIndex:self.array.count-1] valueForKey:@"newsid"];
        newsMinId = [NSString stringWithFormat:@"%d",[newsMinId intValue]-1];
        
        [minNewsId setValue:newsMinId forKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
        
        [ self.dicArray replaceObjectAtIndex:tableView.tag  withObject:self.array];//替换数组
        [dicOfjudgeData setValue:@"true" forKey:[NSString stringWithFormat: @"%ld",(long)tableView.tag]];
        
        
        [tableView reloadData];
        Rflag = true;
        
    }];
    
    
    
    
    
    
}

#pragma mark-初始请求数据
-(void)requestData:(UITableView *)tableView{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if (myDelegate.FLagData) {
        
        
        NSString *table;//表名
        table = [dicTitle valueForKey:[self.titles objectAtIndex:tableView.tag-1]];
        
        
        NSLog(@"%@",table);
        
        
        
        NSString *key = @"hulijieluolianglvkang015";//初始化数组
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:key forKey:@"key"];
        [parameters setObject:table forKey:@"table"];
        
        
        NSString *url = @"http://115.29.176.50/interface/index.php/Home/ForU/searchNewNewsByTable";
        RequstData *request=[[RequstData alloc]init];
        
        
        
        [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){
            
            NSString *s =[dic1 objectForKey:@"error_code"];
            
                     if ([s isEqualToString:@"0"]) {
                self.array=[dic1 objectForKey:@"result"];
                         if([[[self.array objectAtIndex:1 ] valueForKey:@"newsstyleid"] isEqualToString:@"11"]){
                             
                             
                             NSLog(@"%@",self.array);
                         }
                
                
                if (self.array.count>0) {
                    [self insertData:self.array];
                    
                }
                
            }else{
                
            }
            self.array = [db getNews:[[self.array objectAtIndex:0] valueForKey:@"newsstyleid"]];
            NSString *newsMaxId =[[self.array objectAtIndex:0] valueForKey:@"newsid"];
            [maxNewsId setValue:newsMaxId forKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
            NSString *newsMinId =[[self.array objectAtIndex:self.array.count-1] valueForKey:@"newsid"];
            [minNewsId setValue:newsMinId forKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
            
            [ self.dicArray replaceObjectAtIndex:tableView.tag  withObject:self.array];//替换数组
            [dicOfjudgeData setValue:@"true" forKey:[NSString stringWithFormat: @"%ld",(long)tableView.tag]];
            
            [tableView reloadData];
            TagDataJi++;
            if (TagDataJi>=self.titles.count) {
                myDelegate.FLagData = FALSE;
            }
            
        }];
        
        
    }else{
        
        NSString *table;//表名
        table = [dicTitle valueForKey:[self.titles objectAtIndex:tableView.tag-1]];
        
        
        tableModel *tableMode = [[tableModel alloc]init];
        
        NSMutableDictionary *dicData = [[NSMutableDictionary alloc]initWithDictionary:[tableMode getTableTurn]];
        NSArray *arr=[dicData allKeys];
        
        
        for (NSString *key in arr)
        {
            if (  [table isEqualToString:[dicData valueForKey:key]] )
            {
                
                self.array = [db getNews:key];
                NSString *newsMaxId =[[self.array objectAtIndex:0] valueForKey:@"newsid"];
                [maxNewsId setValue:newsMaxId forKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
                NSString *newsMinId =[[self.array objectAtIndex:self.array.count-1] valueForKey:@"newsid"];
                [minNewsId setValue:newsMinId forKey:[NSString stringWithFormat:@"%ld",(long)tableView.tag]];
                
                
            }
            
        }
        
        [ self.dicArray replaceObjectAtIndex:tableView.tag  withObject:self.array];//替换数组
        [dicOfjudgeData setValue:@"true" forKey:[NSString stringWithFormat: @"%ld",(long)tableView.tag]];
        
        [tableView reloadData];
        
    }
    
    
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
            
            
            [self requestNewData:table and:^(void){
                labelTip.frame = CGRectMake(0, 0, SCREEN_WIDTH, 30);
                tipView.backgroundColor = RGB(214, 213, 246);
                tipView.alpha = 1;
                if (NewNewsNum<=0) {
                    
                    labelTip.text = @"ForU君还在偷拍的路上";
                    [ UIView animateWithDuration:4.5 animations:^(void){
                        labelTip.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 30);
                        
                        
                    }];
                    [UIView animateWithDuration:5.5 animations:^(void){
                        
                        tipView.alpha = 0;
                    }];
                    
                }else{
                    labelTip.text = [NSString stringWithFormat:@"ForU搜索引擎有了%d条更新!",NewNewsNum];
                    [UIView animateWithDuration:2 animations:^(void){
                        
                        tipView.alpha = 0;
                    }];
                    
                }
                
                
                [weakRefreshHeader endRefreshing];
                [table reloadData];
            }];
            
            
        });
    };
    
    // 进入页面自动加载一次数据
    
}

- (void)setupFooter:(UITableView *)table

{
    self.table = table;
    
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    self.refreshFooter= refreshFooter;
    [self.refreshFooter addToScrollView:table];
    __weak SDRefreshFooterView *weakRefreshHeader = self.refreshFooter;
    __weak typeof(self) weakSelf = self;
    self.refreshFooter.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //            weakSelf.totalRowCount += 10;
            
            [weakRefreshHeader endRefreshing];
            [weakSelf.table reloadData];
        });
    };
    
    
}





-(void)insertData:(NSArray *)array{
    NSDictionary *dicT;
    for (int  i=0; i<array.count; i++) {
        dicT = [array objectAtIndex:i];
        if ([db checkNews:[dicT valueForKey:@"newstitle"]]) {
            [db insertNewsData:dicT];
            
        }
        
        
    }
    
}
-(void)TipNoNews{
    
}
-(void)iniDicTitle{
    
    [dicTitle setValue:@"worldnews" forKey:@"国际"];
    [dicTitle setValue:@"socialnews" forKey:@"社会"];
    [dicTitle setValue:@"entertainmentnews" forKey:@"娱乐"];
    [dicTitle setValue:@"mainlandnews" forKey:@"大陆"];
    [dicTitle setValue:@"tourismnews" forKey:@"旅游"];
    [dicTitle setValue:@"militarynews" forKey:@"军事"];
    [dicTitle setValue:@"fashionnews" forKey:@"时尚"];
    [dicTitle setValue:@"booknews" forKey:@"读书"];
    [dicTitle setValue:@"culturenews" forKey:@"文化"];
    [dicTitle setValue:@"educationnews" forKey:@"教育"];
    [dicTitle setValue:@"technologynews" forKey:@"科技"];
    [dicTitle setValue:@"sportsnews" forKey:@"体育"];
    [dicTitle setValue:@"financenews" forKey:@"财经"];
    [dicTitle setValue:@"carnews" forKey:@"汽车"];
    [dicTitle setValue:@"commentsnews" forKey:@"热论"];
    [dicTitle setValue:@"housenews" forKey:@"房产"];
    [dicTitle setValue:@"historynews" forKey:@"历史"];
    [dicTitle setValue:@"blognews" forKey:@"博文"];
    [dicTitle setValue:@"taiwannews" forKey:@"台湾"];
    [dicTitle setValue:@"hknews" forKey:@"港澳"];
    [dicTitle setValue:@"moralintegritynews" forKey:@"节操"];
    [dicTitle setValue:@"toutiaohotnews" forKey:@"热点"];
    
    
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
        
        _shapeLayer.frame = CGRectMake(0, (size.height - height)*0.222, size.width , height);
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
-(void)setAnimation{//加载等待动画
    [timeA invalidate];
    [timeT invalidate];
    [self.shapeLayer removeFromSuperlayer];
    [self.backAnimationView removeFromSuperview];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
       aJudge = true;
    if (myDelegate.FLagData) {
        
        
        self.CustomButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-90, self.view.frame.size.height*0.304, 180, 30)];
        
        
        [self.CustomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self timeSetLabel];
        
        
        self.backAnimationView  = [[UIView alloc]initWithFrame:CGRectMake(0,50, self.view.frame.size.width, SCREEN_HEIGHT-50)];
        
        self.backAnimationView.backgroundColor = [UIColor whiteColor];
        self.backAnimationView.alpha = 1;
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

}


@end

