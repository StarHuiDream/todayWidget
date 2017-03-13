//
//  LsitViewController.m
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "STLsitViewController.h"
#import "STEventModel.h"
#import "STEventListCell.h"

#import "STEventDetailViewController.h"

@interface STLsitViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) STEventListModel *eventListModel;
@end

@implementation STLsitViewController

+(instancetype)instance{
    NSString *mIdentifier = NSStringFromClass(self);
    UIStoryboard *mStb = [UIStoryboard storyboardWithName:@"Main"bundle:nil];
    STLsitViewController *vc = [mStb instantiateViewControllerWithIdentifier:mIdentifier];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"待办事件列表";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
#pragma  -mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.eventListModel.eventList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    STEventModel *eventModel = self.eventListModel.eventList[indexPath.row];
    STEventListCell *cell = [STEventListCell instanceWithEventModel:eventModel tableView:tableView];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath{
    STEventModel *eventModel = self.eventListModel.eventList[indexPath.row];
    [self.eventListModel deleteEventWithEventModel:eventModel];
    [self.tableView reloadData];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    STEventModel *eventModel = self.eventListModel.eventList[indexPath.row];
    STEventDetailViewController *eventDetailVC = [STEventDetailViewController instanceEventModel:eventModel];
    [self.navigationController pushViewController:eventDetailVC animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(STEventListModel *)eventListModel{
    if (!_eventListModel) {
        _eventListModel = [STEventListModel fetchData];
    }
    return _eventListModel;
}
@end
