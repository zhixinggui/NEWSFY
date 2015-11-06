//
//  MenuViewController.m
//  ForU
//
//  Created by administrator on 15/9/22.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "MenuViewController.h"
#import "UserViewController.h"
#import "CollectionViewController.h"
#import "FootPrintViewController.h"
#import "SearchViewController.h"
#import "SetViewController.h"
#import "CommentViewController.h"
#import "OperateDatabase.h"
#import "ChooseLoginViewController.h"
#import "RequstLocalData.h"
#import "Header.h"
#import "AppDelegate.h"
#import "ChooseLoginViewController.h"
@interface MenuViewController ()

@property(strong,nonatomic)UITapGestureRecognizer *tapRecognizer;
@property (strong,nonatomic)UIView *menuView;
@property(strong,nonatomic)UIImageView *collectionImage,*footprintImage,*messageImage,*searchImage,*setImage,*modeImage;
@property(strong,nonatomic)UILabel *nameLabel;
@property (strong,nonatomic)UIButton *portraitBtn, *collectionBtn,*footprintBtn,*messageBtn,*searchBtn,*setBtn,*modeBtn;
@property (strong,nonatomic)UIImageView *imageView;

@property(strong,nonatomic)UITableView *MenuTableView;
@property(strong,nonatomic)NSMutableDictionary *headerDic;


@end

@implementation MenuViewController{
    UIButton *rightBtn;
    NSInteger userId;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    RequstLocalData *request = [[RequstLocalData alloc] init];
    userId = [[[request requestLocalInfo] valueForKey:@"userid"] intValue] ;

}
- (void)viewWillAppear:(BOOL)animated{
    self.headerDic = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [UIColor clearColor];
    [self initView];
}
-(void)initView{

    
        //侧边栏的内容View
    self.menuView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*3/5, self.view.frame.size.height)];
    self.menuView.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.2];
    
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0 , self.menuView.frame.size.width,self.view.frame.size.height )];
    self.imageView.image=[UIImage imageNamed:@"background"];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.menuView];
    rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*3/5, 0, SCREEN_WIDTH*2/5, self.view.frame.size.height)];
    rightBtn.backgroundColor = [UIColor clearColor];
    [rightBtn addTarget:self action:@selector(closeMenuView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];

    //头像按钮
    self.portraitBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.menuView.frame.size.width/3, self.menuView.frame.size.height*50/667,self.menuView.frame.size.width/3 , self.menuView.frame.size.width/3)];
    self.portraitBtn.layer.masksToBounds=YES;
    self.portraitBtn.layer.cornerRadius=self.menuView.frame.size.width/6;
    [self.portraitBtn addTarget:self action:@selector(portraitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:self.portraitBtn];
    
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, self.menuView.frame.size.height*135/667,self.menuView.frame.size.width  , self.menuView.frame.size.height*30/667)];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.nameLabel setTextAlignment:NSTextAlignmentCenter];
    [self.menuView addSubview:self.nameLabel];
    
    OperateDatabase *check = [[OperateDatabase alloc] init];
    if (check.click == YES) {//空
        //默认头像
        [self.portraitBtn setBackgroundImage:[UIImage imageNamed:@"未登录"] forState:UIControlStateNormal];
        self.nameLabel.text=@"未登录";
    }else{  //有值
        RequstLocalData *requestHeader = [[RequstLocalData alloc] init];
        self.headerDic = [requestHeader requestLocalInfo];
        
        NSString *header = [self.headerDic objectForKey:@"icon"];
        NSString *nickName = [self.headerDic objectForKey:@"nickName"];
        
        if (header.length == 0) {
            //默认头像
            [self.portraitBtn setBackgroundImage:[UIImage imageNamed:@"pic1.jpg"] forState:UIControlStateNormal];
        }else{
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
            
            NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:header];   // 保存文件的名称
            
            
            UIImage *img = [UIImage imageWithContentsOfFile:filePath];
            [self.portraitBtn setBackgroundImage:img forState:UIControlStateNormal];
        }
        
        if (nickName.length == 0) {
            self.nameLabel.text=@"U";
        }else{
            self.nameLabel.text=nickName;
        }
        self.nameLabel.textColor = [UIColor whiteColor];
    }
    
    
        _MenuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.portraitBtn.frame.size.height+self.nameLabel.frame.size.height+self.menuView.frame.size.height*50/667+20, SCREEN_WIDTH*3/5, self.view.frame.size.height-150) style:UITableViewStylePlain];
    _MenuTableView.showsVerticalScrollIndicator = NO;
    _MenuTableView.showsHorizontalScrollIndicator = NO;
    _MenuTableView.dataSource=self;
    _MenuTableView.delegate=self;
    _MenuTableView.tableFooterView = [[UIView alloc] init];
    _MenuTableView.backgroundView.backgroundColor = [UIColor clearColor];
    _MenuTableView.backgroundColor = [UIColor clearColor];
    _MenuTableView.separatorStyle = NO;
    _MenuTableView.bounces = NO;
    [self.menuView addSubview:_MenuTableView];

}

