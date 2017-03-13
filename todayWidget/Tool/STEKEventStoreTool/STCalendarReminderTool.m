//
//  STCalendarReminderTool.m
//  todayWidget
//
//  Created by StarHui on 2017/3/12.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "STCalendarReminderTool.h"

@interface STCalendarReminderTool()

@property (strong, nonatomic)EKEventStore *store;

@end

@implementation STCalendarReminderTool
-(bool)saveEventIntoCalendar{
    EKEventStore *store = [[EKEventStore alloc] init];
    return YES;
}
+(NSArray *)fetchAllEventInUserCalendar{

     EKEventStore *store = [[EKEventStore alloc] init];

    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        
        });
    }];
    
     NSArray *tempArr =   [store calendarsForEntityType:EKEntityTypeEvent];
    NSLog(@"tempArrtempArr %@",tempArr);

    // Get the appropriate calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Create the start date components
    NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
    oneDayAgoComponents.day = -1;
    NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:[NSDate date]
                                                 options:0];
    
    // Create the end date components
    NSDateComponents *oneYearFromNowComponents = [[NSDateComponents alloc] init];
    oneYearFromNowComponents.year = 1;
    NSDate *oneYearFromNow = [calendar dateByAddingComponents:oneYearFromNowComponents
                                                       toDate:[NSDate date]
                                                      options:0];
    
    // Create the predicate from the event store's instance method
    NSPredicate *predicate = [store predicateForEventsWithStartDate:oneDayAgo
                                                            endDate:oneYearFromNow
                                                          calendars:nil];
    
    // Fetch all events that match the predicate
    NSArray *events = [store eventsMatchingPredicate:predicate];
    NSLog(@"eventsevents %@",events);
    return events;
}
@end
