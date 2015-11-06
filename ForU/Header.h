//
//  Header.h
//  ForU
//
//  Created by 胡礼节 on 15/10/12.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#ifndef Header_h
#define Header_h

/** 定义大小*/


#define  SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define  SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define FONT(F) [UIFont systemFontOfSize:F]

#define RGB(r,g,b) RGBAA(r,g,b,1.0f)

#define RGBAA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#endif /* Header_h */
