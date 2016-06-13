//
//  AppDelegate.m
//  XFFile
//
//  Created by wangxuefeng on 16/6/12.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "AppDelegate.h"
#import "XFFileManager.h"
#import "XFFileListViewController.h"

@interface AppDelegate ()

@property (copy  , nonatomic) NSString *path;

@property (assign, nonatomic) BOOL recursive;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.path = [XFFileManager documentPath];
    
    XFFileListViewController *c = [XFFileListViewController createWithDirectory:self.path];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:c];
    
    self.window.rootViewController = nav;
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    NSLog(@"%s %@",__func__,url.absoluteString);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"收到新文件" message:url.absoluteString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    
    [alertView show];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    NSLog(@"%s %@",__func__,url);
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"收到新文件" message:url.absoluteString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    
    [alertView show];
    
    BOOL success = [[NSFileManager defaultManager] copyItemAtPath:url.absoluteString toPath:self.path error:nil];
    
    NSLog(@"success is %d",success);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNoti_RecieveNewFile object:nil];
    
    return YES;
}


@end
