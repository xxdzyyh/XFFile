//
//  XFFileManager.m
//  XFFile
//
//  Created by wangxuefeng on 16/6/12.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFFileManager.h"

@implementation XFFileManager

+ (NSArray *)fileList {
    
    [NSFileManager defaultManager] ;
    
    return nil;
}

+ (NSString *)documentPath {
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [paths lastObject];
}

+ (NSString *)libraryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    return [paths lastObject];
}

+ (NSString *)temporaryPath {
    
    return NSTemporaryDirectory();
}

+ (NSString *)cachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths lastObject];
}

@end
