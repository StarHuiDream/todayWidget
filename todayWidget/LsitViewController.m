//
//  LsitViewController.m
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "LsitViewController.h"

@interface LsitViewController ()

@end

@implementation LsitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待办事件列表";
//    self.tit
    // Do any additional setup after loading the view.
}
- (IBAction)dismisVCOnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    

    }];
}
@end
