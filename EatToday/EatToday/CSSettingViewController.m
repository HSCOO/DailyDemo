//
//  CSSettingViewController.m
//  EatToday
//
//  Created by dage on 2018/12/29.
//  Copyright © 2018 OnlyStu. All rights reserved.
//

#import "CSSettingViewController.h"


@interface CSSettingViewController ()

@property (weak, nonatomic) IBOutlet UITextField *suTextField;
@property (weak, nonatomic) IBOutlet UITextField *hunTextField;
@property (weak, nonatomic) IBOutlet UITextField *tangTextField;

@property (strong, nonatomic) NSMutableArray *settingData;

@end

@implementation CSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self defaultData];
    // Do any additional setup after loading the view.
    [RACObserve(self.suTextField, text) subscribeNext:^(NSString *text) {
        if ([text integerValue] > 0) {
            [self modifyText:text Index:0];
        }
    }];
    
    [RACObserve(self.hunTextField, text) subscribeNext:^(NSString *text) {
        if ([text integerValue] > 0) {
            [self modifyText:text Index:1];
        }
    }];
    
    [RACObserve(self.tangTextField, text) subscribeNext:^(NSString *text) {
        if ([text integerValue] > 0) {
            [self modifyText:text Index:2];
        }
    }];
}

- (void)modifyText:(NSString *)text Index:(NSInteger)index{
    self.settingData[index] = [NSNumber numberWithInteger:[text integerValue]];
    
    [kUserDefaults setObject:self.settingData forKey:kSaveSetting];
    [kUserDefaults synchronize];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - defaultData

- (void)defaultData{
    NSArray *data = [kUserDefaults objectForKey:kSaveSetting];
    self.suTextField.text = [NSString stringWithFormat:@"%@",data[0]];
    self.hunTextField.text = [NSString stringWithFormat:@"%@",data[1]];
    self.tangTextField.text = [NSString stringWithFormat:@"%@",data[2]];
}

#pragma mark - getter&setter

- (NSMutableArray *)settingData{
    if (!_settingData) {
        _settingData = [@[@(2),@(1),@(0)] mutableCopy];
    }
    return _settingData;
}

@end
