//
//  KindCollectionViewCell.m
//  AlertCollectionView
//
//  Created by dage on 2019/1/5.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "KindCollectionViewCell.h"
#import "Masonry.h"

@interface KindCollectionViewCell()

@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) UILabel *label;

@end

@implementation KindCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self allViews];
        self.backgroundColor = [UIColor magentaColor];
    }
    return self;
}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath res:(NSArray *)res{
    
    KindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[KindCollectionViewCell alloc] init];
    }
    NSDictionary *dic = res[indexPath.row];
    cell.iconView.image = [UIImage imageNamed:dic[@"icon"]];
    cell.label.text = dic[@"title"];
    
    return cell;
}

- (void)allViews{
    [self.contentView addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.centerX.equalTo(self.contentView);
        make.width.height.offset(50);
    }];
    
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_bottom).offset(2);
        make.centerX.equalTo(self.iconView);
    }];
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

@end
