//
//  ViewController.m
//  GCD_Basic_Concept
//
//  Created by LV on 16/5/9.
//  Copyright © 2016年 lvhongyang. All rights reserved.
// 原地址博客：https://github.com/ChenYilong/ParseSourceCodeStudy/blob/master/01_Parse%E7%9A%84%E5%A4%9A%E7%BA%BF%E7%A8%8B%E5%A4%84%E7%90%86%E6%80%9D%E8%B7%AF/GCD%E6%89%AB%E7%9B%B2%E7%AF%87.md
// 我的笔记：http://www.cnblogs.com/R0SS/p/5460791.html

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
/************************************************************************************/
#pragma mark - 自定义串行队列
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.serialQueue.lv", DISPATCH_QUEUE_SERIAL);
    
#if 0 //【1.1】*> 自定义串行队列 - 异步
    /**
     *  自定义的串行队列异步，会新建一个线程thread
     */
    dispatch_async(serialQueue, ^{
        NSLog(@"-1 %@",[NSThread currentThread]);
        sleep(4); // 跟自定义并行队列 - 异步的sleep比较一下。理解到了他俩在任务执行的不同了吧。
    });
    NSLog(@"2 %@",[NSThread currentThread]);
    dispatch_async(serialQueue, ^{
        NSLog(@"-3 %@",[NSThread currentThread]);
    });
    NSLog(@"4 %@",[NSThread currentThread]);
#endif
    
#if 0 //【1.2】*> 自定义串行队列 - 同步
    /**
     *  自定义串行队列同步，不会新建一个线程，使用当前线程，例如:main_thread
     */
    dispatch_sync(serialQueue, ^{
        NSLog(@"-1 %@",[NSThread currentThread]);
        sleep(1);
    });
    NSLog(@"2 %@",[NSThread currentThread]);
    dispatch_sync(serialQueue, ^{
        NSLog(@"-3 %@",[NSThread currentThread]);
    });
    NSLog(@"4 %@",[NSThread currentThread]);
#endif
    
    /************************************************************************************/
#pragma mark - 自定义并行队列
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.concurrentQueue.lv", DISPATCH_QUEUE_CONCURRENT);
    
#if 0 //【2.1】*> 自定义并行队列 - 异步
    /**
     *  自定义并行队列异步，会创建线程，可以开多条线程，iOS7.0一般是5、6条，iOS8.0以后可以达到50、60条
     */
    dispatch_async(concurrentQueue, ^{
        NSLog(@"-1 %@",[NSThread currentThread]);
        sleep(2); //注释或者不注释试试，思考之后对dispatch更加理解
    });
    NSLog(@"2 %@",[NSThread currentThread]);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"-3 %@",[NSThread currentThread]);
    });
    NSLog(@"4 %@",[NSThread currentThread]);
#endif
    
#if 1 //【2.2】*> 自定义并行队列 - 同步
    /**
     *  自定义并行队列同步，不会创建线程。
     */
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"-1 %@",[NSThread currentThread]);
        sleep(4);
    });
    NSLog(@"2 %@",[NSThread currentThread]);
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"-3 %@",[NSThread currentThread]);
    });
    NSLog(@"4 %@",[NSThread currentThread]);
#endif
    
    /************************************************************************************/
#pragma mark - 主队列
#if 0 //3.1*> 主队列 - 同步 - 死循环
    NSLog(@"1 %@",[NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"-2%@",[NSThread currentThread]); // 当前这个NSLog打印任务，一直等着主队列中主线程总的任务执行完才可以执行，但是主线程的任务执行不完，所以就一直等着，然后就死循环了。
    });
    NSLog(@"3 %@",[NSThread currentThread]);
#endif
    
#if 0 //3.2*> 跟自定义串行队列的异步效果一样。
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"-1 %@",[NSThread currentThread]);
        sleep(4);
    });
    NSLog(@"2 %@",[NSThread currentThread]);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"-3 %@",[NSThread currentThread]);
    });
    NSLog(@"4 %@",[NSThread currentThread]);
#endif
}


@end

