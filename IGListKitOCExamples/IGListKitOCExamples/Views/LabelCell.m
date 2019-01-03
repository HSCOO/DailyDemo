//
//  LabelCell.m
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/3.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "LabelCell.h"

@implementation LabelCell

- (BOOL)isHighlighted{
    return self.contentView.backgroundColor = [UIColor colorWithWhite:self.isHighlighted ? 0.9 : 1 alpha:1];
}

#pragma mark - delegate

- (void)bindViewModel:(id)viewModel{
    self.label.text = viewModel;
}

@end
