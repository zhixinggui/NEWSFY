//
//  CollectionViewController.m
//  ForU
//
//  Created by administrator on 15/9/23.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "CollectionViewController.h"
#import "RequstData.h"
#import "RequstLocalData.h"
#import "singleNewView.h"
#import "MJRefresh.h"
#import "NoImgTableViewCell.h"
#import "ImgTableViewCell.h"
@interface CollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)GetCodeNavigationBar *navBar;
@property(strong,nonatomic)UITableView *table;
@property(strong,nonatomic)NSMutableArray *resultArray;

@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic,strong)CustomButton *CustomButton;
@property (nonatomic,strong)UIView *CustomView;
@property (nonatomic,strong)NSTimer *showTimer;


@end

@implementation CollectionViewController{
    NSMutableDictionary *dicNews;
    NSDictionary *dic;
    int jiT;
    NSInteger focusSection ;
    NSInteger focusRow ;
    int userId;
    NSInteger requestNumber;
    UILabel *tempLabel;
}

-(void)viewWillAppear:(BOOL)animated{
    [self initView];
}

- (void)viewDidLoad {
     [super viewDidLoad];
   
//    dic=[[NSDictionary alloc]init];
//    self.navigationBarHidden=YES;
    self.resultArray = [NSMutableArray array];
    
    requestNumber = 0;
    
    RequstLocalData *request = [[RequstLocalData alloc] init];
    userId = [[[request requestLocalInfo] valueForKey:@"userid"] intValue] ;
    

    //通过userId获取收藏的新闻,userId从登录时获取
//    if (userId) {
        [self requestMyCollectionNews:userId];
        
//    }else{
//        [self noCollection];
//    }
//    
    
    
}
//初始化页面
-(void)initView{
    
    [self initTimer];
    
    self.view.backgroundColor=[UIColor grayColor];
    self.navBar = [[GetCodeNavigationBar alloc] initWithNavBar:@"返回" andLabel:@"收藏" andBtn:nil];
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.backgroundColor=[UIColor colorWithRed:195/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:self.navBar];
    
    self.table=[[UITableView alloc]initWithFrame:CGRectMake(0, self.navBar.frame.size.height, self.view.frame.size.width,self.view.frame.size.height-self.navBar.frame.size.height)];
    self.table.tableFooterView = [[UIView alloc] init];
    self.table.showsVerticalScrollIndicator = NO;
    self.table.showsHorizontalScrollIndicator = NO;
    self.table.dataSource=self;
    self.table.delegate=self;
    [self.view addSubview:self.table];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)];
    longPress.minimumPressDuration = 1.0 ;
    [self.table addGestureRecognizer:longPress];
    
    
    self.table.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestMyCollectionNews:userId];
    }];
}

