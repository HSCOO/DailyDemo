//
//  WorkingRangeCell.h
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/6.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WorkingRangeModel;
NS_ASSUME_NONNULL_BEGIN

@interface WorkingRangeCell : UICollectionViewCell<IGListBindable>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (assign, nonatomic) NSUInteger index;

- (void)bindViewModel:(WorkingRangeModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
