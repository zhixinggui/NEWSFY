//
//  CommentViewController.m
//  ForU
//
//  Created by administrator on 15/11/2.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController{
    int userId;
    int requestNumber;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [SVProgressHUD showProgress:10.0 status:@"正在加载中..."];
    
    RequstLocalData *requestUserId = [[RequstLocalData alloc] init];
    userId = [[[requestUserId requestLocalInfo] valueForKey:@"userid"] intValue] ;
    
    requestNumber = 0;
    
    self.array = [[NSArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height/10 )];
    self.imageView.image=[UIImage imageNamed:@"top_navigation_background@2x.png"];
    self.imageView.alpha = 0.8;
    [self.view addSubview:self.imageView];
//    self.navBar=[[GetCodeNavigationBar alloc]initWithNavBar:@"返回" andLabel:@"评论" andBtn:nil];
    self.navBar=[[GetCodeNavigationBar alloc]initWithNavBar:@"返回" andLabel:@"评论" andBtn:@"删除"];

    //不给删除，与举报有冲突
        [self.navBar.rightBtn addTarget:self action:@selector(deleteAll) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.backgroundColor=[UIColor clearColor];
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.leftBtn.tag=1;
    [self.view bringSubviewToFront:self.imageView];
    
    [self.view addSubview:self.navBar];
    
    [self.view bringSubviewToFront:self.navBar];
    
    
    [self requestMyCommentNews];
    
    
}

-(void)requestMyCommentNews{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    NSString *key = @"hulijieluolianglvkang015";
    [parameters setObject:key forKey:@"key"];
    
    requestNumber += 1;
    
    [parameters setObject:[NSString stringWithFormat:@"%d",requestNumber] forKey:@"requestNumber"];
    [parameters setObject:[NSString stringWithFormat:@"%d",userId] forKey:@"userId"];
    
    
    NSString *url = @"http://115.29.176.50/interface/getComment.php";
    RequstData *request=[[RequstData alloc]init];
    [request requestData:url url:parameters dic:^(NSMutableDictionary*dic){
        
        self.array=[dic objectForKey:@"result"];
        
        [SVProgressHUD dismiss];
        
        if (self.array.count == 0) {
            
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3, self.view.frame.size.height/3, self.view.frame.size.width/3, self.view.frame.size.height/5)];
            img.image = [UIImage imageNamed:@"无足迹"];
            [self.view addSubview:img];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/3+img.frame.size.height+10, self.view.frame.size.width, 20)];
            label.text = @"快去评论有趣新闻吧 ~ ~";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor grayColor];
            [self.view addSubview:label];
            
        }else{
            
            [self initTableView];
            [self.table reloadData];
        }
    }];
}

-(void)initTableView{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, self.view.frame.size.height-64) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.delegate = self;
    self.table.dataSource = self;
//    self.table.separatorStyle = NO;
    [self.view addSubview:self.table];
    self.table.showsHorizontalScrollIndicator = NO;
    self.table.showsVerticalScrollIndicator = NO;
    self.table.tableFooterView = [[UIView alloc] init];
    
    
