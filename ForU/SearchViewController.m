//
//  SearchViewController.m
//  ForU
//
//  Created by administrator on 15/9/23.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "SearchViewController.h"
#import "MenuNavigationBar.h"
#import "singleNewView.h"
#import "Header.h"
@interface SearchViewController ()
@property(strong,nonatomic)GetCodeNavigationBar *navBar;
@property(strong,nonatomic)UISearchBar *SearchBar;
@property(strong,nonatomic)UITableView *table;
@property(strong,nonatomic)NSString *searchText;
@property(strong,nonatomic)NSMutableDictionary *titleDic,*resultDic;
@property(strong,nonatomic)NSString *newsStyleId,*newsId;
@property(strong,nonatomic)NSArray *news;
@property(strong,nonatomic)UIActivityIndicatorView *activity;
@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic,strong)CustomButton *CustomButton;
@property (nonatomic,strong)UIView *CustomView;
@property (nonatomic,strong)NSTimer *showTimer;

@property(strong,nonatomic)PopoverView2 *pop;


@property(strong,nonatomic)NSMutableArray *resultArray;

@end

@implementation SearchViewController{
    int jiT;
    NSInteger requestNumber;
    UILabel *tempLabel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.resultArray = [NSMutableArray array];
    [self initView];
    
}


-(void)initView{
    
#pragma - mark 设置navBar
    self.navBar = [[GetCodeNavigationBar alloc] initWithNavBar:@"返回" andLabel:@"搜索" andBtn:nil];
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
   self.navBar.backgroundColor=[UIColor colorWithRed:195/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:self.navBar];

    
    self.SearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, self.navBar.frame.size.height, self.view.frame.size.width, 44)];
    [self.SearchBar sizeToFit];
    self.SearchBar.backgroundColor = [UIColor lightGrayColor];
    self.SearchBar.delegate = self;
    self.SearchBar.layer.cornerRadius = 10;
    self.SearchBar.placeholder =@"请输入关键词";
    [self.SearchBar becomeFirstResponder];
    [self.view addSubview:self.SearchBar];
    
    
    
    self.table = [[UITableView alloc] init];
    self.table.frame = CGRectMake(0, self.navBar.frame.size.height+self.SearchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.navBar.frame.size.height-44);
    self.table.tableFooterView = [[UIView alloc] init];
    self.table.showsVerticalScrollIndicator = NO;
    self.table.showsHorizontalScrollIndicator = NO;
    self.table.dataSource = self;
    self.table.delegate = self;
//    self.table.tableHeaderView = self.SearchBar;
    
    self.table.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestNews:self.searchText];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.resultArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
 
    if (self.resultArray.count != 0) {
//        NSString *newsTitle = [self.resultArray[indexPath.row] objectForKey:@"newsTitle"];
//        cell.textLabel.text = newsTitle;
        
        //设置关键字为红色
        NSString *newsTitle = [self.resultArray[indexPath.row] objectForKey:@"newsTitle"];
        if ([newsTitle rangeOfString:self.searchText].length>0) {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:newsTitle];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange([newsTitle rangeOfString:self.searchText].location, self.searchText.length)];
            cell.textLabel.attributedText = str;
        }else{
            cell.textLabel.text = newsTitle;
        }
        
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.detailTextLabel.text = [self.resultArray[indexPath.row] objectForKey:@"newsTime"];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    
    return cell;
}
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

//使用关键词搜索新闻
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.searchText = searchText;
    
    requestNumber = 0; //第一次请求
    
    [self.resultArray removeAllObjects];
    
}

//输入搜索文字时隐藏搜索按钮，清空时显示
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    //移除tableView,显示热词
    [self.table removeFromSuperview];
    
    [self readNSUserDefaults];
    self.SearchBar.showsScopeBar = YES;
    [self.SearchBar sizeToFit];
    [self.SearchBar setShowsCancelButton:YES animated:YES];
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    self.SearchBar.showsScopeBar = NO;
    [self.SearchBar sizeToFit];
    [self.SearchBar setShowsCancelButton:NO animated:YES];
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{  //更改取消键
   self.SearchBar.showsCancelButton= YES;
    for(id view in [self.SearchBar.subviews[0] subviews]){
        if([view isKindOfClass:[UIButton class]]){
            UIButton *btn = (UIButton *)view;
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            break;
        }
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.SearchBar resignFirstResponder];
    [_pop dismiss];
    
    //将搜索内容先存到本地
    [self SearchText:self.searchText];
    
    //输入空格 的情况
    if (self.searchText.length == 0) {
    }else{
        [self initTimer];
        [self requestNews:self.searchText];
    }
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.SearchBar resignFirstResponder];
}
//搜索历史    将每次的关键字加入到本地
-(void)SearchText:(NSString *)seaTxt{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *myArray=[userDefaults objectForKey:@"myArray"];
    
    if (myArray.count==0) {
        NSMutableArray *temp = [NSMutableArray arrayWithObjects:seaTxt, nil];
        [userDefaults setObject:temp forKey:@"myArray"];
    }else{
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        //读取数组NSArray类型的数据
        NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
        // NSArray --> NSMutableArray
        NSMutableArray *searTXT = [myArray mutableCopy];
        
        [searTXT addObject:seaTxt];

        if(searTXT.count >= 4){
            [searTXT removeObjectAtIndex:0];
        }
        //将上述数据全部存储到NSUserDefaults中
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:searTXT forKey:@"myArray"];
   }
}

