//
//  ForUWebViewController.h
//  ForU
//
//  Created by 胡礼节 on 15/10/22.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "RequstLocalData.h"
#import "SDRefresh.h"
#import "ShareView.h"
#import "EditView.h"

@interface ForUWebViewController : UIViewController<UIScrollViewDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate,UITextViewDelegate>
@property(strong,nonatomic)ShareView *shareView;
@property(nonatomic,strong)UIWebView *webview1;
@property(nonatomic,strong)UIWebView *webview2;
@property(nonatomic,strong)UIWebView *webview20;
@property(nonatomic,strong)UIWebView *webview0;
@property(nonatomic,strong)UIWebView *footerView;
@property(nonatomic,strong)UIView *theScrollerView;
@property (retain, nonatomic)UIPanGestureRecognizer *panGesture;
@property (retain, nonatomic)UIView *overLay;
@property (assign, nonatomic)BOOL isHidden;
@property(nonatomic,strong)UILabel *titleLabel;
@property(strong,nonatomic)UIButton *btn;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIView *introView;
@property(nonatomic,strong)UILabel *titleLabelup;

@property(nonatomic,strong)UIImageView *imageViewup;
@property(nonatomic,strong)UIView *introViewup;
@property(nonatomic,assign)int newsId;
@property(nonatomic,strong)NSMutableArray *newsArray;
@property(nonatomic,strong)NSString *newsstyleid;
@property (nonatomic,strong)CustomButton  *CustomButton;
@property (nonatomic,strong)UIView  *CustomView;
@property (nonatomic,strong)SDRefreshFooterView *refreshFooter;
@property(nonatomic,assign)int newsmaxid;
@property(nonatomic,assign)int newsminid;
@property (strong,nonatomic)UIView *backView;
@property(nonatomic,strong)RequstLocalData *requsetUserInfo;
@property (strong,nonatomic)EditView *editView;
@property (strong,nonatomic)UIView *backgroundView;
@property (assign,nonatomic)CGFloat keyboardHeight;
@end
