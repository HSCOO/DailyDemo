//
//  KindCollectionViewCell.h
//  AlertCollectionView
//
//  Created by dage on 2019/1/5.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const kCellId = @"KindCollectionViewCell";
NS_ASSUME_NONNULL_BEGIN

@interface KindCollectionViewCell : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath res:(NSArray *)res;

@end

NS_ASSUME_NONNULL_END