-(void)readNSUserDefaults{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    
    CGPoint point = CGPointMake(self.view.frame.size.width/2,self.navBar.frame.size.height+self.SearchBar.frame.size.height);
    
    NSArray *myArray = [userDefaultes arrayForKey:@"myArray"];
    NSMutableArray *myArray_new = [myArray mutableCopy];
    if (myArray_new.lastObject != nil) {
        [myArray_new addObject:@"清除历史"];
    }
    
    
    __weak typeof(self) weakself = self;
    _pop = [[PopoverView2 alloc] initWithPoint:point titles:myArray_new images:nil];
    _pop.selectRowAtIndex = ^(NSInteger index){

        if ([myArray_new[index] isEqualToString:myArray_new.lastObject]) {
            //清除搜索历史
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myArray"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            
            [weakself.SearchBar resignFirstResponder];
            weakself.SearchBar.text = myArray_new[index];
            
            weakself.searchText = myArray_new[index];
            
            [weakself initTimer];
            [weakself requestNews:myArray_new[index]];
        }
    };
    if (myArray.count==0) {
    }else{
        [_pop show];
    }
    
    [self getHot];
   
}
//根据传入的title获取相关新闻
-(void)requestNews:(NSString *)title{
    
    self.titleDic = [NSMutableDictionary dictionary];
    
    [self.titleDic setValue:title forKey:@"title"];
    

    
    requestNumber += 1;
    

    
    [self.titleDic setValue:[NSString stringWithFormat:@"%ld",(long)requestNumber] forKey:@"requestNumber"];
    
//    [self.titleDic setValue:@"1" forKey:@"requestNumber"];
    
    SearchNewsService *query=[[SearchNewsService alloc]init];
    
    [query requestNews:self.titleDic andquery:^(NSMutableDictionary *success) {
        [self toFillCell:success];
    }];
}

-(void)toFillCell:(NSMutableDictionary *)dic{
    
    self.news = [dic objectForKey:@"result"];
    
    [self.resultArray addObjectsFromArray:self.news];
    
    if (self.resultArray.count == 0) {
        UIAlertController *contoller = [UIAlertController alertControllerWithTitle:nil message:@"未能找到相关内容" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [contoller addAction:otherAction];
        [self presentViewController:contoller animated:YES completion:nil];
    }else{
        
        [self.view addSubview:self.table];

        [self.table reloadData];
        
        if (self.news.count == 0 && requestNumber > 1) {
            //            //刷新提示
            if (self.news.count == 0) {
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

    }
    //关闭
    [self.showTimer invalidate];
    [self.CustomView removeFromSuperview];
    
    //关闭刷新
    [self.table.footer endRefreshing];
}

-(void)initTimer{
    
    self.CustomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  SCREEN_HEIGHT)];
    
    self.CustomView.backgroundColor = RGBAA(100, 100, 100, 0.8);
    self.CustomButton = [[CustomButton alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT/3, SCREEN_WIDTH,  SCREEN_WIDTH*2/3)];
    
    [self.CustomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.CustomView addSubview:self.CustomButton];
    
    [self.view addSubview:self.CustomView];
    
    //时间间隔
    NSTimeInterval timeInterval =0.5 ;
    //定时器
    _showTimer= [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                 target:self
                                               selector:@selector(timeSetLabel)
                                               userInfo:nil
                                                repeats:YES];
    [_showTimer fire];

}

-(void)timeSetLabel{
    
    NSString *s3 = @"搜索中···";
    NSString *s2 = @"搜索中··";
    NSString *s1 = @"搜索中·";
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

-(void)hotView:(NSMutableDictionary*)dic{
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, self.navBar.frame.size.height+self.SearchBar.frame.size.height+self.pop.frame.size.height+10, self.view.frame.size.width-20, self.view.frame.size.height-self.navBar.frame.size.height-self.SearchBar.frame.size.height-self.pop.frame.size.height-20)];
    
//    NSLog(@"============>%@",dic);

    
    NSArray *hotArray = [dic objectForKey:@"result"];
    
    if (hotArray.count == 0) {
        NSLog(@"没有热点");
    }else{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, self.navBar.frame.size.height+self.SearchBar.frame.size.height+15, self.view.frame.size.width-20, self.view.frame.size.height-self.navBar.frame.size.height-self.SearchBar.frame.size.height-20)];
