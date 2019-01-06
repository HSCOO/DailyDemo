//
//  WorkingRangeModel.h
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/6.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkingRangeModel : NSObject<IGListDiffable>

@property (strong, nonatomic) NSArray <NSString *>* urls;

+ (instancetype)modelWithUrls:(NSArray *)urls;

@end

NS_ASSUME_NONNULL_END
