//
//  LabelModel.m
//  HeaderFreshDemo
//
//  Created by hscai on 2019/8/1.
//  Copyright © 2019 HSCOO. All rights reserved.
//

#import "LabelModel.h"

@implementation LabelModel

- (nonnull id<NSObject>)diffIdentifier {
    return self.text;
}

- (BOOL)isEqualToDiffableObject:(LabelModel <IGListDiffable>*)object {
    return [self.text isEqualToString:object.text];
}

@end
