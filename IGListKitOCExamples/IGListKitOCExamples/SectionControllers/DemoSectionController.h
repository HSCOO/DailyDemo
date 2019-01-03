//
//  DemoSectionController.h
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/3.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "IGListSectionController.h"

@interface DemoItem : NSObject<IGListDiffable>

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *controllerName;
@property (copy, nonatomic) NSString *controllerId;

+ (instancetype)itemWithName:(NSString *)name
              controllerName:(NSString *)controllerName
                controllerId:(NSString *)controllerId;

@end


NS_ASSUME_NONNULL_BEGIN

@interface DemoSectionController : IGListSectionController

@end

NS_ASSUME_NONNULL_END
