//
//  XFFileListViewController.h
//  XFFile
//
//  Created by wangxuefeng on 16/6/12.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFFileListViewController : UIViewController

@property (copy  , nonatomic) NSString *path;

@property (assign, nonatomic) BOOL recursive;

+ (XFFileListViewController *)createWithDirectory:(NSString *)path;

+ (XFFileListViewController *)createWithDirectory:(NSString *)path recursive:(BOOL)recursive;

@end
