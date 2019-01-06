//
//  DemoSectionController.m
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/3.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "DemoSectionController.h"
#import "LabelCell.h"
#import "DemoModel.h"

@interface DemoSectionController()

@property (strong, nonatomic) DemoModel *object;

@end

@implementation DemoSectionController

- (NSInteger)numberOfItems{
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    LabelCell *cell = [self.collectionContext dequeueReusableCellFromStoryboardWithIdentifier:NSStringFromClass([LabelCell class]) forSectionController:self atIndex:index];
    cell.label.text = self.object.name;
    return cell;
}

- (void)didUpdateToObject:(id)object{
    self.object = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:self.object.controllerId];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

@end
