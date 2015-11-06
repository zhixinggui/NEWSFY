//
//  CommentController.h
//  ForU
//
//  Created by 胡礼节 on 15/10/12.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentTableViewCell.h"

@interface CommentController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,copy)NSArray *array;
@property (nonatomic,copy)NSString  *newsstyleid;
@property (nonatomic,copy)NSString  *newsid;
@property (nonatomic,strong)UITableView  *table;
@property (nonatomic,strong)CommentTableViewCell *commentCell;

//添加标签
@property (strong,nonatomic) UIView *addTagBackView;

@property (strong,nonatomic) UIView *tagContentView;

/*低俗骚扰*/
@property (strong,nonatomic) UIButton *annoyTag;

/*色情暴力*/
@property (strong,nonatomic) UIButton *forceTag;

/*人身攻击*/
@property (strong,nonatomic) UIButton *attackTag;

/*广告*/
@property (strong,nonatomic) UIButton *advertisementTag;

/*虚假信息*/
@property (strong,nonatomic) UIButton *falseInfoTag;

/*违反法律规定*/
@property (strong,nonatomic) UIButton *breakLawTag;
@property (strong,nonatomic) UIDynamicAnimator *theAnimator;

@property (strong,nonatomic) NSTimer *timer;
@property (strong,nonatomic) UIButton *exitAddTagBtn;
@end
