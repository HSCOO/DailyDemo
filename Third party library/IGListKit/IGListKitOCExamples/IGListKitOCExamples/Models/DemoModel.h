//
//  DemoModel.h
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/6.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoModel : NSObject<IGListDiffable>

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *controllerId;

+ (instancetype)itemWithName:(NSString *)name
                controllerId:(NSString *)controllerId;

@end

NS_ASSUME_NONNULL_END
