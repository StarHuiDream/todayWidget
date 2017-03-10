//
//  TodayViewController.m
//  STWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "STEventModel.h"
#import "STTWEventCell.h"


static CGFloat cellH = 80;
@interface TodayViewController ()
<NCWidgetProviding
,UITableViewDelegate
,UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) STEventListModel *eventListModel;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.eventListModel = [STEventListModel fetchData];
    if (stsystemVersion >= 10.0) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (stsystemVersion < 10.0) {
        CGFloat height = self.eventListModel.eventList.count * cellH ;
        height         = height > cellH ? height : cellH;
        [self setPreferredContentSize:CGSizeMake(0, height+ 30)];
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {


    completionHandler(NCUpdateResultNewData);
}
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        self.preferredContentSize = maxSize;
    } else if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        
        CGFloat height = self.eventListModel.eventList.count * cellH ;
        height         = height > cellH ? height: cellH;
        self.preferredContentSize = CGSizeMake(0, height+ 30);
    }
}
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
   return  UIEdgeInsetsMake(0, 40, 0, 0);
//    return UIEdgeInsetsZero;
}

#pragma -mark ,UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.eventListModel.eventList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    STEventModel *eventModel = self.eventListModel.eventList[indexPath.row];
    STTWEventCell *cell = [STTWEventCell instanceWithEventModel:eventModel tableView:tableView];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellH;
}
- (IBAction)chekcinAllEventOnClick:(id)sender {
    [self.extensionContext openURL:[NSURL URLWithString:@"STTodayWidget://GOTOEventListVC"] completionHandler:^(BOOL success) {
        NSLog(@"open url result:%d", success);
    }];

}
@end
