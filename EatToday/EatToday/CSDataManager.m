//
//  CSDataManager.m
//  EatToday
//
//  Created by dage on 2018/12/29.
//  Copyright © 2018 OnlyStu. All rights reserved.
//

#import "CSDataManager.h"
#import "CSAlertManager.h"

@implementation CSDataManager

+ (NSString *)filterData:(NSArray *)data{
    if (3 > data.count) {
        return @"";
    }
    
    NSArray *suArr = data[0];
    NSArray *hunArr = data[1];
    NSArray *tangArr = data[2];
    
    NSArray *setting = [kUserDefaults objectForKey:kSaveSetting];
    NSInteger suCount = [setting[0] integerValue];
    NSInteger hunCount = [setting[1]integerValue];
    NSInteger tangCount = [setting[2] integerValue];
    
    if (suArr.count - 1 < suCount ||
        hunArr.count - 1 < hunCount ||
        tangArr.count - 1 < tangCount) {
        return @"";
    }
    
    // 得到随机字符串
    NSString *suStr = [self randomStr:suArr maxCount:suCount];
    NSString *hunStr = [self randomStr:hunArr maxCount:hunCount];
    NSString *tangStr = [self randomStr:tangArr maxCount:tangCount];
    
    NSString *final = [NSString stringWithFormat:@"%@,%@,%@",suStr,hunStr,tangStr];
    
    return final;
}

+ (NSString *)randomStr:(NSArray *)arr maxCount:(NSInteger)maxCount{
    // 平均分割
    if (0 == maxCount) {
        return @"";
    }
 
    __block NSString *finalStr = @"";
    // 遍历得到随机数
    for (NSInteger i = 0; i < maxCount; i++) {
        
        NSString *(^__block getRandom)(void) = ^{
            
            NSInteger tmpInt = [self getRandomNumber:1 to:arr.count - 1];
            NSString *tmpStr = arr[tmpInt];
            if ([finalStr containsString:tmpStr]) {
                finalStr = getRandom();
            }else{
                if (finalStr.length > 0) {
                    finalStr = i == maxCount - 1 ? [NSString stringWithFormat:@"%@%@",finalStr,tmpStr] : [NSString stringWithFormat:@"%@%@,",finalStr,tmpStr];
                }else{
                    finalStr = i == maxCount - 1 ? [NSString stringWithFormat:@"%@",tmpStr] : [NSString stringWithFormat:@"%@,",tmpStr];
                }
            }
            return finalStr;
        };
        
        finalStr = getRandom();
    }
    return finalStr;
}


+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to {
    return (from + (arc4random() % (to - from + 1)));
}

@end
