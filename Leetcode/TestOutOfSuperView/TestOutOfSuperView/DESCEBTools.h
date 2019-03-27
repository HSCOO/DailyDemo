//
//  DESCEBTools.h
//  TestOutOfSuperView
//
//  Created by hscai on 2019/3/25.
//  Copyright © 2019 YJL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DESCEBTools : NSObject

/**
 加密
 */
+ (NSString *)encrypt:(NSString *)str key:(NSString *)key;

/**
 解密
 */
+ (NSString *)decrypt:(NSString *)base64Str key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
