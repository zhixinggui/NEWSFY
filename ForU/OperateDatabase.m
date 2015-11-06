//
//  OperateDatabase.m
//  ForU
//
//  Created by administrator on 15/10/16.
//  Copyright © 2015年 胡礼节. All rights reserved.
//

#import "OperateDatabase.h"
#import "FMDatabase.h"
#import "FMDB.h"
@implementation OperateDatabase
-(void)creatDatebase{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    
    
    if([[NSFileManager defaultManager]fileExistsAtPath:dbPath]){
         NSLog(@"数据库已存在");
        
        NSArray *paths= NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString*path = [paths lastObject];
        
        
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
        for (NSString *str in files) {
            NSError* error;
            NSString* path_ = [path stringByAppendingPathComponent:str];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path_]) {
                //清理缓存
                [[NSFileManager defaultManager] removeItemAtPath:path_ error:&error];
            }
        }


        
    }
    else{ //创建数据库
        FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
        if(!db){
            NSLog(@"数据库创建不成功");
        }
        else{

            if (![db open]) {
                NSLog(@"数据库打开失败！");
            }
            //ID 标识行   Userid 用户ID  password 登录密码 nickName 用户昵称  phoneNumber 手机号  icon 头像  sina 微博昵称 qq QQ昵称 weichat 微信昵称 tag 用户行为信息
            [db executeUpdate:@"CREATE TABLE USER (Id integer, Userid integer,password text,nickName text,phoneNumber text,icon text,autograph text, sina text,qq text,weichat text,tag text)"] ;//创建一个存储用户信息的表
              [db executeUpdate:@"CREATE TABLE newstable (newsId  integer,newsStyleId  integer ,newsTitle text,newsTime text,newsContent text,newsFirstImg text)"];
            NSLog(@"创表成功");
            
            //plist创建
            
            //获取本地沙盒路径
            
            //获取完整路径
            
            NSString *plistPath = [documentDirectory stringByAppendingPathComponent:@"titlesList.plist"];
            NSMutableDictionary *titleDic = [[NSMutableDictionary alloc ] init];
            //设置属性值
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            [arr addObject:@"热点"];
            [arr addObject:@"社会"];
            [arr addObject:@"娱乐"];
            [arr addObject:@"国际"];
            [arr addObject:@"大陆"];
            [arr addObject:@"旅游"];
            [arr addObject:@"财经"];
            [arr addObject:@"时尚"];
            [arr addObject:@"读书"];
            [arr addObject:@"文化"];
            [arr addObject:@"教育"];
            [arr addObject:@"科技"];
            [arr addObject:@"体育"];
            [arr addObject:@"军事"];
            [arr addObject:@"汽车"];
            [arr addObject:@"热论"];
            [arr addObject:@"房产"];
            [arr addObject:@"历史"];
            [arr addObject:@"博文"];
            [arr addObject:@"台湾"];
            [arr addObject:@"港澳"];
            [arr addObject:@"节操"];
            [titleDic setObject:arr forKey:@"arr"];
            //    [usersDic setObject:@"123456" forKey:@"password"];
            //写入文件
            [titleDic writeToFile:plistPath atomically:YES];
            //
            
            

            
            [db close];
        }

    }
}


- (BOOL)checkNews:(NSString *)title{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
    
    FMResultSet *rs=[db executeQuery:@"SELECT * from newstable WHERE newsTitle = ?",title];//结果集
    if([rs next]){
        int count=[rs intForColumnIndex:0];
        if(count==0){
            self.click=YES;
        }
        
        [db close];
        return NO;
    }else {     [db close];
        return YES;
        
    }
    
    
    
}

- (NSMutableArray*)getNews:(NSString *)newsstyleid{
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
    
    FMResultSet *rs=[db executeQuery:@"SELECT * from newstable WHERE newsStyleId =(?)  ORDER BY newsId DESC;",newsstyleid];//结果集
    while ([rs next]){
        
        NSString *newsId = [rs stringForColumn:@"newsId"];
        NSString *newsStyleId = [rs stringForColumn:@"newsStyleId"];
        NSString *newsTitle = [rs stringForColumn:@"newsTitle"];
        NSString *newsTime = [rs stringForColumn:@"newsTime"];
        NSString *newsContent = [rs stringForColumn:@"newsContent"];
        NSString *newsFirstImg = [rs stringForColumn:@"newsFirstImg"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:newsId,@"newsid", newsStyleId,@"newsstyleid",newsTitle,@"newstitle",newsTime,@"newstime",newsContent,@"newscontent",newsFirstImg,@"newsfirstimg",nil];
        [resultArray addObject:dic];
    }
     [db close];
    return resultArray;
    
    
    
}

