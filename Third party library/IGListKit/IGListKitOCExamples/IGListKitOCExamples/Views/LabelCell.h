//
//  LabelCell.h
//  IGListKitOCExamples
//
//  Created by dage on 2019/1/3.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DemoModel;
NS_ASSUME_NONNULL_BEGIN

@interface LabelCell : UICollectionViewCell<IGListBindable>

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

NS_ASSUME_NONNULL_END