//UITableView协议实现
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *str=@"table";
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
//    if(cell==nil){
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
//    }
//
//    //从后往前取数据
//    cell.textLabel.text = [self.resultArray[self.resultArray.count-1-indexPath.row] objectForKey:@"newsTitle"];
//    cell.textLabel.font = [UIFont systemFontOfSize:15];
//
//    
//    cell.detailTextLabel.text = [self.resultArray[self.resultArray.count-1-indexPath.row] objectForKey:@"newsTime"];
//    cell.detailTextLabel.textColor = [UIColor grayColor];
//
//    //异步加载图片
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.resultArray[indexPath.row] objectForKey:@"newsFirstImg"]]];
//            UIImage *image = [UIImage imageWithData:data];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                cell.imageView.image = image;
//            });
//        });
//    return cell;
    
    NSLog(@"%@",self.resultArray[indexPath.row]);
    
    if ([[self.resultArray[self.resultArray.count-1-indexPath.row] objectForKey:@"newsFirstImg"] isEqualToString:@""]) {
        
        static NSString *str=@"table1";
        NoImgTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
        if(cell==nil){
            cell=[[NoImgTableViewCell alloc]init];
        }
        
        //从后往前取数据
        cell.titleLabel.text = [self.resultArray[self.resultArray.count-1-indexPath.row] objectForKey:@"newsTitle"];
        //        cell.titleLabel.font = [UIFont systemFontOfSize:15];
        
        cell.timeLabel.text = [self.resultArray[self.resultArray.count-1-indexPath.row] objectForKey:@"newsTime"];
        cell.timeLabel.textColor = [UIColor grayColor];
        
        return cell;
        
    }else{
        static NSString *str=@"table2";
        ImgTableViewCell *Imgcell=[tableView dequeueReusableCellWithIdentifier:str];
        if(Imgcell==nil){
            Imgcell=[[ImgTableViewCell alloc]init];
        }
        
        //从后往前取数据
        NSString *title = [self.resultArray[self.resultArray.count-1-indexPath.row] objectForKey:@"newsTitle"];
        Imgcell.titleLabel.text = title;
        
        Imgcell.timeLabel.text = [self.resultArray[self.resultArray.count-1-indexPath.row] objectForKey:@"newsTime"];
        Imgcell.timeLabel.textColor = [UIColor grayColor];
        
        //异步加载图片
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.resultArray[self.resultArray.count-1-indexPath.row] objectForKey:@"newsFirstImg"]]];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                Imgcell.imageview.image = image;
            });
        });
        
        return Imgcell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return SCREEN_HEIGHT/6;
    
}

//请求收藏表获取新闻的类型和新闻ID
-(void)requestMyCollectionNews:(int)UserId{
    NSMutableDictionary *userIdDic = [NSMutableDictionary dictionary];
    
    [userIdDic setValue:[NSString stringWithFormat:@"%d",UserId] forKey:@"userId"];
    
    requestNumber += 1;
    [userIdDic setValue:[NSString stringWithFormat:@"%ld",(long)requestNumber] forKey:@"requestNumber"];
    
//    NSLog(@"%@",userIdDic);
    
    GetMyCollectionNewsService *query = [[GetMyCollectionNewsService alloc] init];
    [query requestCollectionNews:userIdDic andResult:^(NSMutableDictionary *success) {
        
        NSArray *tempArray = [success objectForKey:@"result"];
        
        [self.resultArray addObjectsFromArray:tempArray];
        
//        NSLog(@"%@",[tempArray firstObject]);
        

        [self.table reloadData];
        
        //关闭刷新
        [self.table.footer endRefreshing];
     
        if (tempArray.count == 0 && requestNumber > 1) {
//            //刷新提示
            if (tempArray.count == 0) {
                tempLabel = [[UILabel alloc] init];
                tempLabel.text = @"U君:(°ˊДˋ°) 没有了~";
                tempLabel.frame = CGRectMake(SCREEN_WIDTH/2-65, SCREEN_HEIGHT/2-15, 130, 30);
                tempLabel.layer.borderWidth = 0.5;
                tempLabel.layer.borderColor = [UIColor grayColor].CGColor;
                tempLabel.textAlignment = NSTextAlignmentCenter;
                tempLabel.backgroundColor = [UIColor clearColor];
                tempLabel.layer.cornerRadius = 8;
                tempLabel.layer.backgroundColor = [UIColor groupTableViewBackgroundColor].CGColor;
                tempLabel.textColor = [UIColor colorWithRed:191/255.0 green:0/255.0 blue:95/255 alpha:0.7];
                tempLabel.font = [UIFont systemFontOfSize:12];
                [self.view addSubview:tempLabel];
                
                self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(test) userInfo:nil repeats:NO];
                
            }
        }
        
        //关掉
        [self.showTimer invalidate];
        [self.CustomView removeFromSuperview];
        
        //没有收藏时候的页面
        if (self.resultArray.count == 0) {
                [self noCollection];
        }
    }];
    
}
//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    tempDic = self.resultArray[self.resultArray.count-1-indexPath.row];
  
    //跳转到详情页
    singleNewView *svc = [[singleNewView alloc]init];
    svc.newsId =[tempDic objectForKey:@"newsId"];
    svc.newsstyleid =[tempDic objectForKey:@"newsStyleId"];

    [self.navigationController pushViewController:svc animated:YES];
 
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.resultArray.count) {
        [self deleteWithIndexPath:indexPath.row];
    }
}



