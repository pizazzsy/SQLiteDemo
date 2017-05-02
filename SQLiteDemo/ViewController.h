//
//  ViewController.h
//  SQLiteDemo
//
//  Created by PFZC on 2017/4/27.
//  Copyright © 2017年 PFZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *openDB;
@property (weak, nonatomic) IBOutlet UIButton *closeDB;
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;

@property (weak, nonatomic) IBOutlet UITextField *ageTxt;
@property (weak, nonatomic) IBOutlet UITextField *addrTxt;
@property (weak, nonatomic) IBOutlet UITextField *selectTxt;

@end

