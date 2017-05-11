//
//  AnimationManager.h
//  TranslationAnimation
//
//  Created by OnlyStu on 2017/5/9.
//  Copyright © 2017年 OnlyStu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AnimationManager : NSObject

- (void)animationTranslation:(UIView *)animaView duration:(CGFloat)duration tx:(CGFloat)tx ty:(CGFloat)ty finish:(void (^ __nullable)(void))finish;

@end
