//
//  ViewController.m
//  UseLogDemo
//
//  Created by OnlyStu on 2017/3/10.
//  Copyright © 2017年 OnlyStu. All rights reserved.
//

#import "ViewController.h"
#import <Log/Log.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    LogManager *manager = [[LogManager alloc]init];
    [manager log:@"12"];
    
}



@end
