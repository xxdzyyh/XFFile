//
//  XFFileListViewController.m
//  XFFile
//
//  Created by wangxuefeng on 16/6/12.
//  Copyright © 2016年 wangxuefeng. All rights reserved.
//

#import "XFFileListViewController.h"

@interface XFFileListViewController () <UITableViewDelegate, UITableViewDataSource, UIDocumentInteractionControllerDelegate>

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) UIDocumentInteractionController *docInteractionController;

@end

@implementation XFFileListViewController

#pragma mark - init 

-(instancetype)initWithDirectory:(NSString *)path recursive:(BOOL)recursive {
    
    self = [super init];
    
    if (self) {
        
        _path = path;
        _recursive = recursive;
    }
    return self;
}

+ (XFFileListViewController *)createWithDirectory:(NSString *)path {
    XFFileListViewController *c = [[XFFileListViewController alloc] initWithDirectory:path recursive:YES];
    
    return c;
}

+ (XFFileListViewController *)createWithDirectory:(NSString *)path recursive:(BOOL)recursive {
    
    XFFileListViewController *c = [[XFFileListViewController alloc] initWithDirectory:path recursive:recursive];
    
    return c;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray arrayWithArray:[self urlsAtPath:self.path recursive:self.recursive]];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *path = self.dataSource[indexPath.row];
    
    [self openFileAtPath:path];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
       
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    NSString *fileName = [self.dataSource[indexPath.row] lastPathComponent];
    
    cell.textLabel.text = fileName;
    
    cell.detailTextLabel.text = [fileName pathExtension];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController {
    return self;
}

#pragma mark - private method

- (void)openFileAtPath:(NSString *)path {
    [self setupDocumentControllerWithURL:[NSURL fileURLWithPath:path]];
    
    BOOL canOpen = [self.docInteractionController presentPreviewAnimated:YES];
    if (!canOpen) {
//        [SVProgressHUD showErrorWithStatus:@"该类型文件无法打开"];
        
        NSLog(@"%@",@"该类型文件无法打开");
    }
}

- (void)setupDocumentControllerWithURL:(NSURL *)url
{
    //checks if docInteractionController has been initialized with the URL
    if (self.docInteractionController == nil)
    {
        self.docInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.docInteractionController.delegate = self;
    }
    else
    {
        self.docInteractionController.URL = url;
    }
}

- (NSArray *)urlsAtPath:(NSString *)path  recursive:(BOOL)recursive {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    NSArray *array;
    
    NSMutableArray *urls = [NSMutableArray array];
    
    if (recursive) {
        array = [fileManager subpathsOfDirectoryAtPath:path error:&error];
    } else {
        array = [fileManager contentsOfDirectoryAtPath:path error:&error];
    }
    
    for (NSString *obj in array) {
        
        NSString *url = [path stringByAppendingPathComponent:obj];
        
        BOOL b;
        
        [fileManager fileExistsAtPath:url isDirectory:&b];
        
        if (recursive && !b) {
            [urls addObject:url];
        }
    }
    
    array = urls;
    
    if (error) {
        NSLog(@"%@",error.description);
    }
    
    if (array.count == 0) {
        NSLog(@"文件夹下没有文件");
    }
    
    return array;
}

#pragma mark - setter & getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