//按钮点击事件
-(void)click:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initTimer{
    
    self.CustomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH/2, SCREEN_WIDTH,  SCREEN_WIDTH/2)];
    
    self.CustomView.backgroundColor = [UIColor clearColor];
    self.CustomButton = [[CustomButton alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,  SCREEN_WIDTH*2/3)];
    
    [self.CustomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.CustomView addSubview:self.CustomButton];
    
    [self.view addSubview:self.CustomView];
    
    //时间间隔
    NSTimeInterval timeInterval =1.0 ;
    //定时器
    _showTimer= [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                 target:self
                                               selector:@selector(timeSetLabel)
                                               userInfo:nil
                                                repeats:YES];
    [_showTimer fire];
}

-(void)timeSetLabel{
    
    NSString *s3 = @"正在努力加载中···";
    NSString *s2 = @"正在努力加载中··";
    NSString *s1 = @"正在努力加载中·";
    [self.CustomButton setUserInteractionEnabled:NO];
    [self.CustomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

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
//处理长按手势
-(void)longTap:(UILongPressGestureRecognizer *)longRecognizer{
    
    CGPoint tmpPointTouch = [longRecognizer locationInView:self.table];
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath = [self.table indexPathForRowAtPoint:tmpPointTouch];
        if (indexPath == nil) {

        }else{
            UIAlertController *contoller = [UIAlertController alertControllerWithTitle:nil message:@"确定要删除？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    focusRow = [indexPath row];
                    focusSection = [indexPath section];

                [self deleteWithIndexPath:focusRow];
  
            }];
            [contoller addAction:cancelAction];
            [contoller addAction:otherAction];
            [self presentViewController:contoller animated:YES completion:nil];
        }
    }
}

-(void)deleteWithIndexPath:(NSInteger)indexPath{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    tempDic = self.resultArray[self.resultArray.count-1-indexPath];
    NSMutableDictionary *newsDic = [NSMutableDictionary dictionary];
    [newsDic setValue:[tempDic objectForKey:@"newsId"] forKey:@"newsId"];
    [newsDic setValue:[tempDic objectForKey:@"newsStyleId"] forKey:@"newsStyleId"];
    [newsDic setValue:[NSString stringWithFormat:@"%d",userId] forKey:@"userId"];
    [newsDic setValue:@"hulijieluolianglvkang015" forKey:@"key"];

    RequstData *request = [[RequstData alloc]init];
    NSString *url = @"http://115.29.176.50/interface/index.php/Home/ForU/deleteFavByUserIdAndNewsId";
    [request requestData:url url:newsDic dic:^(NSMutableDictionary*dic1){
//        [self requestMyCollectionNews:userId];
//        [self.table reloadData];
        [self viewDidLoad];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)noCollection{
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3, self.view.frame.size.height/3, self.view.frame.size.width/3, self.view.frame.size.height/5)];
    img.image = [UIImage imageNamed:@"无收藏"];
    [self.view addSubview:img];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/3+img.frame.size.height+10, self.view.frame.size.width, 20)];
    label.text = @"时光虽逝 记忆停留 ~ ~";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];

}


-(void)test{
    [UIView animateWithDuration:1 animations:^{
        tempLabel.frame = CGRectMake(SCREEN_WIDTH/2-65, SCREEN_HEIGHT, 130, 30);
    } completion:^(BOOL finished) {
        [tempLabel removeFromSuperview];
    }];

}


@end
