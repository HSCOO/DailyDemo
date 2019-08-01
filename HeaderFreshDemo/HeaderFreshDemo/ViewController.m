//
//  ViewController.m
//  HeaderFreshDemo
//
//  Created by hscai on 2019/8/1.
//  Copyright © 2019 HSCOO. All rights reserved.
//

#import "ViewController.h"
#import "HomeModel.h"
#import <IGListKit/IGListKit.h>
#import "SectionController.h"

@interface ViewController ()<IGListAdapterDataSource, UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray <HomeModel *>*models;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IGListAdapter *adapter;

@property (assign, nonatomic) BOOL loading;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HomeModel *model = [HomeModel new];
    model.showActivity = NO;
    NSMutableArray *labels = [NSMutableArray array];
    for (NSInteger i = 0; i < 25; i++) {
        LabelModel *labelModel = [LabelModel new];
        labelModel.text = [NSString stringWithFormat:@"%ld",i];
        [labels addObject:labelModel];
    }
    model.texts = labels;
    
    [self.models addObject:model];
    
    self.adapter.dataSource = self;
    self.adapter.collectionView = self.collectionView;
    self.adapter.scrollViewDelegate = self;
}

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.models;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    return SectionController.new;
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{return  nil;}


#pragma mark - UIScrollViewDelegate -

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    CGFloat y = targetContentOffset->y;
    NSLog(@"y -- %f", y);
    if (!self.loading && y <= 10) {
        self.loading = YES;
        HomeModel *model = [HomeModel new];
        model.showActivity = NO;
        
        [self.models addObject:model];
    }
}

- (IGListAdapter *)adapter{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self];
    }
    return _adapter;
}

- (NSMutableArray<HomeModel *> *)models{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end
