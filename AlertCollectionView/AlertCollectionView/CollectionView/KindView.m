//
//  KindView.m
//  AlertCollectionView
//
//  Created by dage on 2019/1/5.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "KindView.h"
#import "Masonry.h"
#import "KindCollectionViewCell.h"

@interface KindView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UIView *bgView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *res;

@end

@implementation KindView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self allViews];
    }
    return self;
}

- (void)allViews{
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.bgView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView).offset(-40);
    }];
}

#pragma mark - deleagte

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.res.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KindCollectionViewCell *cell = [KindCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath res:self.res];
    return cell;
}


- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    }
    return _bgView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[KindCollectionViewCell class] forCellWithReuseIdentifier:kCellId];
        
    }
    return _collectionView;
}

- (NSArray *)res{
    return @[@{@"icon":@"1",@"title":@"asd"},
             @{@"icon":@"1",@"title":@"sdff"},
             @{@"icon":@"1",@"title":@"sdsaf"},
             @{@"icon":@"1",@"title":@"gggfadfs"},
             @{@"icon":@"1",@"title":@"34dsdsa"},
             @{@"icon":@"1",@"title":@"asd"},
             @{@"icon":@"1",@"title":@"sdff"},
             @{@"icon":@"1",@"title":@"sdsaf"},
             @{@"icon":@"1",@"title":@"gggfadfs"},
             @{@"icon":@"1",@"title":@"34dsdsa"},
             ];
}

@end
