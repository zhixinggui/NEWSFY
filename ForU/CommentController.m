//
//  CommentController.m
//  ForU
//
//  Created by 胡礼节 on 15/10/12.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "CommentController.h"
#import "RequstData.h"
#import "Header.h"
#import "GetCodeNavigationBar.h"

#import "SDWebImage/UIImageView+WebCache.h"
#import "SVProgressHUD.h"


@interface CommentController ()
@property (strong,nonatomic)GetCodeNavigationBar *navBar;
@property (strong,nonatomic)UIImageView *imageView;
@property (strong,nonatomic)NSOperationQueue *queue;
@end

@implementation CommentController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD showProgress:10.0 status:@"正在加载中..."];

    self.array = [[NSArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    NSString *key = @"hulijieluolianglvkang015";
    NSString *table=@"ForUnewscomment";
  
    
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height/10 )];
    self.imageView.image=[UIImage imageNamed:@"top_navigation_background@2x.png"];
    self.imageView.alpha = 0.8;
    [self.view addSubview:self.imageView];
    self.navBar=[[GetCodeNavigationBar alloc]initWithNavBar:@"back" andLabel:@"评论" andBtn:nil];
    self.navBar.backgroundColor=[UIColor clearColor];
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.leftBtn.tag=1;
    [self.view bringSubviewToFront:self.imageView];

    [self.view addSubview:self.navBar];
    
    [self.view bringSubviewToFront:self.navBar];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:key forKey:@"key"];
    [parameters setObject:table forKey:@"table"];
    [parameters setObject:self.newsid forKey:@"newsId"];
    [parameters setObject:self.newsstyleid forKey:@"newsstyleid"];

    
    NSString *url = @"http://115.29.176.50/interface/index.php/Home/ForU/getComment";
    RequstData *request=[[RequstData alloc]init];
    [request requestData:url url:parameters dic:^(NSMutableDictionary*dic){
        self.array=[dic objectForKey:@"result"];
        [SVProgressHUD dismiss];

        if ([[dic valueForKey:@"error_code"] isEqualToString:@"1"]) {
          
            UIAlertView *alert =[ [UIAlertView alloc]initWithTitle:nil message:@"好伤心，暂无评论." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
     


        }else{
            [self initTableView];
            
       
            

        }


    }];

    
   }

