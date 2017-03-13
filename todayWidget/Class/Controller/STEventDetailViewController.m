//
//  STEventDetailViewController.m
//  todayWidget
//
//  Created by StarHui on 2017/3/9.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "STEventDetailViewController.h"
#import "STCalendarReminderTool.h"
#import "STEventModel.h"

@interface STEventDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventCreateDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventBeginDateTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *eventEndDateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLevelLable;

@property (strong, nonatomic) STEventModel *eventModel;
@end

@implementation STEventDetailViewController

+(instancetype)instanceEventModel:(STEventModel *)eventModel {
    NSString *mIdentifier = NSStringFromClass(self);
    UIStoryboard *mStb = [UIStoryboard storyboardWithName:@"Main"bundle:nil];
    STEventDetailViewController *vc = [mStb instantiateViewControllerWithIdentifier:mIdentifier];
    vc.eventModel = eventModel;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [STCalendarReminderTool fetchAllEventInUserCalendar];
    
}
- (IBAction)editEventOnClick:(id)sender {
}
- (IBAction)addEventToCalendarOnClick:(id)sender {
}
- (IBAction)addEventToReminderOnClick:(id)sender {
}


@end
