//
//  AnimationManager.m
//  TranslationAnimation
//
//  Created by OnlyStu on 2017/5/9.
//  Copyright © 2017年 OnlyStu. All rights reserved.
//

#import "AnimationManager.h"


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
@interface AnimationManager()<CAAnimationDelegate>
#else
@interface AnimationManager()
#endif

@property (strong, nonatomic) UIView *animaView;
@property (assign, nonatomic) CGPoint startOffsetPoint;
@property (assign, nonatomic) CGPoint currentOffsetPoint;
@property (copy, nonatomic) void (^finsh)(void);

@end

@implementation AnimationManager

static  AnimationManager*_instance;

- (void)animationTranslation:(UIView *)animaView duration:(CGFloat)duration tx:(CGFloat)tx ty:(CGFloat)ty finish:(void (^ __nullable)(void))finish{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    anima.duration = duration;
    anima.delegate = self;
    //记录上次的值，确保再次运行时不会重复
    self.currentOffsetPoint = CGPointMake(tx - self.startOffsetPoint.x, ty - self.startOffsetPoint.y);
    self.animaView = animaView;
    
    if (self.startOffsetPoint.x != tx) {
        self.startOffsetPoint = CGPointMake(tx,ty);
    }
    anima.toValue = [NSValue valueWithCGPoint:self.currentOffsetPoint];
    
    [self.animaView.layer addAnimation:anima forKey:@"translation"];
    
    if (finish) {
        self.finsh = finish;
    }
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    CGPoint tempPoint = self.animaView.frame.origin;
    CGSize tempSize = self.animaView.frame.size;
    [self.animaView.layer removeAnimationForKey:@"translation"];
    //给view重新赋值坐标
    self.animaView.frame = CGRectMake(tempPoint.x + self.currentOffsetPoint.x, tempPoint.y + self.currentOffsetPoint.y, tempSize.width, tempSize.height);
    
    if (self.finsh) {
        self.finsh();
    }
}


@end
