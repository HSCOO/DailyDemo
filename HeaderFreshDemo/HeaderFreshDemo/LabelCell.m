//
//  LabelCell.m
//  HeaderFreshDemo
//
//  Created by hscai on 2019/8/1.
//  Copyright © 2019 HSCOO. All rights reserved.
//

#import "LabelCell.h"
#import "LabelModel.h"

@interface LabelCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation LabelCell

- (void)bindViewModel:(LabelModel *)viewModel{
    if (![viewModel isMemberOfClass:[LabelModel class]]) {
        return;
    }
    self.contentLabel.text = viewModel.text;
}

@end
