//
//  FootPrintViewController.m
//  ForU
//
//  Created by administrator on 15/9/23.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "FootPrintViewController.h"
#import "MenuNavigationBar.h"
#import "RequstLocalData.h"
#import "singleNewView.h"
#import "Header.h"
@interface FootPrintViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)GetCodeNavigationBar *navBar;
@property (strong,nonatomic)UITableView *table;
@property(strong,nonatomic)NSMutableArray *resultArray;
@property (nonatomic,strong)NSTimer *timer;
@end

@implementation FootPrintViewController{
    int userId;
    NSInteger requestNumber;
    UILabel *tempLabel;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self initView];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.resultArray = [NSMutableArray array];
    
    RequstLocalData *request = [[RequstLocalData alloc] init];
    userId = [[[request requestLocalInfo] valueForKey:@"userid"] intValue] ;
    
    requestNumber = 0; //第一次请求
    
    [self requestFootPrintNews:userId];
    
}
-(void)initView{
    self.navBar = [[GetCodeNavigationBar alloc] initWithNavBar:@"返回" andLabel:@"足迹" andBtn:@"删除"];
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar.rightBtn addTarget:self action:@selector(deleteAll) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.backgroundColor=[UIColor colorWithRed:195/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    
    [self.view addSubview:self.navBar];

    self.table=[[UITableView alloc]initWithFrame:CGRectMake(0, self.navBar.frame.size.height, self.view.frame.size.width,self.view.frame.size.height-self.navBar.frame.size.height)];
    self.table.dataSource=self;
    self.table.delegate=self;
    self.table.showsVerticalScrollIndicator= NO;
    self.table.showsHorizontalScrollIndicator = NO;
    self.table.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.table];
    
    self.table.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestFootPrintNews:userId];
    }];
}
//按钮点击事件
-(void)click:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)deleteAll{
    if (self.resultArray.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"还没有足迹哟~" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertController *contoller = [UIAlertController alertControllerWithTitle:nil message:@"确定要清空足迹？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self deleteFootPrint:userId];
        }];
        [contoller addAction:cancelAction];
        [contoller addAction:otherAction];
        [self presentViewController:contoller animated:YES completion:nil];
    }
}

//UITableView协议实现
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"table";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    if (self.resultArray.count != 0) {
        cell.textLabel.text = [self.resultArray[indexPath.row] objectForKey:@"newsTitle"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.text = [self.resultArray[indexPath.row] objectForKey:@"newsTime"];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    return cell;
}
//第一次请求收藏表获取新闻的类型和新闻ID
-(void)requestFootPrintNews:(int)UserId{
    NSMutableDictionary *userIdDic = [NSMutableDictionary dictionary];
    [userIdDic setValue:[NSString stringWithFormat:@"%d",UserId] forKey:@"userId"];
    requestNumber += 1;
    [userIdDic setValue:[NSString stringWithFormat:@"%ld",(long)requestNumber] forKey:@"requestNumber"];
  
    GetFootPrintNewsService *query = [[GetFootPrintNewsService alloc] init];
    [query requestCollectionNews:userIdDic andResult:^(NSMutableDictionary *success) {
        
        NSArray *tempArray = [success objectForKey:@"result"];
        
        [self.resultArray addObjectsFromArray:tempArray];
        
        //关闭刷新
        [self.table.footer endRefreshing];
        
        [self.table reloadData];
        
        
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
        
        //没有收藏时候的页面
        if (self.resultArray.count == 0) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3, self.view.frame.size.height/3, self.view.frame.size.width/3, self.view.frame.size.height/5)];
            img.image = [UIImage imageNamed:@"无足迹"];
            [self.view addSubview:img];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/3+img.frame.size.height+10, self.view.frame.size.width, 20)];
            label.text = @"快去看看有趣新闻吧 ~ ~";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor grayColor];
            [self.view addSubview:label];
        }
    }];
    
}
//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    tempDic = self.resultArray[indexPath.row];
    
    singleNewView *svc = [[singleNewView alloc]init];
    svc.newsId =[tempDic objectForKey:@"newsId"];
    svc.newsstyleid =[tempDic objectForKey:@"newsStyleId"];
       [self.navigationController pushViewController:svc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(void)deleteFootPrint:(int)UserId{
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic setValue:[NSString stringWithFormat:@"%d",userId] forKey:@"userId"];
    [tempDic setValue:@"hulijieluolianglvkang015" forKey:@"key"];

    deleteFootPrintService *delete = [[deleteFootPrintService alloc]init];
    [delete deleteFootPrint:tempDic andMessage:^(NSMutableDictionary *success) {
        [self viewDidLoad];
    }];
}

-(void)deleteWithIndexPath:(NSInteger)indexPath{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    tempDic = self.resultArray[indexPath];
    NSMutableDictionary *newsDic = [NSMutableDictionary dictionary];
    [newsDic setValue:[tempDic objectForKey:@"newsId"] forKey:@"newsId"];
    [newsDic setValue:[tempDic objectForKey:@"newsStyleId"] forKey:@"newsStyleId"];
    [newsDic setValue:[NSString stringWithFormat:@"%d",userId] forKey:@"userId"];
    [newsDic setValue:@"hulijieluolianglvkang015" forKey:@"key"];
    
    deleteFootPrintService *delete = [[deleteFootPrintService alloc]init];
    [delete deleteFootPrint:newsDic andMessage:^(NSMutableDictionary *success) {
        
        [self viewDidLoad];
        
    }];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.resultArray.count) {
        [self deleteWithIndexPath:indexPath.row];
    }
}
-(void)test{
    [UIView animateWithDuration:1 animations:^{
        tempLabel.frame = CGRectMake(SCREEN_WIDTH/2-65, SCREEN_HEIGHT, 130, 30);
    } completion:^(BOOL finished) {
        [tempLabel removeFromSuperview];
    }];
    
}
@end