-(void)initTableView{

    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0,75, SCREEN_WIDTH, self.view.frame.size.height- 66) style:UITableViewStylePlain];
    self.table.backgroundColor = [UIColor clearColor];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = NO;
    [self.view addSubview:self.table];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellHeight = self.commentCell.contentView.frame.size.height-2;
    
    
    
    
    
    return cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [NSString stringWithFormat:@"TimeLineCell%ld",(long)indexPath.row];
    
    
    self.commentCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    
    if (  self.commentCell == nil) {
        self.commentCell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    NSDictionary *tempDic = [self.array objectAtIndex:indexPath.row];
    
    
    NSString *nickname = [tempDic valueForKey:@"usernickname"];
    
    NSString *comment = [tempDic valueForKey:@"commentcontent"];
    
    NSString *time = [tempDic valueForKey:@"commenttime"];
    
    NSString *icon =[tempDic valueForKey:@"usericonimg"];

    
    if ([nickname isEqualToString:@""]) {
        nickname = [NSString stringWithFormat:@"用户%@",[tempDic valueForKey:@"userid"]];

    }
    if ([icon isEqualToString:@""]) {

        self.commentCell.iconImageView.image = [UIImage imageNamed:@"pic1.jpg"];
    }else{



        [self.commentCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://foru.oss-cn-hangzhou.aliyuncs.com/%@",icon]]
                      placeholderImage:[UIImage imageNamed:@"watingImag.png"]];
        
        
    }
    
    
    self.commentCell.iconImageView.clipsToBounds = YES;

    NSDate * nowDate = [NSDate date];
    NSTimeInterval timeStamp= [nowDate timeIntervalSince1970];
    
    float timeT = [time floatValue];
    
    
    //相差多少时间
    int secondsBetweenDates= (int)(timeStamp -  timeT);
    self.commentCell.jubao.tag = indexPath.row;
    
    //时间相差分钟数
    int min = (secondsBetweenDates / 60);
    
    if (min< 0) {
        
        min = 0 -min;
    }
    
    //计算时间
    

    NSString *result;
    if (min<60) {
        if (min==0) {
            result = @"刚刚";

        }else{
        //获得分钟
        result = [NSString stringWithFormat:@"%d分钟前",min];
        }
    }else if (min/60<24)  //获得小时
    {
        result = [NSString stringWithFormat:@"%d小时前",min/60];
    }else if(min/60/24<7){//获得天数
        result = [NSString stringWithFormat:@"%d天前",min/60/24];
        
    }   else if (min/60/24/7<4)//获得周数{
    {
        result = [NSString stringWithFormat:@"%d周前",min/60/24/7];
    }else
        result = [NSString stringWithFormat:@"%d个月前",min/60/24/7/4];
    
    [self.commentCell.jubao setTitle:@"举报" forState:UIControlStateNormal];
    
    [self.commentCell.jubao setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];

    
    [self.commentCell.jubao addTarget:self action:@selector(ClickaddTagBtn) forControlEvents:UIControlEventTouchUpInside];
    self.commentCell.nicknameLabel.text = nickname;
    
    self.commentCell.contentLabel.text = comment;
    
    self.commentCell.timeLabel.text = result;
    
    self.commentCell.nicknameLabel.font = [UIFont systemFontOfSize:12];
    
    self.commentCell.contentLabel.font = [UIFont systemFontOfSize:15];
    
    self.commentCell.timeLabel.font = [UIFont systemFontOfSize:12];
    
    [self.commentCell.nicknameLabel setTextColor:RGB(167, 167, 172)];
    
    [self.commentCell.contentLabel setTextColor:RGB(42, 54, 68)];
    
    [self.commentCell.timeLabel setTextColor:RGB(167, 167, 172)];


    
    
    
    //设置控件的位置
    [self layoutOfwidget:indexPath.row];

    return   self.commentCell;
}
- (void)layoutOfwidget:(NSInteger)row{
    
    NSDictionary *tempDic = [self.array objectAtIndex:row];
    
    
    
    
    NSString *comment = [tempDic valueForKey:@"commentcontent"];
    
    //计算content的高度
    
    
    //    //标题大小重设
    
    CGSize size1 = CGSizeMake(SCREEN_WIDTH  , 10000);//设置在多大区域显示label
    CGSize labelSize1 = [comment sizeWithFont:[UIFont fontWithName:@"ArialMt" size:19] constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];//根据条件计算label的size  text是本地文件内容或者网络接收内容 是字符串
    
    
    self.commentCell.iconImageView.frame = CGRectMake(5, SCREEN_HEIGHT * 0.01, SCREEN_HEIGHT *0.06,  SCREEN_HEIGHT *0.06);
    self.commentCell.iconImageView.layer.cornerRadius = SCREEN_HEIGHT *0.06/2;
    
    
    
    
    self.commentCell.nicknameLabel.frame = CGRectMake(10+SCREEN_WIDTH * 0.001+self.commentCell.iconImageView.frame.size.width +2,SCREEN_HEIGHT *0.005,  SCREEN_WIDTH * 0.4,SCREEN_HEIGHT *0.04);
    
    
    self.commentCell.timeLabel.frame =  CGRectMake(10+SCREEN_WIDTH * 0.001+self.commentCell.iconImageView.frame.size.width +2 ,SCREEN_HEIGHT *0.045,  SCREEN_WIDTH * 0.4,SCREEN_HEIGHT *0.02);
    
    
    
    self.commentCell.contentLabel.frame = CGRectMake(10+SCREEN_WIDTH * 0.001+self.commentCell.iconImageView.frame.size.width +2,self.commentCell.iconImageView.frame.size.height, SCREEN_WIDTH -(15+SCREEN_WIDTH * 0.001+self.commentCell.iconImageView.frame.size.width),labelSize1.height+2+self.commentCell.iconImageView.frame.size.height);
    
    
    self.commentCell.lines.frame = CGRectMake(self.commentCell.contentView.frame.size.height-1,0, SCREEN_WIDTH, 1);
    self.commentCell.jubao.frame =  CGRectMake(SCREEN_WIDTH *0.8, SCREEN_HEIGHT *0.01, SCREEN_WIDTH * 0.18, SCREEN_HEIGHT * 0.06);
    
    

    
    //测试设背景色
    self.commentCell.favView.backgroundColor = [UIColor grayColor];
    self.commentCell.favView.frame = CGRectMake(SCREEN_WIDTH *0.7, SCREEN_HEIGHT *0.01, SCREEN_WIDTH * 0.28, SCREEN_HEIGHT * 0.06);
    
    self.commentCell.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.commentCell.iconImageView.frame.size.height+self.commentCell.contentLabel.frame.size.height);
    
}
-(void)click:(UIButton *)sender{
    if(sender.tag==1){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSOperationQueue *)queue {
    if (!_queue) _queue = [[NSOperationQueue alloc] init];
    return _queue;
}
#pragma mark - 点击添加标签按钮
- (void)ClickaddTagBtn{
    
    //添加黑色背景
    self.addTagBackView = [[UIView alloc]initWithFrame:self.view.frame];
    
    [self.addTagBackView setBackgroundColor:RGBAA(0, 0, 0, 0.3)];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickaddtagBackView)];
    
    [self.addTagBackView addGestureRecognizer:recognizer];
    
    
    
    //标签的内容背景
    self.tagContentView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.0625, 0.35 *SCREEN_HEIGHT, 0.875 * SCREEN_WIDTH, 0.185 * SCREEN_HEIGHT)];
    
    [self.tagContentView setBackgroundColor:[UIColor whiteColor]];
    
    //设置圆角
    self.tagContentView.layer.cornerRadius = 5;
    
    
    /*低俗骚扰*/
    self.annoyTag = [[UIButton alloc]init];
    [self.annoyTag setTitle:@"低俗骚扰" forState:UIControlStateNormal];
    [self.annoyTag setTitleColor:RGB(42, 54, 68) forState:UIControlStateNormal];
    self.annoyTag.titleLabel.font =[UIFont systemFontOfSize:15];
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:@"低俗骚扰" attributes:@{ NSFontAttributeName: self.commentCell.contentLabel.font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){self.annoyTag.frame.size.width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    [self.annoyTag setFrame:CGRectMake(0.053 * SCREEN_WIDTH, 0.03125 *SCREEN_HEIGHT, ceilf(rect.size.width) + 0.04 * SCREEN_WIDTH, 30)];
    self.annoyTag.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.annoyTag.layer.borderWidth = 1.0;
    self.annoyTag.layer.cornerRadius = 15;
    [self.annoyTag addTarget:self action:@selector(ClickexitAddTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    /*色情暴力*/
    self.forceTag = [[UIButton alloc]init];
    [self.forceTag setTitle:@"色情暴力" forState:UIControlStateNormal];
    [self.forceTag setTitleColor:RGB(42, 54, 68) forState:UIControlStateNormal];
    self.forceTag.titleLabel.font =[UIFont systemFontOfSize:15];
    [self.addTagBackView addSubview:self.forceTag];
    NSAttributedString *attributedText1 = [[NSAttributedString alloc] initWithString:@"色情暴力" attributes:@{ NSFontAttributeName: self.commentCell.contentLabel.font}];
    CGRect rect1 = [attributedText1 boundingRectWithSize:(CGSize){self.annoyTag.frame.size.width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    [self.forceTag setFrame:CGRectMake(0.03125 * SCREEN_WIDTH + ceilf(rect.size.width) + 0.12 *SCREEN_WIDTH, 0.03125 *SCREEN_HEIGHT, ceilf(rect1.size.width) + 0.04 *SCREEN_WIDTH, 30)];
    self.forceTag.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.forceTag.layer.borderWidth = 1.0;
    self.forceTag.layer.cornerRadius = 15;
    [self.forceTag addTarget:self action:@selector(ClickexitAddTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    /*虚假信息*/
    self.falseInfoTag = [[UIButton alloc]init];
    [self.falseInfoTag setTitle:@"虚假信息" forState:UIControlStateNormal];
    [self.falseInfoTag setTitleColor:RGB(42, 54, 68) forState:UIControlStateNormal];
    self.falseInfoTag.titleLabel.font =[UIFont systemFontOfSize:15];
    [self.addTagBackView addSubview:self.forceTag];
    NSAttributedString *attributedTextfalseInfoTag = [[NSAttributedString alloc] initWithString:@"虚假信息" attributes:@{ NSFontAttributeName: self.commentCell.contentLabel.font}];
    CGRect rectfalseInfoTag = [attributedTextfalseInfoTag boundingRectWithSize:(CGSize){self.falseInfoTag.frame.size.width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    [self.falseInfoTag setFrame:CGRectMake(self.forceTag.frame.origin.x + ceil(rect1.size.width) + 0.12 *SCREEN_WIDTH, 0.03125 *SCREEN_HEIGHT, ceilf(rectfalseInfoTag.size.width) + 0.04 *SCREEN_WIDTH, 30)];
    self.falseInfoTag.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.falseInfoTag.layer.borderWidth = 1.0;
    self.falseInfoTag.layer.cornerRadius = 15;
    [self.falseInfoTag addTarget:self action:@selector(ClickexitAddTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    /*人身攻击*/
    self.attackTag = [[UIButton alloc]init];
    [self.attackTag setTitle:@"人身攻击" forState:UIControlStateNormal];
    [self.attackTag setTitleColor:RGB(42, 54, 68) forState:UIControlStateNormal];
    self.attackTag.titleLabel.font =[UIFont systemFontOfSize:15];
    [self.addTagBackView addSubview:self.attackTag];
    
    NSAttributedString *attributedText2 = [[NSAttributedString alloc] initWithString:@"人身攻击" attributes:@{ NSFontAttributeName: self.commentCell.contentLabel.font}];
    CGRect rect2 = [attributedText2 boundingRectWithSize:(CGSize){self.attackTag.frame.size.width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    [self.attackTag setFrame:CGRectMake(0.053 * SCREEN_WIDTH, 0.03125 *2  *SCREEN_HEIGHT + 30 , ceilf(rect2.size.width) + 0.04 * SCREEN_WIDTH, 30)];
    self.attackTag.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.attackTag.layer.borderWidth = 1.0;
    self.attackTag.layer.cornerRadius = 15;
    [self.attackTag addTarget:self action:@selector(ClickexitAddTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    /*广告*/
    self.advertisementTag = [[UIButton alloc]init];
    [self.advertisementTag setTitle:@"广告" forState:UIControlStateNormal];
    [self.advertisementTag setTitleColor:RGB(42, 54, 68) forState:UIControlStateNormal];
    self.advertisementTag.titleLabel.font =[UIFont systemFontOfSize:15];
    [self.addTagBackView addSubview:self.advertisementTag];
    
    NSAttributedString *attributedText3 = [[NSAttributedString alloc] initWithString:@"广告" attributes:@{ NSFontAttributeName: self.commentCell.contentLabel.font}];
    CGRect rect3 = [attributedText3 boundingRectWithSize:(CGSize){self.advertisementTag.frame.size.width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    [self.advertisementTag setFrame:CGRectMake(self.attackTag.frame.origin.x + ceil(rect2.size.width) + 0.08 *SCREEN_WIDTH, self.attackTag.frame.origin.y, ceilf(rect3.size.width) + 0.08 *SCREEN_WIDTH, 30)];
    self.advertisementTag.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.advertisementTag.layer.borderWidth = 1.0;
    self.advertisementTag.layer.cornerRadius = 15;
    [self.advertisementTag addTarget:self action:@selector(ClickexitAddTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    /*违反法律规定*/
    self.breakLawTag = [[UIButton alloc]init];
    [self.breakLawTag setTitle:@"违反法律规定" forState:UIControlStateNormal];
    [self.breakLawTag setTitleColor:RGB(42, 54, 68) forState:UIControlStateNormal];
    self.breakLawTag.titleLabel.font =[UIFont systemFontOfSize:15];
    [self.addTagBackView addSubview:self.breakLawTag];
    
    NSAttributedString *attributedTextbreakLawTag = [[NSAttributedString alloc] initWithString:@"违反法律规定" attributes:@{ NSFontAttributeName: self.commentCell.contentLabel.font}];
    CGRect rectbreakLawTag = [attributedTextbreakLawTag boundingRectWithSize:(CGSize){self.breakLawTag.frame.size.width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    [self.breakLawTag setFrame:CGRectMake(self.advertisementTag.frame.origin.x + ceil(rect3.size.width) + 0.12 *SCREEN_WIDTH, self.advertisementTag.frame.origin.y, ceilf(rectbreakLawTag.size.width) + 0.08 *SCREEN_WIDTH, 30)];
    self.breakLawTag.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.breakLawTag.layer.borderWidth = 1.0;
    self.breakLawTag.layer.cornerRadius = 15;
    [self.breakLawTag addTarget:self action:@selector(ClickexitAddTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tagContentView addSubview:self.exitAddTagBtn];
    
    
    
    [UIView animateWithDuration:2 animations:^{
        
        [self.view addSubview:self.addTagBackView];
        
        [self.tagContentView addSubview: self.annoyTag];
        
        [self.tagContentView addSubview: self.forceTag];
        
        [self.tagContentView addSubview: self.falseInfoTag];
        
        [self.tagContentView addSubview: self.attackTag];
        
        [self.tagContentView addSubview: self.advertisementTag];
        
        [self.tagContentView addSubview: self.breakLawTag];
    }];
    
    [self.view addSubview:self.tagContentView];
    
}


#pragma mark - 点击背景
- (void)ClickaddtagBackView{
    
    
    self.theAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view]; //参照视图
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.tagContentView]];
    
    gravityBehavior.magnitude = 5;
    
    [self.theAnimator addBehavior:gravityBehavior];
    
    [self.tagContentView performSelector:@selector(removeFromSuperview) withObject:self.tagContentView afterDelay:0.6];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(setdarkViewalpha) userInfo:nil repeats:NO];
    
    
}


#pragma mark - 点击标签
- (void)ClickexitAddTagBtn:(UIButton *)sender{

    
    
    if (sender.tag != 1) {
        
        sender.layer.borderColor = [UIColor redColor].CGColor;
        
        
        
        
        
//        CommentTableViewCell* cell=[[CommentTableViewCell alloc]init];
//        cell = (CommentTableViewCell*)[[sender superview] superview];
//        //获取table
//        UITableView* table=(UITableView*)[cell superview];
//        //获取table的indexpath
//        NSIndexPath* index=[table indexPathForCell:cell];
        
        
        
        NSDictionary *tempDic = [self.array objectAtIndex:sender.tag];
        
        
        NSString *userId = [tempDic valueForKey:@"newsid"];
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:userId forKey:@"userId"];
        [parameters setObject:self.newsid   forKey:@"newsId"];
    

        [parameters setObject:self.newsstyleid   forKey:@"newsStyleId"];
        

        


            
            

            
       
                
                
                
                
        

        NSString *url = @"http://115.29.176.50/interface/deleteFootPrint.php";
        RequstData *request=[[RequstData alloc]init];
        [request requestData:url url:parameters dic:^(NSMutableDictionary*dic){
            
            UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-15, 100, 30)];
            la.textColor = [UIColor whiteColor];
            la.textAlignment = NSTextAlignmentCenter;
            la.backgroundColor = [UIColor lightGrayColor ];
            la.text = @"举报成功";
            [self.view addSubview:la];
            [UIView animateWithDuration:2 animations:^(void){
                la.alpha = 0;
            }];
            
            
        
        
        }];
    }

    
    self.theAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view]; //参照视图
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.tagContentView]];
    
    gravityBehavior.magnitude = 5;
    
    [self.theAnimator addBehavior:gravityBehavior];
    
    [self.tagContentView performSelector:@selector(removeFromSuperview) withObject:self.tagContentView afterDelay:0.6];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(setdarkViewalpha) userInfo:nil repeats:NO];
    
    
}- (void)setdarkViewalpha{
    
    [self.addTagBackView setHidden:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
