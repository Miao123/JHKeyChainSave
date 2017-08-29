//
//  ViewController.m
//  KeyChinaDemo
//
//  Created by 苗建浩 on 2017/8/14.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import "ViewController.h"
#import "KeyChina.h"

static NSString * const KEY_USERNAME_PASSWORD = @"com.company.app.uesrnamepassword";
static NSString * const KEY_USERNAME = @"com.company.app.username";
static NSString * const KEY_PASSWORD = @"com.company.app.password";


@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *textArr = @[@"保存",@"取值",@"删除"];
    for (int i = 0; i < textArr.count; i++) {
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clickBtn.frame = CGRectMake(50, 50 + 50 * i, 100, 50);
        [clickBtn setTitle:textArr[i] forState:0];
        [clickBtn setTitleColor:[UIColor blueColor] forState:0];
        [clickBtn addTarget:self action:@selector(clickBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        clickBtn.tag = 1000 + i;
        [self.view addSubview:clickBtn];
        
    }
}


- (void)clickBtnClick:(UIButton *)sender{
    int index = (int)sender.tag - 1000;
    if (index == 0) {
        NSMutableDictionary *userNamePasswordKVPairs = [NSMutableDictionary dictionary];
        [userNamePasswordKVPairs setObject:[[NSUUID UUID]UUIDString] forKey:KEY_USERNAME];
        [userNamePasswordKVPairs setObject:@"password" forKey:KEY_PASSWORD];
        
        //  将用户名和密码写入keychina
        [KeyChina save:KEY_USERNAME_PASSWORD data:userNamePasswordKVPairs];
        NSLog(@"保存成功");
    }else if (index == 1){
        
        //  从keychain中读取用户名和密码
        NSMutableDictionary *readUsernamePassword = (NSMutableDictionary *)[KeyChina load:KEY_USERNAME_PASSWORD];
        NSString *userName = [readUsernamePassword objectForKey:KEY_USERNAME];
        NSString *password = [readUsernamePassword objectForKey:KEY_PASSWORD];
        
        NSLog(@"username = %@",userName);
        NSLog(@"password = %@",password);
    }else if (index == 2){
        //  将用户名和密码从keyChina中删除
        [KeyChina delete:KEY_USERNAME_PASSWORD];
        NSLog(@"删除成功");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
