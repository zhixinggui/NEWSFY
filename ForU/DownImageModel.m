
//
//  DownImageModel.m
//  ForU
//
//  Created by 胡礼节 on 15/10/25.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "DownImageModel.h"

#import <AliyunOSSiOS/OSSService.h>
#import <AliyunOSSiOS/OSSCompat.h>
@implementation DownImageModel


-(void)downLoad:(NSString *)imageName{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://foru.oss-cn-hangzhou.aliyuncs.com/%@",imageName]]];//加载图片;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];   // 保存文件的名称
    UIImage *image = [UIImage imageWithData:data];
    [UIImagePNGRepresentation(image)writeToFile: filePath    atomically:YES];
    
    
    
    

    
 }
@end
