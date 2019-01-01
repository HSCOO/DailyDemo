//
//  CSCollectionReusableView.m
//  EatToday
//
//  Created by dage on 2018/12/29.
//  Copyright © 2018 OnlyStu. All rights reserved.
//

#import "CSCollectionReusableView.h"

@interface CSCollectionReusableView()

@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation CSCollectionReusableView

+ (instancetype)reusableViewCollection:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath res:(NSArray *)res{
    static NSString *cellId = @"CSCollectionReusableView";
    CSCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cellId forIndexPath:indexPath];
    if (!reusableView) {
        reusableView = [[CSCollectionReusableView alloc] init];
    }
    
    NSString *secTitle = @"素菜";
    if (1 == indexPath.section) {
        secTitle = @"荤菜";
    }else if (2 == indexPath.section){
        secTitle = @"汤";
    }
    reusableView.label.text = secTitle;
    
    return reusableView;
}

@end
