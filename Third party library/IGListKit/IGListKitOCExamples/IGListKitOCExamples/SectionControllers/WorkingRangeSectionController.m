//
//  WorkingRangeSectionController.m
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/6.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "WorkingRangeSectionController.h"
#import "WorkingRangeModel.h"
#import "WorkingRangeCell.h"

@interface WorkingRangeSectionController()<IGListWorkingRangeDelegate>

@property (strong, nonatomic) WorkingRangeModel *model;

@end

@implementation WorkingRangeSectionController

- (instancetype)init{
    if (self = [super init]) {
        self.workingRangeDelegate = self;
    }
    return self;
}

- (NSInteger)numberOfItems{
    return 1;
}

- (void)didUpdateToObject:(id)object{
    self.model = object;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake(self.collectionContext.containerSize.width, 150);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    WorkingRangeCell *cell = [self.collectionContext dequeueReusableCellFromStoryboardWithIdentifier:NSStringFromClass([WorkingRangeCell class]) forSectionController:self atIndex:index];
    cell.index = index;
    [cell bindViewModel:self.model];
    NSLog(@"Selector -- %@",NSStringFromSelector(_cmd));
    
    return cell;
}
// 可以通过打印知道，先运行的是WorkingRange，然后才是cellForItemAtIndex
- (void)listAdapter:(IGListAdapter *)listAdapter sectionControllerWillEnterWorkingRange:(IGListSectionController *)sectionController{
    // 为什么只取0，因为每个section里面只放了一个cell。
    WorkingRangeCell *cell = [self.collectionContext cellForItemAtIndex:0 sectionController:self];
    NSURL *url = [NSURL URLWithString:self.model.urls.firstObject];
    [cell.iconView sd_setImageWithURL:url];
    NSLog(@"Selector -- %@ url -- %@",NSStringFromSelector(_cmd),self.model.urls[0]);
}

- (void)listAdapter:(nonnull IGListAdapter *)listAdapter sectionControllerDidExitWorkingRange:(nonnull IGListSectionController *)sectionController {
    NSLog(@"Selector -- %@",NSStringFromSelector(_cmd));
}


- (void)didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"index --- %ld",index);
}

@end
