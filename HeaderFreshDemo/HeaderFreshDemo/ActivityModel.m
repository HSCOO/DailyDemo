//
//  ActivityModel.m
//  HeaderFreshDemo
//
//  Created by hscai on 2019/8/1.
//  Copyright © 2019 HSCOO. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel

- (nonnull id<NSObject>)diffIdentifier {
    return @(self.showActivity);
}

- (BOOL)isEqualToDiffableObject:(ActivityModel <IGListDiffable>*)object {
    return self.showActivity  == object.showActivity;
}

@end
