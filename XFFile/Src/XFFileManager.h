//
//  XFFileManager.h
//  XFFile
//
//  Created by wangxuefeng on 16/6/12.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFFileManager : NSObject

+ (NSArray *)fileList;

+ (NSString*)documentPath;

+ (NSString*)libraryPath;

+ (NSString*)temporaryPath;


@end
