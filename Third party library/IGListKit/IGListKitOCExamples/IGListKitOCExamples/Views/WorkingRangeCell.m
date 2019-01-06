//
//  WorkingRangeCell.m
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/6.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "WorkingRangeCell.h"
#import "WorkingRangeModel.h"

@interface WorkingRangeCell()

@end

@implementation WorkingRangeCell

- (void)bindViewModel:(WorkingRangeModel *)viewModel{
    NSString *url = viewModel.urls[self.index];
    NSURL *URL = [NSURL URLWithString:url];
    [self.iconView sd_setImageWithURL:URL];
    
    self.label.text = url;
}

@end
