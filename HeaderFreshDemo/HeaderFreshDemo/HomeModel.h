//
//  HomeModel.h
//  HeaderFreshDemo
//
//  Created by hscai on 2019/8/1.
//  Copyright © 2019 HSCOO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>
#import "LabelModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject<IGListDiffable>

@property (assign, nonatomic) BOOL showActivity;
@property (strong, nonatomic) NSArray <LabelModel *>*texts;

@end

NS_ASSUME_NONNULL_END
