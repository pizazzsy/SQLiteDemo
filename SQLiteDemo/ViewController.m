//
//  ViewController.m
//  SQLiteDemo
//
//  Created by PFZC on 2017/4/27.
//  Copyright © 2017年 PFZC. All rights reserved.
//

#import "ViewController.h"
#import "sqlite3.h"

@interface ViewController ()
{
     char *error;
     sqlite3 * db;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"开始操作数据库");
    
}
- (IBAction)btnOpClick:(id)sender {
    
    [self openSqlite];
    
}
- (IBAction)btnCreatClick:(id)sender {
    
    [self creatTable];
}
- (IBAction)btnClClick:(id)sender {
    
}
- (IBAction)insertBtnClick:(id)sender {
    
    [self insertSql];
}
- (IBAction)deleteBtnClick:(id)sender {
    
    [self deleteSql];
    
}
- (IBAction)updateBtnClick:(id)sender {
    
    [self updateSql];
    
}
- (IBAction)selectBtnClick:(id)sender {
    
    [self selectSql];
    
}

-(void)openSqlite
{
    
    NSString *docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *databasePath = [[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"db.sqlite"] ];
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    const char *dbpath = [databasePath UTF8String];
    
    
        if (sqlite3_open(dbpath, &db)==SQLITE_OK)
        {
            NSLog(@"打开数据库");
        }else
        {
            NSLog(@"数据库打开失败");
        }
}
-(void)creatTable
{
    /*
     sql 语句，专门用来操作数据库的语句。
     create table if not exists 是固定的，如果表不存在就创建。
     myTable() 表示一个表，myTable 是表名，小括号里是字段信息。
     字段之间用逗号隔开，每一个字段的第一个单词是字段名，第二个单词是数据类型，primary key 代表主键，autoincrement 是自增。
     */
    
    NSString*createSql=@"create table if not exists myTable(id integer primary key autoincrement, name text,age integer,address text)";
    if (sqlite3_exec(db, [createSql UTF8String], NULL, NULL, &error)==SQLITE_OK) {
        NSLog(@"成功创建表");
    }else{
        NSLog(@"错误信息：%s",error);
        //每次使用完清空错误信息，提供给下次使用
        sqlite3_free(error);
    }

}
-(void)insertSql
{
    //插入记录
    NSString*inserSql=[NSString stringWithFormat:@"insert into myTable(name, age,address) values ('%@','%@','%@')",self.nameTxt.text,self.ageTxt.text,self.addrTxt.text];
    
    if (sqlite3_exec(db, [inserSql UTF8String], NULL, NULL, &error)==SQLITE_OK) {
        NSLog(@"插入数据成功");
    }else
    {
        NSLog(@"错误信息：%s",error);
        sqlite3_free(error);
    }

}
-(void)updateSql
{
    //修改记录
    
    NSString * updateSql=[NSString stringWithFormat:@"update myTable set age = '%@', address = '%@' where name ='%@'",_ageTxt.text,_addrTxt.text,_nameTxt.text];
    
    if (sqlite3_exec(db, [updateSql UTF8String], NULL, NULL, &error) == SQLITE_OK) {
        NSLog(@"update operation is ok.");
    } else {
        NSLog(@"错误信息: %s", error);
        
        // 每次使用完毕清空 error 字符串，提供给下一次使用
        sqlite3_free(error);
    }

}
-(void)deleteSql
{
    
    //删除记录
    NSString *deleteSql=[NSString stringWithFormat:@"delete from myTable where name = '%@'",self.nameTxt.text];
    
    if (sqlite3_exec(db, [deleteSql UTF8String], NULL, NULL, &error) == SQLITE_OK) {
        NSLog(@"delete operation is ok.");
    } else {
        NSLog(@"错误信息: %s", error);
        
        // 每次使用完毕清空 error 字符串，提供给下一次使用
        sqlite3_free(error);
    }

}
-(void)selectSql
{
    
    //查询记录
    sqlite3_stmt *statement;
    
    // @"select * from myTable"  查询所有 key 值内容
    
    NSString *selectSql=[NSString stringWithFormat:@"select * from myTable where name='%@'",_nameTxt.text];
    
    if (sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        while(sqlite3_step(statement) == SQLITE_ROW) {
            
            // 查询 id 的值
            int _id = sqlite3_column_int(statement, 0);
            
            // 查询 name 的值
          NSString * name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
            
            // 查询 age
            int age = sqlite3_column_int(statement, 2);
            
            // 查询 name 的值
            NSString *address = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
            
            NSLog(@"id: %i, name: %@, age: %i, address: %@", _id, name, age, address);
        }
    } else {
        NSLog(@"select operation is fail.");
    }
      sqlite3_finalize(statement);

}
-(void)closeSqlite
{
    
    //关闭数据库
    sqlite3_close(db);
    
    NSLog(@"关闭数据库");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
