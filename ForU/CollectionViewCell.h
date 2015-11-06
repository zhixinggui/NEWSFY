//
//  CollectionViewCell.h
//  HorizontalScroller
//
//  Created by 胡礼节 on 15/11/4.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lable;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end
