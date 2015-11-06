//
//  PopoverView2.m
//  ForU
//
//  Created by administrator on 15/10/19.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "PopoverView2.h"

#define ArrowHeight 10.f    //箭头高度
#define ArrowCurvature 6.f    //曲率
#define SPACE 2.f
#define ROW_HEIGHT 44.f      //行高
#define TITLE_FONT [UIFont systemFontOfSize:16]
#define RGB(r, g, b)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]

@interface PopoverView2 ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic) CGPoint showPoint;

@property (nonatomic, strong) UIButton *handerView;

@property(assign,nonatomic)NSInteger flag;

@end

@implementation PopoverView2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.borderColor = RGB(200, 199, 204);
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images
{
    self = [super init];
    if (self) {
        self.showPoint = point;
        self.titleArray = titles;
        self.imageArray = images;
        
        self.frame = [self getViewFrame];
        
        [self addSubview:self.tableView];
        
    }
    return self;
}

-(CGRect)getViewFrame
{
    CGRect frame = CGRectZero;
    
    frame.size.height = [self.titleArray count] * ROW_HEIGHT + SPACE + ArrowHeight;
    
//    for (NSString *title in self.titleArray) {
//        CGFloat width = [title sizeWithFont:TITLE_FONT constrainedToSize:CGSizeMake(300, 100) lineBreakMode:NSLineBreakByCharWrapping].width;
//        frame.size.width = MAX(width, frame.size.width);
//    }
//    
//    
//    if ([self.titleArray count] == [self.imageArray count]) {
//        frame.size.width = 10 + 40 + 10 + frame.size.width + 40;
//    }else{
//        frame.size.width = 10 + frame.size.width + 40;
//    }
    frame.size.width = 300;
    
    frame.origin.x = self.showPoint.x - frame.size.width/2;
    frame.origin.y = self.showPoint.y;
    
    //左间隔最小5x
//    if (frame.origin.x < 5) {
//        frame.origin.x = 5;
//    }
//    //右间隔最小5x
//    if ((frame.origin.x + frame.size.width) > 315) {
//        frame.origin.x = 315 - frame.size.width;
//    }
    
    return frame;
}


-(void)show
{
    self.handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_handerView setFrame:[UIScreen mainScreen].bounds];
    [_handerView setBackgroundColor:[UIColor clearColor]];
    [_handerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:self];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:_handerView];
    
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    self.layer.anchorPoint = CGPointMake(arrowPoint.x / self.frame.size.width, arrowPoint.y / self.frame.size.height);
    self.frame = [self getViewFrame];
    
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:1.0f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}

-(void)dismiss
{
    [self dismiss:YES];
    self.flag = 1;
}

-(void)dismiss:(BOOL)animate
{
    if (!animate) {
        [_handerView removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [_handerView removeFromSuperview];
    }];
    
}


#pragma mark - UITableView

-(UITableView *)tableView
{
    if (_tableView != nil) {
        return _tableView;
    }
    
    CGRect rect = self.frame;
    rect.origin.x = SPACE;
    rect.origin.y = ArrowHeight + SPACE;
    rect.size.width -= SPACE * 2;
    rect.size.height -= (SPACE - ArrowHeight);
    
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alwaysBounceHorizontal = NO;
    _tableView.alwaysBounceVertical = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = [UIColor clearColor];

    //    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    return _tableView;
}

#pragma mark - UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
        return [_titleArray count];
//    }else{
//        return 1;
//    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _titleArray.count-1) {
        PopoverTableViewCell *cell = [[PopoverTableViewCell alloc] init];
        cell.label.text = [_titleArray lastObject];
        cell.label.textColor = [UIColor colorWithRed:116/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return cell;
    }else{
        static NSString *identifier = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        //    if ([_imageArray count] == [_titleArray count]) {
        //        cell.imageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
        //    }
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.text = [_titleArray objectAtIndex:indexPath.row];
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        return cell;
    }
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectRowAtIndex) {
        self.selectRowAtIndex(indexPath.row);
    }
    [self dismiss:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;
}

- (void)drawRect:(CGRect)rect
{
    [self.borderColor set]; //设置线条颜色
    
    CGRect frame = CGRectMake(0, 10, self.bounds.size.width, self.bounds.size.height - ArrowHeight);
    
    float xMin = CGRectGetMinX(frame);
    float yMin = CGRectGetMinY(frame);
    
    float xMax = CGRectGetMaxX(frame);
    float yMax = CGRectGetMaxY(frame);
    
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    
    UIBezierPath *popoverPath = [UIBezierPath bezierPath];
    [popoverPath moveToPoint:CGPointMake(xMin, yMin)];//左上角
    
    /********************向上的箭头**********************/
    [popoverPath addLineToPoint:CGPointMake(arrowPoint.x - ArrowHeight, yMin)];//left side
    [popoverPath addCurveToPoint:arrowPoint
                   controlPoint1:CGPointMake(arrowPoint.x - ArrowHeight + ArrowCurvature, yMin)
                   controlPoint2:arrowPoint];//actual arrow point

    [popoverPath addCurveToPoint:CGPointMake(arrowPoint.x + ArrowHeight, yMin)
                   controlPoint1:arrowPoint
                   controlPoint2:CGPointMake(arrowPoint.x + ArrowHeight - ArrowCurvature, yMin)];//right side
    /********************向上的箭头**********************/
    
    
    [popoverPath addLineToPoint:CGPointMake(xMax, yMin)];//右上角
    
    [popoverPath addLineToPoint:CGPointMake(xMax, yMax)];//右下角
    
    [popoverPath addLineToPoint:CGPointMake(xMin, yMax)];//左下角
    
    //填充颜色
    [RGB(245, 245, 245) setFill];
    [popoverPath fill];
    
    [popoverPath closePath];
    [popoverPath stroke];
}
@end
