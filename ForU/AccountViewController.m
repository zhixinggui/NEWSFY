//
//  AccountViewController.m
//  ForU
//
//  Created by administrator on 15/10/12.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "AccountViewController.h"
#import "GetCodeNavigationBar.h"
#import "UserTableViewCell.h"
#import "ProfileTableViewCell.h"
#import "BindingTableViewCell.h"
#import "EditView.h"
#import "Header.h"
#import "UserViewController.h"
#import "IdentifyViewController.h"
#import "OperateDatabase.h"
#import "UploadData.h"
#import "RequstLocalData.h"
#import "AFNetworking.h"


#import <AliyunOSSiOS/OSSService.h>
#import <AliyunOSSiOS/OSSCompat.h>


NSString * const AccessKey = @"xhoGITujAaNIUtGg";
NSString * const SecretKey = @"LxT9aaorRhiDCC7EPVjCU6cv7FNCXA";
NSString * const endPoint = @"http://oss-cn-hangzhou.aliyuncs.com";
NSString * const multipartUploadKey = @"multipartUploadObject";


OSSClient * client;
static dispatch_queue_t queue4demo;


@interface AccountViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property(strong,nonatomic)GetCodeNavigationBar *navBar;
@property (strong,nonatomic)UITableView *table;
@property (strong,nonatomic)NSArray *array,*bindingArray;
@property (strong,nonatomic)NSMutableDictionary *dic,*infodic;
@property(copy,nonatomic)NSString *nickName,*phoneNumber,*autograph,*resetPassword,*imagePath;
@property (strong,nonatomic)UIImage *image;
@property (strong,nonatomic)UIButton *button;
@property (strong,nonatomic)EditView *editView;
@property (strong,nonatomic)UIView *backgroundView;
@property (assign,nonatomic)CGFloat keyboardHeight;
@property (assign,nonatomic)BOOL click,cellSelect;
@property (assign,nonatomic)NSString *qq,*sina;
@end

@implementation AccountViewController{
    NSMutableDictionary *dicGetData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellSelect=NO;
    
    

    
    //获取Documents文件夹目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    //指定新建文件夹路径
    NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"ImageFile"];
    //创建ImageFile文件夹
    [[NSFileManager defaultManager] createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
    //保存图片的路径
    self.imagePath = [imageDocPath stringByAppendingPathComponent:@"image.png"];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.view.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    
    RequstLocalData *request=[[RequstLocalData alloc]init];
    dicGetData =[[NSMutableDictionary alloc]init];
    dicGetData =[request requestLocalInfo];
            self.infodic = dicGetData;
        self.qq=[self.infodic objectForKey:@"qq"];
        self.sina=[self.infodic objectForKey:@"sina"];
        
        [self initView];
        [self initDate];

   
 
}

