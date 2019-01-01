//
//  CSAlertManager.m
//  EatToday
//
//  Created by dage on 2018/12/29.
//  Copyright © 2018 OnlyStu. All rights reserved.
//

#import "CSAlertManager.h"

@interface CSAlertManager()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) NSMutableArray *mutArr;

@end

@implementation CSAlertManager

+ (UIAlertController *)textFieldAlertVCOK:(void(^)(NSString *text))ok{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"喜欢的菜" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入喜欢的菜";
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        ok(textField.text);
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    
    return alert;
}

+ (UIAlertController *)text:(NSString *)text{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:text message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:okAction];

    return alert;
}

- (UIView *)showTableView:(NSString *)text cancel:(void(^)(void))cancel{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    [self subviewLayout:view];
    if (text.length > 0) {
        [self.mutArr addObject:text];
    }
    
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        self.mutArr = [NSMutableArray array];
        cancel();
    }];
    
    return view;
}

- (void)addResToTableView:(NSString *)text{
    [self.mutArr insertObject:text atIndex:0];
    [self.tableView reloadData];
}

#pragma mark - layout

- (void)subviewLayout:(UIView *)view{
    
    UIView *childView = [[UIView alloc] init];
    childView.layer.cornerRadius = 25;
    childView.clipsToBounds = YES;
    
    [view addSubview:childView];
    [childView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(5);
        make.left.equalTo(view).offset(20);
        make.right.equalTo(view).offset(-20);
        make.bottom.equalTo(view).offset(-5);
    }];
    
    [childView addSubview:self.cancelBtn];
    [childView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(childView).offset(1);
        make.left.equalTo(childView).offset(1);
        make.right.equalTo(childView).offset(-1);
        make.bottom.equalTo(self.cancelBtn.mas_top);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom);
        make.left.equalTo(childView).offset(1);
        make.right.equalTo(childView).offset(-1);
        make.bottom.equalTo(childView).offset(-1);
        make.height.offset(50);
    }];
}

#pragma mark - delegate&datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"CSAlertManagerCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.mutArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15 weight:0.5];
    
    return cell;
}

#pragma mark - getter&setter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        _cancelBtn.backgroundColor = [UIColor colorWithRed:224/255.0 green:191/255.0 blue:190/255.0 alpha:1];
        [_cancelBtn setTitle:@"关闭" forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

- (NSMutableArray *)mutArr{
    if (!_mutArr) {
        _mutArr = [NSMutableArray array];
    }
    return _mutArr;
}

@end
