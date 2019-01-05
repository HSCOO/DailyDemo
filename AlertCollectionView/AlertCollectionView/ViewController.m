//
//  ViewController.m
//  AlertCollectionView
//
//  Created by dage on 2019/1/5.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "ViewController.h"
#import "KindView.h"
#import "Masonry.h"

@interface ViewController ()

@property (strong, nonatomic) KindView *kindView;
@property (strong, nonatomic) UIButton *addBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.width.offset(80);
        make.height.offset(40);
    }];
    
    [self.view addSubview:self.kindView];
}

- (void)click{

    [UIView animateKeyframesWithDuration:0.6 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        self.kindView.frame = CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 300);
    } completion:nil];
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        [_addBtn setTitle:@"Add" forState:UIControlStateNormal];
        _addBtn.backgroundColor = [UIColor yellowColor];
        _addBtn.layer.cornerRadius = 20;
        _addBtn.layer.masksToBounds = YES;
        [_addBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (KindView *)kindView{
    if (!_kindView) {
        _kindView = [[KindView alloc] initWithFrame:CGRectMake(0, 40 - 300, [UIScreen mainScreen].bounds.size.width, 300)];
    }
    return _kindView;
}

@end
