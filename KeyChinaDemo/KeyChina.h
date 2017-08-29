//
//  KeyChina.h
//  KeyChinaDemo
//
//  Created by 苗建浩 on 2017/8/14.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface KeyChina : NSObject

//  用keyChina去保护用户名和密码
+ (void)save:(NSString *)service data:(id)data;

//  从keyChina取出用户名和密码
+ (id)load:(NSString *)service;

//  从keyChina中删除用户名和密码
+ (void)delete:(NSString *)sevice;

@end
