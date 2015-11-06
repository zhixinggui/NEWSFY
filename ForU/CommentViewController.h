//
//  CommentViewController.h
//  ForU
//
//  Created by administrator on 15/11/2.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetCodeNavigationBar.h"
#import "RequstData.h"
#import "SVProgressHUD.h"
#import "Header.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "RequstLocalData.h"
#import "CommentMenuTableViewCell.h"
#import "singleNewView.h"
#import "MJRefresh.h"
#import "DeleteMyCommentNewsService.h"

@interface CommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,copy)NSArray *array;
@property (nonatomic,copy)NSString  *newsstyleid;
@property (nonatomic,copy)NSString  *newsid;
@property (nonatomic,strong)UITableView  *table;
@property (nonatomic,strong)CommentMenuTableViewCell *commentCell;
@property (strong,nonatomic)GetCodeNavigationBar *navBar;
@property (strong,nonatomic)UIImageView *imageView;

@end
