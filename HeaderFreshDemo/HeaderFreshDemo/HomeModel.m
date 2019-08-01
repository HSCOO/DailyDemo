//
//  HomeModel.m
//  HeaderFreshDemo
//
//  Created by hscai on 2019/8/1.
//  Copyright © 2019 HSCOO. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

- (nonnull id<NSObject>)diffIdentifier {
    LabelModel *model = self.texts.firstObject;
    return model.text;
}

- (BOOL)isEqualToDiffableObject:(HomeModel <IGListDiffable>*)object {
    LabelModel *model = self.texts.firstObject;
    LabelModel *objModel = object.texts.firstObject;
    return [model.text isEqualToString:objModel.text];
}

@end
