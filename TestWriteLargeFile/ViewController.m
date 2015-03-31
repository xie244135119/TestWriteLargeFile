//
//  ViewController.m
//  Test发文件写入本地的操作
//
//  Created by SunSet on 15-3-30.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import "ViewController.h"
#import "AASTool.h"

@interface ViewController ()
{
    AASTool *_currentTool;          //当前工具
}
@end

@implementation ViewController

- (void)dealloc
{
    _currentTool = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)clickAction:(id)sender
{
    //在线程中执行相应事件
    [self performSelector:@selector(testWriteFile) onThread:[ViewController singleThread] withObject:nil waitUntilDone:NO];
}


#pragma mark - 相应事件
- (void)testWriteFile
{
    //当前在子线程中执行的
    AASTool *tool = [[AASTool alloc]init];
    NSString *resourcepath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"test.mp3"];
    NSString *writepath = [NSHomeDirectory() stringByAppendingString:@"/Documents/test2.mp3"];
    [tool testFileHandleWithResourcePath:resourcepath writePath:writepath];
}


+ (NSThread *)singleThread
{
    static NSThread *_thread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _thread = [[NSThread alloc]initWithTarget:self selector:@selector(initWithThread) object:nil];
        [_thread start];
    });
    return _thread;
}


+ (void)initWithThread
{
    @autoreleasepool {
        //设置线程名称
        [[NSThread currentThread] setName:@"TestThread"];
        
        //启动runloop
        [[NSRunLoop currentRunLoop] run];
    }
}


@end














