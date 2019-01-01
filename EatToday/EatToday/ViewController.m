//
//  ViewController.m
//  EatToday
//
//  Created by dage on 2018/12/29.
//  Copyright © 2018 OnlyStu. All rights reserved.
//

#import "ViewController.h"
#import "CSCollectionViewCell.h"
#import "CSAlertManager.h"
#import "CSDataManager.h"
#import "CSCollectionReusableView.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UIButton *eatBtn;

@property (strong, nonatomic) NSMutableArray *data;

@property (strong, nonatomic) CSAlertManager *alerManager;
@property (strong, nonatomic) UIView *alertView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingData];
    [self addAlertView];
    // Do any additional setup after loading the view, typically from a nib.
    [[self.eatBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSString *final = [CSDataManager filterData:self.data];
        if (final.length > 0) {
            self.alertView.hidden = NO;
            [self.alerManager addResToTableView:final];
        }else{
            UIAlertController *alertVC = [CSAlertManager text:@"数据不足"];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }];
}

- (void)settingData{
    NSArray *settingData = [kUserDefaults objectForKey:kSaveSetting];
    if (!settingData || settingData.count == 0) {
        settingData = @[
                        @(2),
                        @(1),
                        @(0)
                        ];
    }
    
    [kUserDefaults setObject:settingData forKey:kSaveSetting];
    [kUserDefaults synchronize];
}

- (void)addAlertView{
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collection.mas_top);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.eatBtn.mas_top).offset(-50);
    }];
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    CSCollectionReusableView *reuView = [CSCollectionReusableView reusableViewCollection:collectionView indexPath:indexPath res:self.data];
    return reuView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.data[section];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CSCollectionViewCell *cell = [CSCollectionViewCell cellWithCollectionView:collectionView indexPath:indexPath res:self.data];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {  //添加
        UIAlertController *alertVC = [CSAlertManager textFieldAlertVCOK:^(NSString * _Nonnull text) {
            
            NSMutableArray *tmpArr = [self.data[indexPath.section] mutableCopy];
            [tmpArr addObject:text];
            dispatch_async(dispatch_get_main_queue(), ^{
                [collectionView reloadData];
                
                self.data[indexPath.section] = tmpArr;
                [kUserDefaults setObject:self.data forKey:kSaveData];
                [kUserDefaults synchronize];
            });
        }];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

#pragma mark - getter&setter

- (NSMutableArray *)data{
    if (!_data) {
        _data = [[kUserDefaults objectForKey:kSaveData] mutableCopy];
        if (!_data) {
            _data = [@[
                       [@[@"+"] mutableCopy],
                       [@[@"+"] mutableCopy],
                       [@[@"+"] mutableCopy]
                       ] mutableCopy];
        }
    }
    return _data;
}

- (CSAlertManager *)alerManager{
    if (!_alerManager) {
        _alerManager = [[CSAlertManager alloc] init];
    }
    return _alerManager;
}

- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [self.alerManager showTableView:@"" cancel:^{
            self->_alertView.hidden = YES;
        }];
        [self.view addSubview:_alertView];
        _alertView.hidden = YES;
    }
    return _alertView;
}

@end
