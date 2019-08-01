//
//  SectionController.m
//  HeaderFreshDemo
//
//  Created by hscai on 2019/8/1.
//  Copyright © 2019 HSCOO. All rights reserved.
//

#import "SectionController.h"
#import "ActivityModel.h"
#import "LabelModel.h"
#import "HomeModel.h"

@interface SectionController() <IGListBindingSectionControllerDataSource>

@property (strong, nonatomic) NSMutableArray *resultArr;

@end

@implementation SectionController


- (instancetype)init{
    if (self = [super init]) {
        self.dataSource = self;
    }
    return self;
}

- (NSArray<id<IGListDiffable>> *)sectionController:(IGListBindingSectionController *)sectionController viewModelsForObject:(id)object{
    
    HomeModel *homeModel = nil;
    if ([object isKindOfClass:[HomeModel class]]) {
        homeModel = (HomeModel *)object;
    }
    
    if (!homeModel) {
        return nil;
    }
    
    if (homeModel.showActivity) {
        ActivityModel *activityModel = [ActivityModel new];
        [self.resultArr addObject: activityModel];
    }
    [self.resultArr addObjectsFromArray:homeModel.texts];
    
    return self.resultArr;
}

- (CGSize)sectionController:(IGListBindingSectionController *)sectionController sizeForViewModel:(id)viewModel atIndex:(NSInteger)index{
    CGFloat width = self.collectionContext.containerSize.width;
    return CGSizeMake(width, 40);
}

- (UICollectionViewCell<IGListBindable> *)sectionController:(IGListBindingSectionController *)sectionController cellForViewModel:(id)viewModel atIndex:(NSInteger)index{
    NSString *identifier = @"";
    if ([viewModel isMemberOfClass:[LabelModel class]]) {
        identifier = @"LabelCell";
    }else if ([viewModel isMemberOfClass:[ActivityModel class]]){
        identifier = @"ActivityCell";
    }
    UICollectionViewCell<IGListBindable> *cell = [self.collectionContext dequeueReusableCellFromStoryboardWithIdentifier:identifier forSectionController:sectionController atIndex:index];
    return cell;
}

- (NSMutableArray *)resultArr{
    if (!_resultArr) {
        _resultArr = [NSMutableArray array];
    }
    return _resultArr;
}

@end