//    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    
    
    UILabel *hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 20)];
    hotLabel.text = @"ForU推荐:";
    hotLabel.font = [UIFont systemFontOfSize:12];
    hotLabel.textColor = [UIColor grayColor];
    [view addSubview:hotLabel];
    
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.titleLabel.font = [UIFont systemFontOfSize:12];
//    [btn1 setTitle:@"习近平十三五计划" forState:UIControlStateNormal];
    [btn1 setTitle:[hotArray objectAtIndex:0] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn1.layer.borderWidth = 1;
    btn1.layer.borderColor = [UIColor grayColor].CGColor;
    btn1.layer.cornerRadius = 3;
    btn1.frame = CGRectMake(5, 30, btn1.titleLabel.text.length*12+10, 30);
    [view addSubview:btn1];
    
    
    UIButton *btn2 = [[UIButton alloc] init];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
//    [btn2 setTitle:@"三大运营商三大运营商" forState:UIControlStateNormal];
    [btn2 setTitle:[hotArray objectAtIndex:1] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn2.layer.borderWidth = 1;
    btn2.layer.borderColor = [UIColor grayColor].CGColor;
    btn2.layer.cornerRadius = 3;
    btn2.frame = CGRectMake(5+btn1.frame.size.width+20, 30, btn2.titleLabel.text.length*12+10, 30);
    [view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] init];
    btn3.titleLabel.font = [UIFont systemFontOfSize:12];
//    [btn3 setTitle:@"中国飞人" forState:UIControlStateNormal];
    [btn3 setTitle:[hotArray objectAtIndex:2] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn3.layer.borderWidth = 1;
    btn3.layer.borderColor = [UIColor grayColor].CGColor;
    btn3.layer.cornerRadius = 3;
    btn3.frame = CGRectMake(5, 75, btn3.titleLabel.text.length*12+10, 30);
    [view addSubview:btn3];

    
    UIButton *btn4 = [[UIButton alloc] init];
    btn4.titleLabel.font = [UIFont systemFontOfSize:12];
//    [btn4 setTitle:@"五中全会今日闭幕" forState:UIControlStateNormal];
    [btn4 setTitle:[hotArray objectAtIndex:3] forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn4.layer.borderWidth = 1;
    btn4.layer.borderColor = [UIColor grayColor].CGColor;
    btn4.layer.cornerRadius = 3;
    btn4.frame = CGRectMake(5+btn3.frame.size.width+20, 75, btn4.titleLabel.text.length*12+10, 30);
    [view addSubview:btn4];
    
    UIButton *btn5 = [[UIButton alloc] init];
    btn5.titleLabel.font = [UIFont systemFontOfSize:12];
//    [btn5 setTitle:@"消协旅游消协旅游" forState:UIControlStateNormal];
    [btn5 setTitle:[hotArray objectAtIndex:4] forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn5.layer.borderWidth = 1;
    btn5.layer.borderColor = [UIColor grayColor].CGColor;
    btn5.layer.cornerRadius = 3;
    if ((5+btn3.frame.size.width+20+btn4.frame.size.width+20+btn5.titleLabel.text.length*12+20+10)>view.frame.size.width) {
        btn5.frame = CGRectMake(5, 120, btn5.titleLabel.text.length*12+10, 30);
    }else{
        btn5.frame = CGRectMake(5+btn3.frame.size.width+20+btn4.titleLabel.text.length*12+10+20, 75, btn5.titleLabel.text.length*12+10, 30);
    }
    [view addSubview:btn5];
    
    
    [btn1 addTarget:self action:@selector(hotclick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(hotclick:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(hotclick:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(hotclick:) forControlEvents:UIControlEventTouchUpInside];
    [btn5 addTarget:self action:@selector(hotclick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)getHot{
    //请求热词
    GetHotService *hot = [[GetHotService alloc] init];
    [hot Gethot:nil andMessage:^(NSMutableDictionary *success) {
        [self hotView:success];
    }];
}

-(void)hotclick:(UIButton *)sender{
    
    [self.SearchBar resignFirstResponder];
    
    self.searchText = sender.titleLabel.text;
    [self SearchText:self.searchText];
    
    self.SearchBar.text = sender.titleLabel.text;
    [self initTimer];
    [self requestNews:sender.titleLabel.text];
}

- (void)viewWillAppear {
    [self.SearchBar becomeFirstResponder];
}

- (void)viewWillDisAppear {
    [self.SearchBar resignFirstResponder];
    [self.timer invalidate];
}

-(void)click:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
    [self.SearchBar resignFirstResponder];
}

-(void)test{
    [UIView animateWithDuration:1 animations:^{
        tempLabel.frame = CGRectMake(SCREEN_WIDTH/2-65, SCREEN_HEIGHT, 130, 30);
    } completion:^(BOOL finished) {
        [tempLabel removeFromSuperview];
    }];
    
}
@end