//    self.table.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//
//        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
//        
//        NSString *key = @"hulijieluolianglvkang015";
//        [parameters setObject:key forKey:@"key"];
//        
//        requestNumber += 1;
//        
//        [parameters setObject:[NSString stringWithFormat:@"%d",requestNumber] forKey:@"requestNumber"];
//        [parameters setObject:[NSString stringWithFormat:@"%d",userId] forKey:@"userId"];
//        
//        
//        NSString *url = @"http://115.29.176.50/interface/getComment.php";
//        RequstData *request=[[RequstData alloc]init];
//        [request requestData:url url:parameters dic:^(NSMutableDictionary*dic){
//            
//            self.array=[dic objectForKey:@"result"];
//            
//            //关闭刷新
//            [self.table.footer endRefreshing];
//            
//            [self.table reloadData];
//            
//        }];
//    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellHeight = self.commentCell.contentView.frame.size.height ;
    
    return cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    tempDic = self.array[indexPath.row];
    
    
    //跳转到详情页
    singleNewView *svc = [[singleNewView alloc]init];
    svc.newsId =[tempDic objectForKey:@"newsId"];
    svc.newsstyleid =[tempDic objectForKey:@"newsStyleId"];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [NSString stringWithFormat:@"TimeLineCell%ld",(long)indexPath.row];
    
    
    self.commentCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (  self.commentCell == nil) {
        self.commentCell = [[CommentMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    

    
    
    
    NSDictionary *tempDic = [self.array objectAtIndex:indexPath.row];
    
    
    NSString *nickname = [tempDic valueForKey:@"userNickname"];
    
    NSString *comment = [tempDic valueForKey:@"commentContent"];
    
    NSString *time = [tempDic valueForKey:@"commentTime"];
    
    NSString *icon = [tempDic valueForKey:@"usericonimg"];
    
    NSString *title = [tempDic valueForKey:@"newsTitle"];
    
    
//    NSLog(@"%@",tempDic);
//    
//    NSLog(@"%@",title);
    
    //非登录
    if ([nickname isEqualToString:@""]) {
        nickname = [NSString stringWithFormat:@"用户%@",[tempDic valueForKey:@"userId"]];
        
    }
    //没有设置头像
    if ([icon isEqualToString:@""]) {
        
        self.commentCell.iconImageView.image = [UIImage imageNamed:@"pic1.jpg"];
    }else{
        
        [self.commentCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://foru.oss-cn-hangzhou.aliyuncs.com/%@",icon]]
         
                                          placeholderImage:[UIImage imageNamed:@"watingImag.png"]];
    }
    
    //剪切子视图
    self.commentCell.iconImageView.clipsToBounds = YES;
    
    
    //获取时间  
    NSDate * nowDate = [NSDate date];
    NSTimeInterval timeStamp= [nowDate timeIntervalSince1970];
    float timeT = [time floatValue];
    //相差多少时间
    int secondsBetweenDates= (int)(timeStamp -  timeT);

    
    //时间相差分钟数
    int min = (secondsBetweenDates / 60);
    
    if (min< 0) {
        
        min = 0 -min;
    }
    
    //计算时间
    
    NSMutableString  *result = [[NSMutableString alloc] initWithString:@""];
    
    if (min<60) {
        if (min==0) {
            result = [NSMutableString stringWithFormat:@"刚刚"];
            
        }else{
            //获得分钟
            result = [NSMutableString stringWithFormat:@"%d分钟前",min];
        }
    }else if (min/60<24)  //获得小时
    {
        result = [NSMutableString stringWithFormat:@"%d小时前",min/60];
    }else if(min/60/24<7){//获得天数
        result = [NSMutableString stringWithFormat:@"%d天前",min/60/24];
        
    }   else if (min/60/24/7<4)//获得周数{
    {
        result = [NSMutableString stringWithFormat:@"%d周前",min/60/24/7];
    }else
        result = [NSMutableString stringWithFormat:@"%d个月前",min/60/24/7/4];
    
    
    self.commentCell.nicknameLabel.text = nickname;
    
    self.commentCell.contentLabel.text = comment;
    
    self.commentCell.timeLabel.text = result;
    self.commentCell.timeLabel.textAlignment = NSTextAlignmentRight;
//    self.commentCell.timeLabel.backgroundColor = [UIColor blackColor];
    
    self.commentCell.title.text = [NSString stringWithFormat:@"原文：%@",title];
//    self.commentCell.title.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.commentCell.nicknameLabel.font = [UIFont systemFontOfSize:12];
    
    self.commentCell.contentLabel.font = [UIFont systemFontOfSize:15];
    
    self.commentCell.timeLabel.font = [UIFont systemFontOfSize:12];
    
//    if (self.commentCell.title.text.length == 0) {
//        
//    }else{
        self.commentCell.title.font = [UIFont systemFontOfSize:12];
//    }

    [self.commentCell.nicknameLabel setTextColor:RGB(145,145,145)];
    
    [self.commentCell.contentLabel setTextColor:RGB(77, 77, 77)];
    
//    self.commentCell.contentLabel.backgroundColor = [UIColor greenColor];
    
    [self.commentCell.timeLabel setTextColor:RGB(145,145,145)];
    
//    [self.commentCell.lines setBackgroundColor:RGB(167, 167, 172)];
    
    [self.commentCell.title setTextColor:RGB(145,145,145)];
    [self.commentCell.title setBackgroundColor:RGB(252,252,252)];
    self.commentCell.layer.cornerRadius = 2;
    
    //设置控件的位置
    [self layoutOfwidget:indexPath.row];

    return  self.commentCell;
}
- (void)layoutOfwidget:(NSInteger)row{
    
    NSDictionary *tempDic = [self.array objectAtIndex:row];
    

    NSString *comment = [tempDic valueForKey:@"commentContent"];
    
    //计算content的高度
    
    
    //    //标题大小重设
    
    CGSize size1 = CGSizeMake(SCREEN_WIDTH  , 10000);//设置在多大区域显示label
    CGSize labelSize1 = [comment sizeWithFont:[UIFont fontWithName:@"ArialMt" size:19] constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];//根据条件计算label的size  text是本地文件内容或者网络接收内容 是字符串
    
    self.commentCell.iconImageView.frame = CGRectMake(5, SCREEN_HEIGHT * 0.01, SCREEN_HEIGHT *0.06,  SCREEN_HEIGHT *0.06);
    self.commentCell.iconImageView.layer.cornerRadius = SCREEN_HEIGHT *0.06/2;
    

    self.commentCell.nicknameLabel.frame = CGRectMake(10+SCREEN_WIDTH * 0.001+self.commentCell.iconImageView.frame.size.width +2,SCREEN_HEIGHT *0.005,  SCREEN_WIDTH * 0.4,SCREEN_HEIGHT *0.04);
    
    
    self.commentCell.timeLabel.frame =  CGRectMake(SCREEN_WIDTH-10-self.commentCell.iconImageView.frame.size.width-self.commentCell.nicknameLabel.frame.size.width,SCREEN_HEIGHT *0.013,  SCREEN_WIDTH * 0.5,SCREEN_HEIGHT *0.02);
    
    
    self.commentCell.title.frame = CGRectMake(10+SCREEN_WIDTH * 0.001+self.commentCell.iconImageView.frame.size.width +2,SCREEN_HEIGHT *0.045,  SCREEN_WIDTH-(10+SCREEN_WIDTH * 0.001+self.commentCell.iconImageView.frame.size.width+2)-10,SCREEN_HEIGHT *0.04);
    
    self.commentCell.contentLabel.frame = CGRectMake(10+SCREEN_WIDTH * 0.001+self.commentCell.iconImageView.frame.size.width +2,self.commentCell.iconImageView.frame.size.height + SCREEN_HEIGHT *0.025, SCREEN_WIDTH -(20+SCREEN_WIDTH * 0.001+self.commentCell.iconImageView.frame.size.width),labelSize1.height);
    

    
//    self.commentCell.contentLabel.backgroundColor = [UIColor redColor];
    
//    self.commentCell.lines.frame = CGRectMake(self.commentCell.contentView.frame.size.height-1,0, SCREEN_WIDTH, 1);
    
    

    
    //测试设背景色
    self.commentCell.favView.backgroundColor = [UIColor grayColor];
    self.commentCell.favView.frame = CGRectMake(SCREEN_WIDTH *0.7, SCREEN_HEIGHT *0.01, SCREEN_WIDTH * 0.28, SCREEN_HEIGHT * 0.06);
    
    self.commentCell.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.commentCell.iconImageView.frame.size.height+self.commentCell.contentLabel.frame.size.height+SCREEN_HEIGHT *0.03);

    
}
-(void)click:(UIButton *)sender{
    if(sender.tag==1){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)deleteAll{
    if (self.array.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"还没有评论~" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        UIAlertController *contoller = [UIAlertController alertControllerWithTitle:nil message:@"确定要清空评论？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self deleteMyCommentNews:userId];
        }];
        [contoller addAction:cancelAction];
        [contoller addAction:otherAction];
        [self presentViewController:contoller animated:YES completion:nil];
    }
}

-(void)deleteMyCommentNews:(int)UserId{
    
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic setValue:[NSString stringWithFormat:@"%d",userId] forKey:@"userId"];
    [tempDic setValue:@"hulijieluolianglvkang015" forKey:@"key"];
    
    DeleteMyCommentNewsService *delete = [[DeleteMyCommentNewsService alloc] init];
    [delete deleteMyComment:tempDic andMessage:^(NSMutableDictionary *success) {
        
        [self.table removeFromSuperview];
        
        [self requestMyCommentNews];
        
    }];
}


@end
