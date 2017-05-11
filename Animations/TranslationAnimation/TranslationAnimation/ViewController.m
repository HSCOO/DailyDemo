//
//  ViewController.m
//  TranslationAnimation
//
//  Created by OnlyStu on 2017/5/8.
//  Copyright © 2017年 OnlyStu. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "AnimationManager.h"

@interface ViewController ()

@property (strong, nonatomic)UIButton *magentaBtn;
@property (strong, nonatomic)UIButton *greenBtn;
@property (strong, nonatomic)AnimationManager *manager1;
@property (strong, nonatomic)AnimationManager *manager2;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self animaView];
}

- (void)animaView{

    _greenBtn = [[UIButton alloc]init];
    _greenBtn.backgroundColor = [UIColor greenColor];
    [_greenBtn addTarget:self action:@selector(greenBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_greenBtn];
    
    _magentaBtn = [[UIButton alloc]init];
    _magentaBtn.backgroundColor = [UIColor magentaColor];
    [_magentaBtn addTarget:self action:@selector(magentaBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_magentaBtn];
    
    
    UIButton *changeBtn = [[UIButton alloc]init];
    [changeBtn setTitle:@"moving" forState:UIControlStateNormal];
    changeBtn.backgroundColor = [UIColor orangeColor];
    [changeBtn addTarget:self action:@selector(changeTranslation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
    
    [_greenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(50);
        make.height.width.offset(50);
    }];
    
    [_magentaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(_greenBtn);
        make.left.equalTo(_greenBtn.mas_right).offset(20);
    }];
    
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view).offset(-20);
        make.left.equalTo(self.view).offset(20);
    }];
    
    _manager1 = [[AnimationManager alloc]init];
    _manager2 = [[AnimationManager alloc]init];
}

- (void)changeTranslation{

//    [self normalAnimation];
//    [self viewAnimation];
    [self customAnimation];
}


- (void)viewAnimation{
    [UIView animateWithDuration:2 animations:^{
        _magentaBtn.transform = CGAffineTransformMakeTranslation(100, 100);
    } completion:nil];
}

- (void)customAnimation{
//    [_manager1 animationTranslation:_magentaBtn duration:2 tx:100 ty:100 finish:^{
//        [_manager2 animationTranslation:_magentaBtn duration:3 tx:10 ty:20 finish:nil];
//    }];
    [_manager1 animationTranslation:_magentaBtn duration:2 tx:100 ty:100 finish:nil];
}

- (void)normalAnimation{

    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    anima.duration = 2;
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    
    [_magentaBtn.layer addAnimation:anima forKey:nil];
}

- (void)greenBtnClick{
    NSLog(@"%s",__func__);
}

- (void)magentaBtnClick{
    NSLog(@"%s",__func__);
}


@end
