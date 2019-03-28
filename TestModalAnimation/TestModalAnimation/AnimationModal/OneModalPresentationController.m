//
//  OneModalPresentationController.m
//  TestModalAnimation
//
//  Created by hscai on 2019/3/27.
//  Copyright © 2019 YJL. All rights reserved.
//

// 角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define DURATION 0.8

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
        [UIView animateWithDuration:DURATION animations:^{
            self.bgView.alpha = 0.4f;
        }];
        
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
        
        [UIView animateWithDuration:DURATION animations:^{
            self.bgView.alpha = 0.f;
        }];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DURATION * NSEC_PER_SEC + 0.01)), dispatch_get_main_queue(), ^{
//            self.bgView.alpha = 0.f;
//        });
        
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed{
    if (!completed) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(DURATION * NSEC_PER_SEC + 0.01)), dispatch_get_main_queue(), ^{
        
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    });
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
    return [transitionContext isAnimated] ? DURATION : 0;
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
    
    CGFloat x = 30;
    CGFloat y = -1 * SCREEN_HEIGHT;
    CGFloat w = SCREEN_WIDTH - x * 2;
    CGFloat h = SCREEN_HEIGHT - 30 * 2;
    CGRect topFrame = CGRectMake(x, y, w, h);
    
    // 屏幕中间：
    CGRect centerFrame = CGRectMake(x, (SCREEN_HEIGHT - h) / 2, w, h);
    
    // 屏幕底部
    CGRect bottomFrame = CGRectMake(x, SCREEN_HEIGHT + 20, w, h);
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (isPresenting) {
        
        toView.frame = topFrame;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            toView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(15.0));
        });
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            toView.frame = centerFrame;
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
        
        [UIView animateWithDuration:duration*0.6 animations:^{
            toView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(-5.5), 0, 0, 0);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:duration*0.2 animations:^{
                toView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(1.0));
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:duration*0.2 animations:^{
                    toView.transform = CGAffineTransformMakeRotation(0.0);
                } completion:nil];
            }];
        }];
        
    }
    else{
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:10.f initialSpringVelocity:0.1f options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            fromView.frame = bottomFrame;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                fromView.transform = CGAffineTransformMakeRotation(M_1_PI * 0.75);
            });
            
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }

    // 屏幕顶部：
//    CGFloat w = SCREEN_WIDTH;
//    CGFloat h = SCREEN_WIDTH;
//    CGFloat x = 0;
//    CGFloat y = 0;
//    CGRect topFrame = CGRectMake(x, y, w, h);
//    // 设置开始位置，在屏幕外
//    toView.frame = topFrame;
//
//    // 屏幕中间：
//    CGRect centerFrame = CGRectMake(x, (SCREEN_HEIGHT - h ) / 2, w, h);
//
//    CGRect bottomFrame = CGRectMake(x, SCREEN_HEIGHT + h, w, h);
//
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//
//
//    // present动画
//    if (isPresenting) {
//
//        CAAnimationGroup *topToCenterGroup = [self topToCenterGroup:duration];
//        [toView.layer addAnimation:topToCenterGroup forKey:@"topToCenterGroup"];
//
//        CASpringAnimation *animationSpring = [CASpringAnimation animationWithKeyPath:@"position.y"];
//        animationSpring.fromValue = @(y);
//    //    animationSpring.toValue = @(SCREEN_WIDTH);
//        //阻力
//        animationSpring.damping = 15;
//        //初始速率
//        animationSpring.initialVelocity = 10;
//        //持续时间
//        animationSpring.duration = duration;
//
//        animationSpring.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//
//        animationSpring.removedOnCompletion = NO;
//        animationSpring.fillMode = kCAFillModeBoth;
//
//        [toView.layer addAnimation:animationSpring forKey:@"spring"];
//
//        // 动画结束后赋值最终位置，相当于设置了toValue
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration + 0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 赋值最终位置
//            toView.frame = centerFrame;
//        });
//
//    }
//    // dismiss动画
//    else{
//
//        CAAnimationGroup *centerToBottomGroup = [self centerToBottomGroup:duration];
//        [fromView.layer addAnimation:centerToBottomGroup forKey:@"centerToBottomGroup"];
//
//    }

    // 动画结束
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 模态动画完成，如果不实现这个方法，所有方法都不能接收
//        BOOL wasCancelled = [transitionContext transitionWasCancelled];
//        [transitionContext completeTransition:!wasCancelled];
//    });
}

- (void)animationEnded:(BOOL) transitionCompleted{
    // 动画结束...
}

#pragma mark - Animation Group Maker

- (CAAnimationGroup *)centerToBottomGroup:(NSTimeInterval)duration{
    // Y轴上的滑动 中间到底部
    CABasicAnimation *animationY = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animationY.toValue = @(SCREEN_HEIGHT * 3);
//    animationY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationY.duration = duration;
    
    // 旋转
    CABasicAnimation *animationRo = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animationRo.toValue = @(-M_1_PI * 0.75);
//    animationRo.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationRo.duration = duration;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animationY,animationRo];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;

    return group;
}

- (CAAnimationGroup *)topToCenterGroup:(NSTimeInterval)duration{
    
    // Y轴上的滑动 顶部到中间
    CABasicAnimation *animationY = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animationY.fromValue = @(-SCREEN_WIDTH);
    animationY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animationY.duration = duration;
    
    
    // 旋转的关键帧动画
    CAKeyframeAnimation *animationRo = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animationRo.duration = duration;
    // 设置关键帧位置
    animationRo.values = @[
                           @(DEGREES_TO_RADIANS(15.0)),
                           @(DEGREES_TO_RADIANS(-5.0)),
                           @(DEGREES_TO_RADIANS(1.0)),
                           @(DEGREES_TO_RADIANS(0.0))
                           ];
    
    animationRo.keyTimes = @[
                             [NSNumber numberWithFloat:0.0],
                             [NSNumber numberWithFloat:duration * 0.6],
                             [NSNumber numberWithFloat:duration * 0.2],
                             [NSNumber numberWithFloat:duration * 0.2]
                             ];
    
//    animationRo.timingFunctions = @[
//                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
//                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
//                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
//                                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
//                                    ];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    group.animations = @[animationRo];
    
    return group;
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