- (void)initView{
    self.backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_HEIGHT*150/667)];
    self.backgroundView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.backgroundView];
    
    self.table=[[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*35/667, SCREEN_WIDTH,SCREEN_HEIGHT*632/667 ) style:UITableViewStyleGrouped];
    self.table.dataSource=self;
    self.table.delegate=self;
    self.table.separatorStyle = NO;
    [self.view addSubview:self.table];
    
    self.navBar=[[GetCodeNavigationBar alloc]initWithNavBar:@"back" andLabel:@"账号管理" andBtn:nil] ;
    [self.navBar.leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navBar.leftBtn.tag=1;
    [self.view addSubview:self.navBar];
    
   
    
 
   
}
-(void)initDate{
    self.resetPassword=@" ";
    self.array=@[@"头像",@"昵称",@"签名",@"手机号",@"修改密码"];
    self.bindingArray=@[ @"新浪微博",@"腾讯QQ",@"手机号码"];
    
    self.dic=[[NSMutableDictionary alloc]init];
    [self.dic setValue:self.nickName forKey:@"昵称"];
    [self.dic setValue:self.phoneNumber forKey:@"手机号"];
    [self.dic setValue:self.autograph forKey:@"签名"];
    [self.dic setValue:self.resetPassword forKey:@"修改密码"];
    
}
-(void)initEditView:(NSString *)str{
    self.editView=[[EditView alloc]initWithStyle:str andFrame:CGRectMake(0, SCREEN_HEIGHT+SCREEN_HEIGHT*150/667, SCREEN_WIDTH,SCREEN_HEIGHT*150/667 ) andSourse:1 ];
    [self.editView.sureBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.editView.sureBtn.tag=3;
    [self.editView.cancelBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.editView.cancelBtn.tag=4;
    self.editView.editText.delegate=self;
    [self.view addSubview:self.editView];

}
#pragma mark - tableView设置
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return [self.array count];
    }
    else {
        return 3;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return SCREEN_HEIGHT/9;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==0){
        return 10;
    }
    else {
        return 100;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section==0){
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, view.frame.size.width, view.frame.size.height-15)];
        label.text=@"当前登录方式";
        label.font=[UIFont fontWithName:@"Arial" size:12];
        label.textColor=[UIColor colorWithRed:167/255.0 green:167/255.0 blue:172/255.0 alpha:1];
        [view addSubview:label];
        return view;
    }
   else {
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*50/667)];
    self.button=[[UIButton alloc]initWithFrame:CGRectMake(0, 40, view.frame.size.width, view.frame.size.height-10)];
       [self.button setTitle:@"退出登录" forState:UIControlStateNormal];
       [self.button setTitleColor:[UIColor colorWithRed:220/255.0 green:87/255.0 blue:76/255.0 alpha:1] forState:UIControlStateNormal];
       [self.button setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]];
       [self.button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
       self.button.tag=2;
    [view addSubview:self.button];
    return view;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString *str=@"table";
    static NSString *str1=@"table1";
    static NSString *str2=@"table2";
    if(indexPath.section == 0){
        if(indexPath.row==0){
            ProfileTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil) {
                cell = [[ProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
            }
            cell.leftLabel.text=[self.array objectAtIndex:indexPath.row];
            cell.profileImg.image=self.image;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else{
            UserTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str1];
            if (cell == nil) {
                cell = [[UserTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str1];
            }
            cell.leftLabel.text=[self.array objectAtIndex:indexPath.row];
            cell.rightLabel.text=[self.dic objectForKey:[self.array objectAtIndex:indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
    }
    else {
        BindingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str2];
        if (cell == nil) {
            cell = [[BindingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str2];
        }
        cell.leftLabel.text=[self.bindingArray objectAtIndex:indexPath.row];
        if(indexPath.row==0){
            if([self.sina isEqualToString:@""]){
                cell.leftLabel.font=[UIFont fontWithName:@"Arial" size:15];
                cell.leftLabel.textColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1];
            }
            else{
                cell.leftLabel.font=[UIFont fontWithName:@"Arial" size:18];
                cell.leftLabel.textColor = [UIColor colorWithRed:220/255.0 green:87/255.0 blue:76/255.0 alpha:1];
            }
        }
        else if (indexPath.row==1){
            if([self.qq isEqualToString:@""]){
                cell.leftLabel.font=[UIFont fontWithName:@"Arial" size:15];
                cell.leftLabel.textColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1];
                
            }
            else{
                cell.leftLabel.font=[UIFont fontWithName:@"Arial" size:18];
                cell.leftLabel.textColor = [UIColor colorWithRed:220/255.0 green:87/255.0 blue:76/255.0 alpha:1];
            }
        }
        else{
            if([self.phoneNumber isEqualToString:@""]){
                cell.leftLabel.font=[UIFont fontWithName:@"Arial" size:15];
                cell.leftLabel.textColor=[UIColor colorWithRed:42/255.0 green:54/255.0 blue:68/255.0 alpha:1];
            }
            else{
                cell.leftLabel.font=[UIFont fontWithName:@"Arial" size:18];
                cell.leftLabel.textColor = [UIColor colorWithRed:220/255.0 green:87/255.0 blue:76/255.0 alpha:1];
            }
        }        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            //调用系统相册更改图片
            [self chooseImage];
        }
        if(indexPath.row==1){
            //弹出页面修改昵称
            if(self.cellSelect==NO){
                self.cellSelect=YES;
            [self initEditView:@"请输入用户名"];
             self.editView.tag=1;
            [UIView animateWithDuration:0.5 animations:^{
                [self.editView.editText becomeFirstResponder];
            } completion:^(BOOL finished) {
            }];
                
                //蒙版
            [UIView animateWithDuration:0.8 animations:^{
                [self.view bringSubviewToFront:self.backgroundView];
                self.backgroundView.backgroundColor=RGBAA(42, 54, 68, 0.5);
            } completion:^(BOOL finished) {
            }];
            }
        }
        if(indexPath.row==2){
            //修改签名
            if(self.cellSelect==NO){
                self.cellSelect=YES;
            [self initEditView:@"请输入个性签名"];
            self.editView.tag=2;
            [UIView animateWithDuration:0.5 animations:^{
                [self.editView.editText becomeFirstResponder];
                
            } completion:^(BOOL finished) {
            }];
            [UIView animateWithDuration:1.0 animations:^{
                [self.view bringSubviewToFront:self.backgroundView];
                self.backgroundView.backgroundColor=RGBAA(42, 54, 68, 0.5);
                
            } completion:^(BOOL finished) {
            }];
            }
        }
        if(indexPath.row==4){
            //修改密码,若不是手机号登录，则没有密码
            if([self.phoneNumber isEqualToString:@""]){
                
            }
            else{
            IdentifyViewController *ivc=[[IdentifyViewController alloc]init];
            [ivc setValue:self.phoneNumber forKey:@"phoneNumber"];
                [self.navigationController pushViewController:ivc animated:YES];
//            [self presentViewController:ivc animated:YES completion:nil];
            }
        }
    }
}
#pragma mark - 动态获取键盘高度
//当键盘出现或改变时调用

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    self.keyboardHeight=height;
    
    [self.backgroundView setFrame:CGRectMake(0,0 ,SCREEN_WIDTH,SCREEN_HEIGHT-self.keyboardHeight-SCREEN_HEIGHT*150/667 )];
    [self.editView setFrame:CGRectMake(0,SCREEN_HEIGHT-self.keyboardHeight-SCREEN_HEIGHT*150/667 ,SCREEN_WIDTH,SCREEN_HEIGHT*150/667 )];
 
}
//当键盘消失时
- (void) keyboardWillHide:(NSNotification *) notif
{
    [UIView animateWithDuration:0.5 animations:^{
         [self.editView setFrame:CGRectMake(0,SCREEN_HEIGHT-SCREEN_HEIGHT*150/667 ,SCREEN_WIDTH,SCREEN_HEIGHT*150/667 )];
        [self.backgroundView setFrame:CGRectMake(0,0 ,SCREEN_WIDTH,SCREEN_HEIGHT-SCREEN_HEIGHT*150/667 )];

    } completion:^(BOOL finished) {
    }];
}
#pragma mark - 点击事件
-(void)click:(UIButton *)sender{
    
    if(sender.tag==1){
        if (_delegate !=nil &&[_delegate respondsToSelector:@selector(returnMessage:andImage:)]) {
            [_delegate returnMessage:self.dic andImage:self.image];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    if(sender.tag==2){

//
        
        UIAlertController *contoller = [UIAlertController alertControllerWithTitle:nil message:@"确定要退出？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {


          
            //退出登录，清空本地数据库User表信息
            OperateDatabase *operate=[[OperateDatabase alloc]init];
            [operate deleteData];
            [self back];

        }];
        [contoller addAction:cancelAction];
        [contoller addAction:otherAction];
        [self presentViewController:contoller animated:YES completion:nil];//弹出提醒框

//
    }
    if(sender.tag==3){
        self.cellSelect=NO;
        [self.view sendSubviewToBack:self.backgroundView];
        if(self.editView.tag==1){//昵称编辑框
            self.nickName= self.editView.editText.text;
            //更新本地数据库
            OperateDatabase *operate=[[OperateDatabase alloc]init];
            [operate updateNickname:self.editView.editText.text];
            
            //更新服务器数据库信息


                //取到当前用户id
                NSString *str=[dicGetData objectForKey:@"userid"];
                int userid=[str intValue];
                UploadData *upload=[[UploadData alloc]init];
                [upload uploadUserInfo:userid andCulm:@"nickName" andValue:self.editView.editText.text andSuccess:^(NSMutableDictionary *dic){
                }];

            }
        else{     //签名编辑框
            self.autograph=self.editView.editText.text;
            //更新本地数据库
            OperateDatabase *operate=[[OperateDatabase alloc]init];
            [operate updateAutograph:self.editView.editText.text];
            
            //更新服务器


                //取到当前用户id
                NSString *str=[dicGetData objectForKey:@"userid"];
                int userid=[str intValue];
                UploadData *upload=[[UploadData alloc]init];
                [upload uploadUserInfo:userid andCulm:@"userAutograph" andValue:self.editView.editText.text andSuccess:^(NSMutableDictionary *dic){
                } ];
                

        }
        [self initDate];
        [self.table reloadData];
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.backgroundView.backgroundColor=[UIColor clearColor];
            
            [self.view sendSubviewToBack:self.backgroundView];
            
        } completion:^(BOOL finished) {
        }];

        
        [UIView animateWithDuration:0.5 animations:^{
            [self.editView.editText resignFirstResponder];
            [self.editView setFrame:CGRectMake(0,SCREEN_HEIGHT+ SCREEN_HEIGHT*150/667 ,SCREEN_WIDTH, SCREEN_HEIGHT*150/667)];
           
        } completion:^(BOOL finished) {
        }];
    }
    if(sender.tag==4){
        //取消编辑
        self.cellSelect=NO;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.backgroundView.backgroundColor=[UIColor clearColor];
            [self.view sendSubviewToBack:self.backgroundView];
            
        } completion:^(BOOL finished) {
        }];
        
        [UIView animateWithDuration:0.5 animations:^{
           [self.editView.editText resignFirstResponder];
            [self.editView setFrame:CGRectMake(0,SCREEN_HEIGHT+SCREEN_HEIGHT*150/667 ,SCREEN_WIDTH, SCREEN_HEIGHT*150/667)];
        } completion:^(BOOL finished) {
        }];

    }
}
#pragma mark - 更改头像
#pragma mark - UIImagePickerController代理方法
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *aimage =[info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *image = [self fixOrientation:aimage];
    
    [self saveImage:image withName:@"currentImage.png"];
    float currentTimeMillis = [[NSDate date] timeIntervalSince1970] * 1000;
    //图片路径
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
 
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    self.image=savedImage;
    NSData *data=UIImageJPEGRepresentation(savedImage, 1.0);
    //存到本地数据库,图片保存到沙盒，路径保存到数据库

    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *imageName =[NSString stringWithFormat:@"%@%f.png", [self.infodic valueForKey:@"userid"],currentTimeMillis];
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];   // 保存文件的名称
    
    [UIImagePNGRepresentation(savedImage)writeToFile: filePath    atomically:YES];

    OperateDatabase *operate=[[OperateDatabase alloc]init];
    [operate updateIcon:[NSString stringWithFormat:@"%@",imageName]];

