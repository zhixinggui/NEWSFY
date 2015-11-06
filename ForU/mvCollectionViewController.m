//
//  mvCollectionViewController.m
//  ForU
//
//  Created by 胡礼节 on 15/11/3.
//  Copyright (c) 2015年 胡礼节. All rights reserved.
//

#import "mvCollectionViewController.h"
#import "RequstData.h"
#import "CollectionViewCell.h"
@interface mvCollectionViewController ()

@end

@implementation mvCollectionViewController
static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.array = [[NSMutableArray alloc ] init];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self requestNewData:^(void){
        
    }];

}

- (NSIndexPath *)curIndexPath {
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    NSIndexPath *curIndexPath = nil;
    NSInteger curzIndex = 0;
    for (NSIndexPath *path in indexPaths.objectEnumerator) {
        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:path];
        if (!curIndexPath) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
            continue;
        }
        if (attributes.zIndex > curzIndex) {
            curIndexPath = path;
            curzIndex = attributes.zIndex;
        }
    }
    return curIndexPath;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *curIndexPath = [self curIndexPath];
    if (indexPath.row == curIndexPath.row) {
        return YES;
    }
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    

    
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click %ld", indexPath.row);
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *dic = [self.array objectAtIndex:indexPath.row];
    NSString *html =[NSString stringWithFormat:@"<link rel=\"stylesheet\" href=\"http://img.jiemian.com/static/jmm/css/mobile.css\" type=\"text/css\"><link rel=\"stylesheet\" href=\"http://img.jiemian.com/static/jmm/css/mobile.css\" type=\"text/css\">%@" ,[dic valueForKey:@"video"]];

    NSString *title = [dic valueForKey:@"title"];
    [cell.webview loadHTMLString:html baseURL:nil];
    cell.webview.backgroundColor = [UIColor blackColor];
    cell.webview.scrollView.showsHorizontalScrollIndicator = NO;
    cell.webview.scrollView.showsVerticalScrollIndicator = NO;
    cell.webview.scrollView.bounces = NO;
    cell.lable.text = title;
    cell.lable.textAlignment = NSTextAlignmentCenter;
    cell.lable.numberOfLines = 0;
    cell.lable.font=[UIFont fontWithName:@"Arial" size:15];
    cell.lable.textColor = [UIColor colorWithHue:156/255.0 saturation:156/255.0 brightness:156/255.0 alpha:156/255.0];

    return cell;
    
    
    
}
- (void)requestNewData:(void (^)(void))finishBlock{

    
    
    
    
    
    

    
    
    
    
    NSString *key = @"hulijieluolianglvkang015";
    
    
    
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:key forKey:@"key"];

    
    
    NSString *url = @"http://115.29.176.50/interface/index.php/Home/ForU/searchNewVideoByTable";
    RequstData *request=[[RequstData alloc]init];
    
    
    
    [request requestData:url url:parameters dic:^(NSMutableDictionary*dic1){
        
        NSString *s =[dic1 objectForKey:@"error_code"];
        
        
        
        if ([s isEqualToString:@"0"]) {
            
            self.array=[dic1 objectForKey:@"result"];
            [self.collectionView reloadData];

            
        }else{

        }
        
        finishBlock();
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }];
    
    
}
@end
