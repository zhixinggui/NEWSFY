//
//  ContentViewController.h
//  ForU
//
//  Created by administrator on 15/9/25.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController
@property (strong,nonatomic)NSMutableArray *array;
@property (strong,nonatomic)NSMutableArray *dicArray;
@property (strong,nonatomic)UITableView *table;

-(void)requestNewData:(UITableView *)tableView and:(void(^)(void))finishBlock;
@end
