//
//  AASTool.m
//  Test发文件写入本地的操作
//
//  Created by SunSet on 15-3-30.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#define TTMaxLength 1024    //每次1kb

#import "AASTool.h"

@implementation AASTool
{
    NSOutputStream *_currentOutputStream;     //当前输出流
}


- (void)dealloc
{
    NSLog(@" 工具 deallc ");
}


- (void)testOutputStreamWithResourcePath:(NSString *)path writePath:(NSString *)writepath
{
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    NSOutputStream *stream = [[NSOutputStream alloc]initToFileAtPath:path append:YES];
    
    [stream open];
    NSInteger length = 0;
    while (length <= data.length) {
        uint8_t *byte = nil;
        [data getBytes:&byte range:NSMakeRange(length, TTMaxLength)];
        [stream write:byte maxLength:TTMaxLength];
        length += TTMaxLength;
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _slider.value = (CGFloat)length/data.length;
//        });
        NSLog(@" 写入中 %f",(CGFloat)length/data.length);
    }
    [stream close];
    
}



- (void)testFileHandleWithResourcePath:(NSString *)path writePath:(NSString *)writepath
{
    //读取文件
    NSFileHandle *readhandle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSError *error = nil;;
    NSDictionary *attribute = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
//    NSLog(@"%@",attribute);
    
    //写入文件
//    NSFileHandle *writehandel = [NSFileHandle fileHandleForWritingAtPath:writepath];
//    [writehandel writeData:nil];
//  [attribute[NSFileSize] longValue]
    NSLog(@" 文件大小多少%fM ",(CGFloat)[attribute[NSFileSize] longValue]/(1024*1024));
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:writepath]) {
        NSOutputStream *stream = [[NSOutputStream alloc]initToFileAtPath:writepath append:YES];
        [stream open];
        
        long long totalSize = [attribute[NSFileSize] longLongValue];
        NSInteger length = 0;
        while (length <= totalSize) {
            [readhandle seekToFileOffset:length];
            NSData *data = [readhandle readDataOfLength:TTMaxLength];
            [stream write:[data bytes] maxLength:TTMaxLength];
            length += TTMaxLength;

            //线程通讯
            [self performSelectorOnMainThread:@selector(setSliderValue:) withObject:@((CGFloat)length/totalSize)  waitUntilDone:NO];
        }
        
        [stream close];
    }
}


- (void)setSliderValue:(NSNumber *)value
{
    NSLog(@" 写入中 %@",value);
}



@end













