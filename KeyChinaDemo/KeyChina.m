//
//  KeyChina.m
//  KeyChinaDemo
//
//  Created by 苗建浩 on 2017/8/14.
//  Copyright © 2017年 苗建浩. All rights reserved.
//

#import "KeyChina.h"

@implementation KeyChina

+ (NSMutableDictionary *)getKeyChinaAuery:(NSString *)service{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword, (id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,
            (id)kSecAttrAccessible,
            nil];
}


//  写入
+ (void)save:(NSString *)service data:(id)data{
    //  Get search dictionary
    NSMutableDictionary *keyChinaQuery = [self getKeyChinaAuery:service];
    //  Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keyChinaQuery);
    //  Add new object to search diction
    [keyChinaQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //  Add item to keychina
    SecItemAdd((CFDictionaryRef)keyChinaQuery, NULL);
    
}

//  读取
+ (id)load:(NSString *)service{
    
    id ret = nil;
    NSMutableDictionary *keyChinaQuery = [self getKeyChinaAuery:service];
    
    [keyChinaQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keyChinaQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keyChinaQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *exception) {
            NSLog(@"ddddd %@    %@",service, exception);
        } @finally {
            
        }
    }
    
    if (keyData) {
        CFRelease(keyData);
    }
    return ret;
}

//  删除
+ (void)delete:(NSString *)sevice{
    NSMutableDictionary *keyChinaQuery = [self getKeyChinaAuery:sevice];
    SecItemDelete((CFDictionaryRef)keyChinaQuery);
}

@end
