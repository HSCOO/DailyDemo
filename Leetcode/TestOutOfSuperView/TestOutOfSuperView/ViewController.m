//
//  ViewController.m
//  TestOutOfSuperView
//
//  Created by hscai on 2019/3/25.
//  Copyright © 2019 YJL. All rights reserved.
//

#import "ViewController.h"
#import "RedView.h"
#import "DESCEBTools.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RedView *redView = [[RedView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 40)];
    [self.view addSubview:redView];
    redView.backgroundColor = [UIColor redColor];
    
    UIView *yeView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 300)];
    [redView addSubview:yeView];
    yeView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.4];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 300)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [yeView addSubview:tableView];
    
    //
//    NSString *xx = [self base64DecodeString:@"XASLPIhQydA="];
//    NSString *new = [DESCEBTools decryptUseDES:@"XASLPIhQydA=" key:@"K@%a0&XX"];
//    NSString *str = [DESCEBTools encryptUseDES:@"[]" key:@"K@%a0&XX"];
//    str = [DESCEBTools decryptUseDES:str key:@"K@%a0&XX"];
    
//    NSData *xxData = [DESCEBTools dataWithBase64EncodedString:@"XASLPIhQydA="];
//    NSData *toolData = [DESCEBTools DESDecrypt:xxData WithKey:@"K@%a0&XX"];
//    NSString *toolStr = [[NSString alloc] initWithData:toolData encoding:NSUTF8StringEncoding];
    
    NSString *finalStr = [DESCEBTools decrypt:@"XASLPIhQydA=" key:@"K@%a0&XX"];
    NSString *enStr = [DESCEBTools encrypt:@"[]" key:@"K@%a0&XX"];
    
    NSLog(@"%@",enStr);
}

- (NSString *)base64DecodeString:(NSString *)base64String
{
    //NSData *base64data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}
- (void)yeTap{
    NSLog(@"yeView touches");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"View touches");
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld num ",(long)indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select row -- %ld",(long)indexPath.row);
}



@end
