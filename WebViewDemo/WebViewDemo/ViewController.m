//
//  ViewController.m
//  WebViewDemo
//
//  Created by dage on 2019/1/12.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (strong, nonatomic) WKWebViewConfiguration *config;
@property (strong, nonatomic) WKWebView *webView;

@property (assign, nonatomic) BOOL computer;
@property (copy, nonatomic) NSString *computerUserAgent;
@property (copy, nonatomic) NSString *mobileUserAgent;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.webView];
}

- (IBAction)changeBtnClick:(id)sender {
    self.computer = !self.computer;
    NSString *title = self.computer ? @"切换为手机网页" : @"切换为电脑网页";
    [self.changeBtn setTitle:title forState:UIControlStateNormal];
    
    [self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        NSString *newUserAgent = self.computer ? self.computerUserAgent : self.mobileUserAgent;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:newUserAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dic];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.webView setCustomUserAgent:newUserAgent];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    }];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"self.webView.scrollView.contentSize -- %f  %f",self.webView.scrollView.contentSize.width,self.webView.scrollView.contentSize.height);
}

- (WKWebViewConfiguration *)config{
    if (!_config) {
        _config = [[WKWebViewConfiguration alloc] init];
        _config.allowsInlineMediaPlayback = YES;
        _config.allowsPictureInPictureMediaPlayback = YES;
    }
    return _config;
}

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40) configuration:self.config];
        _webView.navigationDelegate = self;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        [_webView loadRequest:request];
    }
    return _webView;
}

- (NSString *)computerUserAgent{
    if (!_computerUserAgent) {
        _computerUserAgent = @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36";
    }
    return _computerUserAgent;
}

- (NSString *)mobileUserAgent{
    if (!_mobileUserAgent) {
        _mobileUserAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 12_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/16B91";
    }
    return _mobileUserAgent;
}

@end
