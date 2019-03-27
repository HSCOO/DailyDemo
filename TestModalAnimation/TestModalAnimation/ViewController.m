//
//  ViewController.m
//  TestModalAnimation
//
//  Created by hscai on 2019/3/27.
//  Copyright © 2019 YJL. All rights reserved.
//

#import "ViewController.h"
#import "OneModalViewController.h"
#import "OneModalPresentationController.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CALayer *rectLayer = [[CALayer alloc] init];
    rectLayer.frame = CGRectMake(100, 100, 200, 200);
    rectLayer.backgroundColor = [[UIColor blackColor] CGColor];
    [self.view.layer addSublayer:rectLayer];
    
    NSTimeInterval duration = 0.8;
    CAKeyframeAnimation *animationRo = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animationRo.autoreverses = NO;
    animationRo.duration = duration;
    // 设置关键帧位置
    animationRo.values = @[
                           @(DEGREES_TO_RADIANS(0.0)),
                           @(DEGREES_TO_RADIANS(15.0)),
                           @(DEGREES_TO_RADIANS(-5.0)),
                           @(DEGREES_TO_RADIANS(1.0)),
                           @(DEGREES_TO_RADIANS(0.0))
                           ];
    
    animationRo.keyTimes = @[
                             [NSNumber numberWithFloat:0.0],
                             [NSNumber numberWithFloat:0.0],
                             [NSNumber numberWithFloat:duration * 0.6],
                             [NSNumber numberWithFloat:duration * 0.2],
                             [NSNumber numberWithFloat:duration * 0.2]
                             ];
    
    animationRo.timingFunctions = @[
                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                    ];
    
    // Y轴、旋转关键帧动画组合
    //    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    //    groupAnimation.beginTime = CACurrentMediaTime();
    //    groupAnimation.duration = duration;
    //    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //    groupAnimation.removedOnCompletion = YES;
    //    groupAnimation.animations = [NSArray arrayWithObjects:animationRo,nil];
    //    [toView.layer addAnimation:groupAnimation forKey:@"moveToCenter"];
    
    
    
    [rectLayer addAnimation:animationRo forKey:@"rxx"];
}

- (IBAction)kaClick:(id)sender {
    
    OneModalViewController *oneModalVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OneModalViewController"];
    
    OneModalPresentationController *oneModalPresent = [[OneModalPresentationController alloc] initWithPresentedViewController:oneModalVC presentingViewController:self];
    oneModalVC.transitioningDelegate = oneModalPresent;
    
    [self presentViewController:oneModalVC animated:YES completion:nil];
    
}

@end
