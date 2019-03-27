//
//  OneModalViewController.m
//  TestModalAnimation
//
//  Created by hscai on 2019/3/27.
//  Copyright © 2019 YJL. All rights reserved.
//

#import "OneModalViewController.h"

@interface OneModalViewController ()

@end

@implementation OneModalViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
