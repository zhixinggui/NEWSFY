//
//  HLJViewLayout.h
//  HorizontalScroller
//
//  Created by 胡礼节 on 15/11/4.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, HJCarouselAnim) {
    HJCarouselAnimLinear,
    HJCarouselAnimRotary,
    HJCarouselAnimCarousel,
    HJCarouselAnimCarousel1,
    HJCarouselAnimCoverFlow,
};

@interface HLJViewLayout : UICollectionViewLayout

- (instancetype)initWithAnim:(HJCarouselAnim)anim;

@property (readonly)  HJCarouselAnim carouselAnim;

@property (nonatomic) CGSize itemSize;
@property (nonatomic) NSInteger visibleCount;
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;


@end
