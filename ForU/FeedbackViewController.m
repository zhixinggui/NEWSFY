//
//  FeedbackViewController.m
//  ForU
//
//  Created by administrator on 15/10/12.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "FeedbackViewController.h"
#import "MenuNavigationBar.h"
@interface FeedbackViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property(strong,nonatomic)GetCodeNavigationBar *navBar;
@property(strong,nonatomic)UITableView *table;
@property(strong,nonatomic)UITextField *textField;
@property(strong,nonatomic)UITextView *feedback;
@property(strong,nonatomic)UILabel *placeHolderLabel,*placeHolderLabel2;
@property(strong,nonatomic)NSString *feedBackStr,*contactStr,*feedBackStr2;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

//初始化页面
-(void)initView{
    self.view.backgroundColor=[UIColor grayColor];
    self.navBar = [[GetCodeNavigationBar alloc] initWithNavBar:@"返回" andLabel:@"意见反馈" andBtn:nil];
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.backgroundColor=[UIColor colorWithRed:195/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [self.view addSubview:self.navBar];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    _feedback = [[UITextView alloc] initWithFrame:CGRectMake(5, self.navBar.frame.size.height+5, self.view.frame.size.width-10, self.view.frame.size.height/3)];
    _feedback.backgroundColor = [UIColor whiteColor];
    _feedback.font = [UIFont fontWithName:@"Arial" size:15.0f];
    _feedback.layer.cornerRadius = 5.0f;
    [_feedback becomeFirstResponder];
    _feedback.delegate = self;
    [self.view addSubview:_feedback];
    _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width-10, 15)];
    _placeHolderLabel.text = @"请留下您的宝贵意见";
    _placeHolderLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
    _placeHolderLabel.textColor = [UIColor lightGrayColor];
    [_feedback addSubview:_placeHolderLabel];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(5, self.navBar.frame.size.height+5+self.feedback.frame.size.height+5, self.view.frame.size.width-10, 30)];
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.multipleTouchEnabled = YES;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;//边框
    self.textField.font = [UIFont fontWithName:@"Arial" size:15.0f];
    self.textField.adjustsFontSizeToFitWidth = YES;//自动缩小
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;//一次性删除
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
    
    _placeHolderLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, self.view.frame.size.width-10, 15)];
    _placeHolderLabel2.text = @"手机号/Email:方便我们及时给您回复";
    _placeHolderLabel2.font = [UIFont fontWithName:@"Arial" size:15.0f];
    _placeHolderLabel2.textColor = [UIColor lightGrayColor];
    [self.textField addSubview:_placeHolderLabel2];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3, self.navBar.frame.size.height+5+self.feedback.frame.size.height+5+self.textField.frame.size.height+30, self.view.frame.size.width/3, 30)];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn.layer setCornerRadius:5.0f];
    [btn.layer setBorderWidth:0.5f];
    btn.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:250/255.0 alpha:1];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(senderMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _placeHolderLabel2.hidden = YES;
    self.contactStr = textField.text;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        _placeHolderLabel2.hidden = NO;
    }else{
        self.contactStr = textField.text;
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _placeHolderLabel.hidden = YES;
    _feedback.textColor = [UIColor blackColor];
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        _placeHolderLabel.hidden = NO;
    }else{
    }
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView{
      self.feedBackStr = textView.text;
}

-(void)senderMessage{
    if (self.feedBackStr == nil || [self.feedBackStr isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"亲,请填写建议或意见" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        NSMutableDictionary*feedDic = [NSMutableDictionary dictionary];
        [feedDic setValue:self.feedBackStr forKey:@"content"];
        [feedDic setValue:self.contactStr forKey:@"contaction"];
        InsertFeedbackService *query = [[InsertFeedbackService alloc] init];
        [query insertFeedback:feedDic andMessage:^(NSMutableDictionary *success) {
            if ([self.feedBackStr2 isEqualToString:self.feedBackStr]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"不要重复发送相同内容哦" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }else{
                self.feedBackStr2 = self.feedBackStr;
                if ([[success objectForKey:@"reason"] isEqualToString:@"success"] ) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"发送成功,感谢您的建议和意见" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }else{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"发送失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
            }
        }];
    }
}

//按钮点击事件
-(void)click:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return 0;
    }else{
        self.contactStr = textField.text;
    }
    return YES;
}

@end
