//
//  PopoverView.h
//  AlertTest
//
//  Created by administrator on 15/10/12.
//  Copyright © 2015年 Or_luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopoverView : UIView

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images;
-(void)show;
-(void)dismiss;
-(void)dismiss:(BOOL)animated;

@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);

@end
