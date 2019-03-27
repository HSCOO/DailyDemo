//
//  OneModalPresentationController.m
//  TestModalAnimation
//
//  Created by hscai on 2019/3/27.
//  Copyright © 2019 YJL. All rights reserved.
//

// 角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#import "OneModalPresentationController.h"

@interface OneModalPresentationController()
<
UIViewControllerAnimatedTransitioning
>

@property (strong, nonatomic) UIView *bgView;

@end

@implementation OneModalPresentationController


#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}


#pragma mark - 重写

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        // 设置自定义动画效果
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

#pragma mark - 背景透明度的变化

- (void)presentationTransitionWillBegin{
    // 添加背景
    [self.containerView addSubview:self.bgView];

    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    self.bgView.alpha = 0.f;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.bgView.alpha = 0.4f;
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed{
    if (completed) {
        return;
    }
    self.bgView = nil;
}

- (void)dismissalTransitionWillBegin{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.bgView.alpha = 0.f;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed{
    if (!completed) {
        return;
    }
    [self.bgView removeFromSuperview];
    self.bgView = nil;
}

#pragma mark - 计算目标控制器的view的大小

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize{
    
    CGSize finalSize = CGSizeZero;
    if (container == self.presentingViewController) {
        finalSize = ((UIViewController *) container).preferredContentSize;
    }
    else{
        finalSize = [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
    }

    return finalSize;
}

- (CGRect)frameOfPresentedViewInContainerView{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContenSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size.height = presentedViewContenSize.height;
    presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContenSize.height;
    
    return presentedViewControllerFrame;
}

- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    self.bgView.frame = self.containerView.bounds;
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container != self.presentedViewController) {
        return;
    }
    
    [self.containerView setNeedsLayout];
}

#pragma mark - 动画实现

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return [transitionContext isAnimated] ? 0.4 : 0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    __unused UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = transitionContext.containerView;

    // 2. 获取源控制器、目标控制器 的View，但是注意二者在开始动画，消失动画，身份是不一样的：
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];

    [containerView addSubview:toView];  //必须添加到动画容器View上。

    // 判断是present 还是 dismiss
    BOOL isPresenting = (fromViewController == self.presentingViewController);

    CGFloat screenW = CGRectGetWidth(containerView.bounds);
    CGFloat screenH = CGRectGetHeight(containerView.bounds);

    // 左右留35
    // 上下留80

    // 屏幕顶部：
    CGFloat w = 400;
    CGFloat h = 400;
    CGFloat x = (screenW - w ) / 2;
    CGFloat y = 40;
    CGRect topFrame = CGRectMake(x, y, w, h);
    toView.frame = topFrame;

    // 屏幕中间：
    CGRect centerFrame = CGRectMake(x, (screenH - h ) / 2, w, h);

    // 屏幕底部
    CGRect bottomFrame = CGRectMake(x, screenH + h, w, h);  //加10是因为动画果冻效果，会露出屏幕一点


    NSTimeInterval duration = [self transitionDuration:transitionContext];
    // 复合动画
    
    // Y轴上的滑动 到 中间
    CABasicAnimation *animationY = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    animationY.fromValue = @(0);
    animationY.toValue = @((screenH - h ) / 2);
    animationY.removedOnCompletion = NO;
//    animationY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animationY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animationY.duration = duration;
    animationY.fillMode = kCAFillModeForwards;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration + 0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        toView.frame = centerFrame;
    });
    
    // Y轴的关键帧动画
//    CAKeyframeAnimation *animationY = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    animationY.autoreverses = NO;
//    animationY.duration = duration;
//    animationY.removedOnCompletion = NO;
////    animationY.fillMode = kCAFillModeForwards;
//
//    animationY.values = @[
//                          [NSValue valueWithCGPoint:toView.frame.origin],
//                          [NSValue valueWithCGPoint:CGPointMake(toView.frame.origin.x, toView.frame.origin.y + 400)],
//                          ];
//    animationY.keyTimes = @[
//                            [NSNumber numberWithFloat:0.0],
//                            [NSNumber numberWithFloat:duration],
//                            ];
//
//    animationY.timingFunctions = @[
//                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
//                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]
//                                    ];
    
    
    
    // 旋转的关键帧动画
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
    
    
    [toView.layer addAnimation:animationRo forKey:@"ro"];
    [toView.layer addAnimation:animationY forKey:@"y"];
    
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.animations = @[animationY,animationRo];
//    group.removedOnCompletion = NO;
//    group.duration = duration;
//
//    [toView.layer addAnimation:group forKey:@"rxx"];
    // 结束
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    });
    
    
    
//    if (isPresenting) {
//        // 开始状态
//        toView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(15.0));
//        toView.frame = topFrame;
//    }
//
//
//
//    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.75f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseIn animations:^{
//
//        if (isPresenting){
//
//            toView.frame = centerFrame;
//        }else{
//
//            fromView.transform = CGAffineTransformMakeRotation(-M_1_PI * 0.75);
//            fromView.frame = bottomFrame;
//        }
//
//    } completion:^(BOOL finished) {
//        BOOL wasCancelled = [transitionContext transitionWasCancelled];
//        [transitionContext completeTransition:!wasCancelled];
//    }];
//
//    if (!isPresenting) {
//        return;
//    }
//
//    // 角度摆动
//    [UIView animateWithDuration:duration * 0.6 animations:^{
//        toView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-5.0));
//    } completion:^(BOOL finished) {
//
//        [UIView animateWithDuration:duration * 0.2 animations:^{
//            toView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(1.0));
//        } completion:^(BOOL finished) {
//
//            [UIView animateWithDuration:duration * 0.2 animations:^{
//                toView.transform = CGAffineTransformMakeRotation(0.0);
//            } completion:nil];
//        }];
//    }];

}

- (void)animationEnded:(BOOL) transitionCompleted{
    // 动画结束...
}

#pragma mark - getter

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.userInteractionEnabled = YES;
        _bgView.opaque = NO;
        _bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDismiss)];
        [_bgView addGestureRecognizer:tap];
    }
    return _bgView;
}

- (void)tapDismiss{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