//UITableView协议实现
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str=@"table";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"收藏"];
        cell.textLabel.text = @"收藏";
    }else if (indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:@"足迹"];
        cell.textLabel.text = @"足迹";
    }else if (indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:@"搜索"];
        cell.textLabel.text = @"搜索";
    }else if (indexPath.row == 3){
        cell.imageView.image = [UIImage imageNamed:@"评论"];
        cell.textLabel.text = @"评论";
    }else{
        cell.imageView.image = [UIImage imageNamed:@"设置"];
        cell.textLabel.text = @"设置";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    [cell setTintColor:[UIColor redColor]];
    return cell;
}
-(void)portraitAction{
    OperateDatabase *operate=[[OperateDatabase alloc]init];
    [operate check];
    if(operate.click==YES){
        ChooseLoginViewController *clvc=[[ChooseLoginViewController alloc]init];
        [self.navigationController pushViewController:clvc animated:YES];

    }
    else{
        UserViewController *uvc=[[UserViewController alloc]init];
         [self.navigationController pushViewController:uvc animated:YES];

    }
}
//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        
        if (userId) {
            CollectionViewController *cvc=[[CollectionViewController alloc]init];
            [self.navigationController pushViewController:cvc animated:YES];
        }else{
            ChooseLoginViewController *clcv = [[ChooseLoginViewController alloc] init];
            [self.navigationController pushViewController:clcv animated:YES];
        }

    }else if (indexPath.row == 1){
        
        if (userId) {
            FootPrintViewController *fvc=[[FootPrintViewController alloc]init];
            [self.navigationController pushViewController:fvc animated:YES];
        }else{
            ChooseLoginViewController *clcv = [[ChooseLoginViewController alloc] init];
            [self.navigationController pushViewController:clcv animated:YES];
        }
        

    }else if (indexPath.row == 2){
        SearchViewController *svc=[[SearchViewController alloc]init];

         [self.navigationController pushViewController:svc animated:YES];
    }else if (indexPath.row == 3){
        
        if (userId) {
            CommentViewController *cvc = [[CommentViewController alloc] init];
            [self.navigationController pushViewController:cvc animated:YES];
        }else{
            ChooseLoginViewController *clcv = [[ChooseLoginViewController alloc] init];
            [self.navigationController pushViewController:clcv animated:YES];
        }
        
    
    }else{

        SetViewController *vc=[[SetViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height/10;
}


-(void)viewDidDisappear:(BOOL)animated{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.center = CGPointMake(-SCREEN_WIDTH/2, self.view.frame.size.height/2);
    } completion:^(BOOL finished) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)closeMenuView{//点击右边返回按钮
    [UIView animateWithDuration:0.5 animations:^{
        self.view.center = CGPointMake(-SCREEN_WIDTH/2, self.view.frame.size.height/2);
        self.tabBarController.tabBar.alpha  = 1;

    } completion:^(BOOL finished) {
    }];
}


@end
