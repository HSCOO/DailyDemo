//
//  ConverUtil.h
//  TestOutOfSuperView
//
//  Created by hscai on 2019/3/25.
//  Copyright © 2019 YJL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConverUtil : NSObject

/**
 64编码
 */
+(NSString *)base64Encoding:(NSData*) text;

/**
 字节转化为16进制数
 */
+(NSString *) parseByte2HexString:(Byte *) bytes;

/**
 字节数组转化16进制数
 */
+(NSString *) parseByteArray2HexString:(Byte[]) bytes;

/*
 将16进制数据转化成NSData 数组
 */
+(NSData*) parseHexToByteArray:(NSString*) hexString;


@end

NS_ASSUME_NONNULL_END
