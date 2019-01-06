//
//  WorkingRangeViewController.m
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/6.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "WorkingRangeViewController.h"
#import "WorkingRangeModel.h"
#import "WorkingRangeSectionController.h"

@interface WorkingRangeViewController ()<IGListAdapterDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IGListAdapter *adapter;
@property (strong, nonatomic)  NSArray<WorkingRangeModel *> *models;

@end

@implementation WorkingRangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    return nil;
}

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.models;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    return [WorkingRangeSectionController new];
}


- (IGListAdapter *)adapter{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self workingRangeSize:5];
    }
    return _adapter;
}
/**
 @[
 @"http://pic.sc.chinaz.com/files/pic/pic9/201812/zzpic15650.jpg",
 @"http://pics.sc.chinaz.com/files/pic/pic9/201812/zzpic15705.jpg",
 @"http://pics.sc.chinaz.com/files/pic/pic9/201811/bpic9223.jpg",
 @"http://pics.sc.chinaz.com/files/pic/pic9/201808/zzpic13883.jpg",
 @"http://pics.sc.chinaz.com/files/pic/pic9/201809/zzpic14046.jpg",
 @"http://pics.sc.chinaz.com/files/pic/pic9/201807/zzpic13056.jpg",
 @"http://pics.sc.chinaz.com/files/pic/pic9/201806/bpic7241.jpg",
 @"http://pics.sc.chinaz.com/files/pic/pic9/201805/zzpic12156.jpg"]],
 
 */
- (NSArray<WorkingRangeModel *> *)models{
    return @[
             [WorkingRangeModel modelWithUrls:@[
                                                @"https://unsplash.it/414.0/265",
                                               ]],
             [WorkingRangeModel modelWithUrls:@[
                                                @"https://unsplash.it/414.0/239",
                                                ]],
             [WorkingRangeModel modelWithUrls:@[
                                                @"https://unsplash.it/414.0/285",
                                               ]],
             [WorkingRangeModel modelWithUrls:@[
                                                @"https://unsplash.it/414.0/204",
                                                ]],
             [WorkingRangeModel modelWithUrls:@[
                                                @"https://unsplash.it/414.0/363",
                                                ]]
             ];
}

@end
