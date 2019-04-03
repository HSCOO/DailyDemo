//
//  QECacheManager.h
//  QnuaElf
//
//  Created by hscai on 2019/4/2.
//  Copyright © 2019 YJL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QECacheManager : NSObject

+ (void)limitSetting;

+ (void)removeAllCache;

+ (NSUInteger)cacheTotalCost;

@end

NS_ASSUME_NONNULL_END
