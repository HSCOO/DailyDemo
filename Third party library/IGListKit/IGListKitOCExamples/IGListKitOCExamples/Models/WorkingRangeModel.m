//
//  WorkingRangeModel.m
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/6.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "WorkingRangeModel.h"

@implementation WorkingRangeModel

+ (instancetype)modelWithUrls:(NSArray *)urls{
    WorkingRangeModel *model = [WorkingRangeModel new];
    model.urls = urls;
    
    return model;
}

- (id<NSObject>)diffIdentifier{
    return self.urls;
}

- (BOOL)isEqualToDiffableObject:(WorkingRangeModel<IGListDiffable> *)object{
    if (self == object) {
        return YES;
    }else if (![object isKindOfClass:[WorkingRangeModel class]]){
        return NO;
    }else{
        return [self.urls.firstObject isEqualToString:object.urls.firstObject];
    }
}

@end
