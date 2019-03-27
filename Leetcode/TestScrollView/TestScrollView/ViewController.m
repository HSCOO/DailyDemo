//
//  ViewController.m
//  TestScrollView
//
//  Created by hscai on 2019/3/26.
//  Copyright © 2019 YJL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height - 100)];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor yellowColor];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height + 100)];
    [scrollView addSubview:redView];
    redView.backgroundColor = [UIColor redColor];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(width, 0, width, height + 100)];
    [scrollView addSubview:blueView];
    blueView.backgroundColor = [UIColor blueColor];
    
    scrollView.contentSize = CGSizeMake(width * 2, height);
}


@end
