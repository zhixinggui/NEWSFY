//
//  tableModel.m
//  ForU
//
//  Created by 胡礼节 on 15/10/14.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "tableModel.h"

@implementation tableModel
-(NSMutableDictionary *)getTableTurn{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init]; ;
    [dic setValue:@"worldnews" forKey:@"1"];
      [dic setValue:@"socialnews" forKey:@"4"];
      [dic setValue:@"entertainmentnews" forKey:@"13"];
      [dic setValue:@"mainlandnews" forKey:@"2"];
      [dic setValue:@"tourismnews" forKey:@"24"];
      [dic setValue:@"financenews" forKey:@"10"];
      [dic setValue:@"fashionnews" forKey:@"15"];
      [dic setValue:@"booknews" forKey:@"20"];
      [dic setValue:@"culturenews" forKey:@"9"];
      [dic setValue:@"educationnews" forKey:@"21"];
      [dic setValue:@"technologynews" forKey:@"12"];
      [dic setValue:@"sportsnews" forKey:@"14"];
      [dic setValue:@"militarynews" forKey:@"7"];
      [dic setValue:@"carnews" forKey:@"11"];
      [dic setValue:@"commentsnews" forKey:@"6"];
      [dic setValue:@"housenews" forKey:@"18"];
      [dic setValue:@"historynews" forKey:@"8"];
      [dic setValue:@"blognews" forKey:@"19"];
      [dic setValue:@"taiwannews" forKey:@"5"];
      [dic setValue:@"hknews" forKey:@"3"];
    [dic setValue:@"moralintegritynews" forKey:@"27"];
        [dic setValue:@"toutiaohotnews" forKey:@"28"];
    

    return dic;

}
@end
