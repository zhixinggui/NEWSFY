//
//  CustomButton.m
//  ParticleButton
//
//  Created by FYZH on 14-2-22.
//  Copyright (c) 2014年 Liang HaiHu. All rights reserved.
//

#import "CustomButton.h"
#import "EmitterView.h"
@implementation CustomButton
{
    CAEmitterLayer *fireEmitter; //1
    UIView *emitterView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        self.backgroundColor = [UIColor clearColor];
        [self setTitle:@"正在努力加载中···" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        
        emitterView = [[EmitterView alloc] initWithFrame:CGRectZero];
        [self addSubview:emitterView];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)drawRect:(CGRect)rect
{
    //绘制路径
    CGMutablePathRef path = CGPathCreateMutable();
    //创建用于转移坐标的Transform，这样我们不用按照实际显示做坐标计算
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
    //创建CGMutablePathRef

    CGPathAddArc(path, &transform,  self.frame.size.width/2, self.frame.size.height/2,self.frame.size.height/2, 0, 2*M_PI, NO);

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 1.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    animation.repeatCount = MAXFLOAT;
    animation.path = path;
    [emitterView.layer addAnimation:animation forKey:@"test"];
    
    
}


@end
