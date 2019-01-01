//
//  CSAlertManager.h
//  EatToday
//
//  Created by dage on 2018/12/29.
//  Copyright © 2018 OnlyStu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSAlertManager : NSObject

+ (UIAlertController *)textFieldAlertVCOK:(void(^)(NSString *text))ok;

+ (UIAlertController *)text:(NSString *)text;

- (UIView *)showTableView:(NSString *)text cancel:(void(^)(void))cancel;
- (void)addResToTableView:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
