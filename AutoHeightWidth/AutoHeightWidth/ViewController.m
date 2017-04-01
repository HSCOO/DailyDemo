//
//  ViewController.m
//  AutoHeightWidth
//
//  Created by OnlyStu on 2017/3/20.
//  Copyright © 2017年 OnlyStu. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"



@interface ViewController ()

@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIView *redView;
@property (nonatomic, strong)UIView *yellowView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testAutoWidthView];
}

- (void)testAutoWidthView{

    _bgView = [[UIView alloc]init];
    _bgView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_bgView];
    
    _redView = [[UIView alloc]init];
    _redView.backgroundColor = [UIColor redColor];
    
    _yellowView = [[UIView alloc]init];
    _yellowView.backgroundColor = [UIColor yellowColor];
    
    [_bgView addSubview:_redView];
    [_bgView addSubview:_yellowView];
    

    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(self.view).offset(100);
    }];
    
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(_bgView).offset(20);
        make.width.height.offset(200);
     
    }];
    
    [_yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.width.height.equalTo(_redView);
        make.top.equalTo(_redView.mas_bottom).offset(20);
      
    }];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_redView layoutIfNeeded];
    NSLog(@"width----%f",_redView.bounds.size.width);
}



@end
