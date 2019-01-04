//
//  ViewController.m
//  SearchDemo
//
//  Created by dage on 2019/1/4.
//  Copyright © 2019 OnlyStu. All rights reserved.
//

#import "ViewController.h"
#import "PYSearch.h"

@interface ViewController ()<PYSearchViewControllerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self navigationSetting];
    
}

- (void)navigationSetting{
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault]; //此处使底部线条颜色为红色
    [navigationBar setShadowImage:[self imageWithColor:[UIColor redColor]]];
}

- (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return image;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSArray *hotArr = @[@"香米长粒香10斤",@"2018新米",@"小米平板4代共钢化膜",@"肉酱下饭",@"纯正红糖",@"瓷碗家用",@"小米Max大屏",@"麦提莎桶装",@"老粗布床单",@"年货零食"];
    PYSearchViewController *vc = [PYSearchViewController searchViewControllerWithHotSearches:hotArr searchBarPlaceholder:@"香米长粒香10斤" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        
    }];
    vc.hotSearchStyle = PYHotSearchStyleARCBorderTag;
    vc.searchHistoryStyle = PYSearchHistoryStyleARCBorderTag;
    vc.delegate = self;
    vc.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    
    [self.navigationController pushViewController:vc animated:NO];
    
    [self.textField resignFirstResponder];
    return NO;
}

- (void)cancel{
    
}

- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)searchBar searchText:(NSString *)searchText{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

- (void)didClickCancel:(PYSearchViewController *)searchViewController{
    [self.navigationController popViewControllerAnimated:NO];
}


@end
