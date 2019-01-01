//
//  CSCollectionViewCell.m
//  EatToday
//
//  Created by dage on 2018/12/29.
//  Copyright © 2018 OnlyStu. All rights reserved.
//

#import "CSCollectionViewCell.h"

@interface CSCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *title;


@end

@implementation CSCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath res:(NSArray *)res{
    
    static NSString *cellId = @"CSCollectionViewCell";
    CSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[CSCollectionViewCell alloc] init];
    }
    NSString *text = res[indexPath.section][indexPath.row];
    cell.title.text = text;
    return cell;
}

@end
