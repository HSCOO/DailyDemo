//
//  ViewController.m
//  ToastDemo
//
//  Created by hscai on 2019/8/5.
//  Copyright © 2019 HSCOO. All rights reserved.
//

#import "ViewController.h"
#import <CRToast.h>

@interface ViewController ()

/**iden*/
@property (assign, nonatomic) NSInteger ident;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.ident = 0;
}

- (void)showNotificationTitle:(NSString *)title subTitle:(NSString *)subTitle identifier:(NSString *)identifier imageName:(NSString *)imageName tapClick:(dispatch_block_t)tapClick{
    
    NSDictionary *optionsDic = @{
                                 kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
                                 kCRToastNotificationPresentationTypeKey : @(CRToastPresentationTypeCover),
                                 
                                 kCRToastUnderStatusBarKey : @(YES),
                                 kCRToastBackgroundColorKey : UIColor.lightGrayColor,
                                 
                                 kCRToastTextKey : title,
                                 kCRToastTextAlignmentKey : @(NSTextAlignmentLeft),
                                 kCRToastTextColorKey : UIColor.blackColor,
                                 
                                 kCRToastIdentifierKey : identifier,
                                 
                                 kCRToastTimeIntervalKey : @(2.0),
                                 
                                 kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                                 kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionBottom),
                                 
                                 kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),
                                 kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),
                                 
                                 kCRToastNotificationPreferredPaddingKey : @(10),
                                 
                                 kCRToastSubtitleTextKey : subTitle,
                                 kCRToastSubtitleTextAlignmentKey : @(NSTextAlignmentLeft),
                                 kCRToastSubtitleTextColorKey : UIColor.blackColor,
                                 
                                 kCRToastImageKey : [UIImage imageNamed:imageName],
                                 kCRToastImageAlignmentKey : @(CRToastAccessoryViewAlignmentLeft),
                                 
                                 kCRToastInteractionRespondersKey : @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTapOnce automaticallyDismiss:YES block:^(CRToastInteractionType interactionType) {
                                     if (tapClick) {
                                         tapClick();
                                     }
                                 }]]
                                 };
    
    [CRToastManager showNotificationWithOptions:optionsDic completionBlock:nil];
}

- (IBAction)start:(id)sender {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSString *title = [NSString stringWithFormat:@"title %ld",self.ident];
        NSString *subTitle = [NSString stringWithFormat:@"subTitle %ld", self.ident];
        NSString *ident = [NSString stringWithFormat:@"%ld",self.ident];
        [self showNotificationTitle:title subTitle:subTitle identifier:ident imageName:@"00.jpg" tapClick:^{
            NSLog(@"%@",ident);
        }];
        self.ident += 1;
    });
}

@end
