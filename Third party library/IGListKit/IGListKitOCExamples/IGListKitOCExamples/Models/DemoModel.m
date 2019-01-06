//
//  DemoModel.m
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/6.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "DemoModel.h"

@implementation DemoModel

+ (instancetype)itemWithName:(NSString *)name
                controllerId:(NSString *)controllerId{
    
    DemoModel *item = [[DemoModel alloc] init];
    item.name = name;
    item.controllerId = controllerId;
    return item;
}

#pragma mark - delegate

- (id<NSObject>)diffIdentifier{
    return self.name;
}

- (BOOL)isEqualToDiffableObject:(DemoModel <IGListDiffable> *)object{
    if (self == object) {
        return YES;
    }else if (![object isKindOfClass:[DemoModel class]]){
        return NO;
    }else{
        return [self.name isEqualToString:object.name] && [self.controllerId isEqualToString:object.controllerId];
    }
}
@end
