//
//  AASTool.h
//  Test发文件写入本地的操作
//
//  Created by SunSet on 15-3-30.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AASTool : NSObject

//
@property(nonatomic,weak) UISlider *slider;
@property(nonatomic,copy) NSString *readPath;           //读取地址
@property(nonatomic,copy) NSString *writePath;          //写入地址


//测试输出流
- (void)testOutputStreamWithResourcePath:(NSString *)path writePath:(NSString *)writepath;

//测试filehandle
- (void)testFileHandleWithResourcePath:(NSString *)path writePath:(NSString *)writepath;

@end
