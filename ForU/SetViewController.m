//
//  SetViewController.m
//  ForU
//
//  Created by administrator on 15/9/23.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "SetViewController.h"
#import "MenuNavigationBar.h"
#import "HomeViewController.h"
#import "OperateDatabase.h"
#import "ChooseLoginViewController.h"
#import "RequstLocalData.h"
@interface SetViewController ()
@property(strong,nonatomic)GetCodeNavigationBar *navBar;
@property(strong,nonatomic)UITableView *table;

@property(strong,nonatomic)NSString *cache;

@property(strong,nonatomic)UIActivityIndicatorView *activity;
@property (nonatomic,strong)NSTimer *timer;

@property (nonatomic,strong)CustomButton *CustomButton;
@property (nonatomic,strong)UIView *CustomView;
@property (nonatomic,strong)NSTimer *showTimer;

@end

@implementation SetViewController{
    int jiT;
    NSInteger userId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    RequstLocalData *request = [[RequstLocalData alloc] init];
    userId = [[[request requestLocalInfo] valueForKey:@"userid"] intValue] ;

    [self initView];
}
-(void)initView{
    self.navBar = [[GetCodeNavigationBar alloc] initWithNavBar:@"返回" andLabel:@"设置" andBtn:nil];
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.backgroundColor=[UIColor colorWithRed:195/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:self.navBar];
    
    
    self.table = [[UITableView alloc] init];
    self.table.frame = CGRectMake(0, self.navBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.tableFooterView = [[UIView alloc] init];
    self.table.bounces = NO;
    [self.view addSubview:self.table];
    [self.table reloadData];
    
//    self.FontArray = @[@"正常",@"小字号",@"大字号"];

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 2;
    }else{
        return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SettingTableViewCell *cell = [[SettingTableViewCell alloc]init];
        cell.label.text = @"正文字号";
//        cell.labelDetail.text = self.FontArray[self.flag];
        cell.image.image = [UIImage imageNamed:@"字体"];
        return cell;
    }else if (indexPath.section == 1){
        SettingTableViewCell *cell = [[SettingTableViewCell alloc]init];
        cell.label.text = @"清除缓存";
        cell.image.image = [UIImage imageNamed:@"清除"];
        NSArray *paths= NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString*path = [paths lastObject];
        cell.labelDetail.text = [NSString stringWithFormat:@"%.1fM", [self folderSizeAtPath:path]];
        return cell;
    }else if (indexPath.section == 2){
        SsttingTableViewCell2 *cell = [[SsttingTableViewCell2 alloc]init];
        if (indexPath.row == 0){
            cell.label.text = @"意见反馈";
            cell.image.image = [UIImage imageNamed:@"反馈"];
        }else{
            cell.label.text = @"关于ForU";
            cell.image.image = [UIImage imageNamed:@"关于"];
        }
        cell.image2.image = [UIImage imageNamed:@"箭头"];
        return cell;
    }else{
        SettingTableViewCell3 *cell = [[SettingTableViewCell3 alloc] init];
        cell.label.text = @"退出登录";
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        SettingTableViewCell *cell = [[SettingTableViewCell alloc] init];
        return self.view.frame.size.height - self.navBar.frame.size.height- cell.frame.size.height*5 - 25*3;
    }else{
        return 25;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
    }else if (indexPath.section == 1){
        
        NSArray *paths= NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString*path = [paths lastObject];
        
        UIAlertController *contoller = [UIAlertController alertControllerWithTitle:nil message: [NSString stringWithFormat:@"缓存大小为%.1fM，是否清理缓存", [self folderSizeAtPath:path]] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            
            NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
            for (NSString *str in files) {
                NSError* error;
                NSString* path_ = [path stringByAppendingPathComponent:str];
                if ([[NSFileManager defaultManager] fileExistsAtPath:path_]) {
                    //清理缓存
                    [[NSFileManager defaultManager] removeItemAtPath:path_ error:&error];
                }
            }
            [self.table reloadData];
        }];
        [contoller addAction:cancelAction];
        [contoller addAction:otherAction];
        [self presentViewController:contoller animated:YES completion:nil];
    
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            FeedbackViewController *FeedbackView = [[FeedbackViewController alloc] init];
            [self presentViewController:FeedbackView animated:YES completion:^{
            }];
        }else{
            AboutForUViewController *AboutForU = [[AboutForUViewController alloc] init];
            [self presentViewController:AboutForU animated:YES completion:^{
            }];
        }
    }else{
        
        if (userId) {
            OperateDatabase *operate = [[OperateDatabase alloc] init];
            [operate deleteData];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ChooseLoginViewController *clcv = [[ChooseLoginViewController alloc] init];
            [self.navigationController pushViewController:clcv animated:YES];
        }

    }
}

-(void)Clicked{
    CGPoint point = CGPointMake(self.view.frame.size.width/2,self.navBar.frame.size.height+145);
    NSArray *titles = @[@"组长:胡礼节", @"组员:吕康", @"组员:骆亮"];
//    NSArray *images = @[];
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:titles images:nil];
    pop.selectRowAtIndex = ^(NSInteger index){
    };
    [pop show];
}

-(void)click:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}




//缓存计算
-(long long)fileSizeAtPath:(NSString*)filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
-(float)folderSizeAtPath:(NSString*)folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject])!=nil) {
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
