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
    [STCalendarReminderTool fetchAllReminder];
    self.title                      = self.eventModel.eventTitle;
    self.eventContentLabel.text     = self.eventModel.eventContent;
    self.eventCreateDateLabel.text  = self.eventModel.beginDatestr;
    self.eventEndDateTimeLabel.text = self.eventModel.endDatestr;
    self.eventLevelLable.text       = self.eventModel.levelStr;
}
- (IBAction)editEventOnClick:(id)sender {
//    EKEventEditController
}
- (IBAction)addEventToCalendarOnClick:(id)sender {
    
    
    EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:1.0f * 1.0f * 1];
    
    
    
    [STCalendarReminderTool saveEventWithTitle:_eventModel.eventTitle
                                         notes:_eventModel.eventContent
                                      location:@"帝都"
                                     startDate:_eventModel.beginDate
                                       endDate:_eventModel.endDate
                                        alarms:[NSArray arrayWithObjects:alarm, nil]
                                           URL:[NSURL URLWithString:@"http://www.jianshu.com/u/23a4aad7b6b6"]
                                  availability:EKEventAvailabilityFree
                                  successBlock:^(NSString *eventIdentifier){
            
                                      
                                      self.eventModel.eventIdentifier = eventIdentifier;
                                      [self.eventModel updatEventIdentifier];
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                      [alert show];
     } failBlock:^(NSError *err) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存失败" message:[err localizedDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
         [alert show];
         
     }];
}
- (IBAction)addEventToReminderOnClick:(id)sender {
    
      EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:1.0f * 1.0f * 1];
    
    [STCalendarReminderTool saveEventIntoReminderWithTitle:_eventModel.eventTitle
                                                     notes:_eventModel.eventContent
                                                 startDate:_eventModel.beginDate
                                                   endDate:_eventModel.endDate
                                                     alarm:alarm
                                                  priority:0
                                                 completed:NO
                                              successBlock:^(NSString *eventIdentifier) {
                                                  
                                                  _eventModel.eventIdentifier = eventIdentifier;
                                                  
                                                  [self.eventModel updatEventIdentifier];
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                                  [alert show];
                                                  
                                              } failBlock:^(NSError *err) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存失败" message:[err localizedDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                                  [alert show];
                                              }];
}
@end
