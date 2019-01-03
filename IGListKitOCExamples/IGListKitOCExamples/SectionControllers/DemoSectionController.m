//
//  DemoSectionController.m
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/3.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "DemoSectionController.h"
#import "LabelCell.h"

@implementation DemoItem

+ (instancetype)itemWithName:(NSString *)name
              controllerName:(NSString *)controllerName
                controllerId:(NSString *)controllerId{
    
    DemoItem *item = [[DemoItem alloc] init];
    item.name = name;
    item.controllerName = controllerName;
    item.controllerId = controllerId;
    return item;
}

#pragma mark - delegate

- (id<NSObject>)diffIdentifier{
    return self.name;
}

- (BOOL)isEqualToDiffableObject:(NSObject <IGListDiffable> *)object{
    if (self == object) {
        return YES;
    }else if (![object isKindOfClass:[DemoItem class]]){
        return NO;
    }else{
        DemoItem *tmpItem = (DemoItem *)object;
        return [self.controllerName isEqualToString:tmpItem.controllerName] && [self.controllerId isEqualToString:tmpItem.controllerId];
    }
}

@end

@interface DemoSectionController()

@property (strong, nonatomic) DemoItem *object;

@end

@implementation DemoSectionController

- (CGSize)sizeForItemAtIndex:(NSInteger)index{
    return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index{
    LabelCell *cell = [self.collectionContext dequeueReusableCellFromStoryboardWithIdentifier:@"LabelCell" forSectionController:self atIndex:index];
    cell.label.text = self.object.name;
    return cell;
}

- (void)didUpdateToObject:(id)object{
    self.object = object;
}


@end
