//
//  ViewController.m
//  TestSDCycScrollView
//
//  Created by hscai on 2019/4/2.
//  Copyright © 2019 YJL. All rights reserved.
//

#import "ViewController.h"
#import "SDCycleScrollView.h"

@interface ViewController ()<SDCycleScrollViewDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;
@property (assign, nonatomic) CGPoint point;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *str = @"1213";
    [str rangeOfCharacterFromSet:@""];
    
    [self.view addSubview:self.cycleScrollView];
}

- (void)tapClick{
    // 手势不处理
    NSLog(@"tapClick");
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 根据当前点击，获取坐标
    CGPoint point = [touch locationInView:self.cycleScrollView];
    NSLog(@"point.x -- %f point.y -- %f", point.x, point.y);
    
    // 不响应手势
    if ([touch.view.superview isKindOfClass:NSClassFromString(@"SDCollectionViewCell")]) {
        return NO;
    }
    return YES;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    NSLog(@"didScroll");
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"didSelect");
}

- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        CGRect rect = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect delegate:self placeholderImage:nil];
        _cycleScrollView.autoScroll = NO;
        _cycleScrollView.pageControlDotSize = CGSizeMake(3, 3);
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.currentPageDotColor = [UIColor redColor];
        _cycleScrollView.pageDotColor = [UIColor whiteColor];
        _cycleScrollView.layer.cornerRadius = 10;
        _cycleScrollView.layer.masksToBounds = YES;
        _cycleScrollView.imageURLStringsGroup = @[
                                                  @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1554170610&di=27fc12f6558851c33383b0b76b4b79b4&src=http://image.biaobaiju.com/uploads/20180917/22/1537195508-PziHEGlsdF.jpg",
                                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1554180695015&di=6b8c27da41c56c3d757f493915a2101c&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F9922720e0cf3d7ca0607b47ff41fbe096a63a9c2.jpg"
                                                  ];
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        tap.delegate = self;
        [_cycleScrollView addGestureRecognizer:tap];
    }
    return _cycleScrollView;
}

@end