- (NSDictionary*)getOneNews:(NSDictionary *)newsPara{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
    NSDictionary *dic;
    NSString *newsstyleid = [newsPara valueForKey:@"newsStyleId"];
    NSString *newsid = [newsPara valueForKey:@"newsId"];
    FMResultSet *rs=[db executeQuery:@"SELECT * from newstable WHERE newsStyleId =? and newsid = ?",newsstyleid,newsid];//结果集
    while ([rs next]){
        
        NSString *newsId = [rs stringForColumn:@"newsId"];
        NSString *newsStyleId = [rs stringForColumn:@"newsStyleId"];
        NSString *newsTitle = [rs stringForColumn:@"newsTitle"];
        NSString *newsTime = [rs stringForColumn:@"newsTime"];
        NSString *newsContent = [rs stringForColumn:@"newsContent"];
        NSString *newsFirstImg = [rs stringForColumn:@"newsFirstImg"];
        dic = [NSDictionary dictionaryWithObjectsAndKeys:newsId,@"newsid", newsStyleId,@"newsstyleid",newsTitle,@"newstitle",newsTime,@"newstime",newsContent,@"newscontent",newsFirstImg,@"newsfirstimg",nil];
        
    }
    
    return dic;
    
    
}

//将获取到的新闻信息插入news表
-(void)insertNewsData:(NSDictionary *)dic{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
    
    NSString *newsid = [dic valueForKey:@"newsid"];
    NSString *newsStyleId = [dic valueForKey:@"newsstyleid"];
    
    NSString *newsTitle = [dic valueForKey:@"newstitle"];
    
    NSString *newsTime = [dic valueForKey:@"newstime"];
    
    NSString *newsContent = [dic valueForKey:@"newscontent"];
    
    NSString *newsFirstImg = [dic valueForKey:@"newsfirstimg"];
    
    
    
    //将数据插入表
    [db executeUpdate:@"INSERT INTO newstable (newsId  ,newsStyleId ,newsTitle ,newsTime ,newsContent,newsFirstImg ) VALUES(?,?,?,?,?,?)",newsid  ,newsStyleId ,newsTitle ,newsTime ,newsContent,newsFirstImg];
    [db close];
}


//判断表是否为空
-(void)check{
    self.click=NO;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
    FMResultSet *rs=[db executeQuery:@"SELECT COUNT(*) from USER"];//结果集
    if(rs.next){
        int count=[rs intForColumnIndex:0];
        if(count==0){
          self.click=YES;
        }
    }
    [db close];
}

//将获取到的用户信息插入USER表
-(void)insertData:(NSMutableDictionary *)dic{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
    int userid=[[dic objectForKey:@"userid"] intValue];
    NSString *password=[dic objectForKey:@"password"];
    NSString *nickName=[dic objectForKey:@"nickname"];
    NSString *phoneNumber=[dic objectForKey:@"phonenumber"];
    NSString *icon=[dic objectForKey:@"icon"];//图片URL地址
    NSString *autograph=[dic objectForKey:@"userautograph"];
    NSString *sina=[dic objectForKey:@"sina"];
    NSString *qq=[dic objectForKey:@"qq"];
    NSString *weichat=[dic objectForKey:@"weichat"];
    NSString *tag=[dic objectForKey:@"tag"];

    //将数据插入表
    [db executeUpdate:@"INSERT INTO USER (Id , userid ,password ,nickName ,phoneNumber ,icon ,autograph , sina ,qq ,weichat ,tag ) VALUES(?,?,?,?,?,?,?,?,?,?,?)",[NSNumber numberWithInt:1],[NSNumber numberWithInt:userid],password,nickName,phoneNumber,icon,autograph,sina,qq,weichat,tag];
    [db close];
}

//删除表中的信息
-(void)deleteData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
    [db executeUpdate:@"DELETE FROM USER where Id=1"];
    [db close];
}
//获取表中的信息
-(void)selectNewsid{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
    self.userid=[db stringForQuery:@"SELECT userid FROM INFOR WHERE Id=1"];
    [db close];
}
//修改头像
-(void)updateIcon:(NSString *)data{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
  
    [db executeUpdate:@"update USER set icon=? where Id=1",data];
    [db close];
}
//修改密码
-(void)updatePassword:(NSString *)str{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
    [db executeUpdate:@"update USER set password=?where Id=1",str];
    [db close];
}

//修改签名
-(void)updateAutograph:(NSString *)str{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
    [db executeUpdate:@"update USER set autograph=?where Id=1",str];
    [db close];
}

//修改昵称
-(void)updateNickname:(NSString *)str{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    //dbPath： 数据库路径，在Document中。
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"forU.db"];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath] ;
    [db open];
    [db executeUpdate:@"update USER set nickName=?where Id=1",str];
    [db close];
}



@end