//图片上传到oss

    NSString *endpoint = @"http://oss-cn-hangzhou.aliyuncs.com";
        id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey
                                                                                                                secretKey:SecretKey  ];
                                                client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
        OSSPutObjectRequest * put = [OSSPutObjectRequest new];
        put.bucketName = @"foru";
        put.objectKey =imageName;
    
         put.uploadingData =data; // 直接上传NSData
    
        put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {

        };
    
        OSSTask * putTask = [client putObject:put];
    
        [putTask continueWithBlock:^id(OSSTask *task) {
            if (!task.error) {

            } else {

            }
            return nil;
        }];
    
    //图片路径保存到服务器
    
    
        //取到当前用户id
        NSString *str=[self.infodic objectForKey:@"userid"];
        int userid=[str intValue];
        UploadData *upload=[[UploadData alloc]init];
    [upload uploadUserInfo:userid andCulm:@"icon" andValue:[NSString stringWithFormat:@"%@",imageName] andSuccess:^(NSMutableDictionary *dic){
        
    }];

    
    [self.table reloadData];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            imagePickerController.delegate = self;
            
        }];
    }
}
-(void)chooseImage{
    UIActionSheet *sheet ;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
    
}

//修改拍照所得图片，防止翻转
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}




//收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return 0;
    }
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)back{
     [self.navigationController popViewControllerAnimated:YES];
    
}



@end
