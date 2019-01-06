//
//  LabelCell.m
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/3.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "LabelCell.h"
#import "DemoModel.h"

@implementation LabelCell

#pragma mark - delegate

- (void)bindViewModel:(id)viewModel{
    NSLog(@"viewModel -- %@",viewModel);
    if ([viewModel isKindOfClass:[NSString class]]) {
        return;
    }
    self.label.text = viewModel;
}

@end
