//
//  RedView.m
//  TestOutOfSuperView
//
//  Created by hscai on 2019/3/25.
//  Copyright © 2019 YJL. All rights reserved.
//

#import "RedView.h"

@implementation RedView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {

        for (UIView *subView in self.subviews) {
            // 转换坐标系
            CGPoint newPoint = [subView convertPoint:point fromView:self];
            // 判断触摸点是否在button上
            if (CGRectContainsPoint(subView.bounds, newPoint)) {
                return subView;
            }
        }
    }
    return view;
}


@end
