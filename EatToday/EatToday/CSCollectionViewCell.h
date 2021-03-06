//
//  CSCollectionViewCell.h
//  EatToday
//
//  Created by dage on 2018/12/29.
//  Copyright © 2018 OnlyStu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSCollectionViewCell : UICollectionViewCell


+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath res:(NSArray *)res;


@end

NS_ASSUME_NONNULL_END
