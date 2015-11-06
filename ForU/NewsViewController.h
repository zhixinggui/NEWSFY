//
//  NewsViewController.h
//  ForU
//
//  Created by administrator on 15/9/25.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"
#import "RequstLocalData.h"
#import "SDRefresh.h"
#import "ShareView.h"
#import "Share.h"
#import "EditView.h"
@interface NewsViewController :  UIViewController<UIScrollViewDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate,UITextViewDelegate>
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

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIView *introView;
@property(nonatomic,strong)UILabel *titleLabelup;

@property(nonatomic,strong)UIImageView *imageViewup;
@property(nonatomic,strong)UIView *introViewup;
@property(nonatomic,strong)NSString *newsId;
@property(nonatomic,strong)NSString *newsstyleid;
@property (nonatomic,strong)CustomButton  *CustomButton;
@property (nonatomic,strong)UIView  *CustomView;
@property (nonatomic,strong)SDRefreshFooterView *refreshFooter;
@property(nonatomic,strong)NSString *newsmaxid;
@property(nonatomic,strong)NSString *newsminid;
@property(strong,nonatomic)ShareView *shareView;
@property (strong,nonatomic)UIView *backView;
@property(nonatomic,strong)RequstLocalData *requsetUserInfo;
@property (strong,nonatomic)EditView *editView;
@property (strong,nonatomic)UIView *backgroundView;
@property (assign,nonatomic)CGFloat keyboardHeight;
@end
