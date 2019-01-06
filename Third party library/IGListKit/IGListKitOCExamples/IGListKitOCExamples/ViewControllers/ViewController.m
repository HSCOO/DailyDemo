//
//  ViewController.m
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/3.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "ViewController.h"
#import "DemoSectionController.h"
#import "DemoModel.h"

@interface ViewController ()<IGListAdapterDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IGListAdapter *adapter;
@property (strong, nonatomic)  NSArray<DemoModel *> *demos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.adapter.collectionView = self.collectionView;
    self.adapter.dataSource = self;
}

#pragma mark - getter&setter

- (IGListAdapter *)adapter{
    if (!_adapter) {
        _adapter = [[IGListAdapter alloc] initWithUpdater:[IGListAdapterUpdater new] viewController:self];
    }
    return _adapter;
}

- (NSArray<DemoModel *> *)demos{
    return @[
             [DemoModel itemWithName:@"Working Range" controllerId:@"WorkingRangeViewController"],
             ];
}

#pragma mark - delegate

- (NSArray<id<IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter{
    return self.demos;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object{
    return [DemoSectionController new];
}

- (UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter{
    return nil;
}

@end
