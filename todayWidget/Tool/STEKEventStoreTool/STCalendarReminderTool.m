//
//  STCalendarReminderTool.m
//  todayWidget
//
//  Created by StarHui on 2017/3/12.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "STCalendarReminderTool.h"
#import <UIKit/UIKit.h>

@interface STCalendarReminderTool()
@end
@implementation STCalendarReminderTool
+(EKEventStore *)shareinstance{
    static dispatch_once_t once = 0;
    static EKEventStore *store;
    dispatch_once(&once, ^{ store = [[EKEventStore alloc] init]; });
    return store;
}
+(NSArray *)fetchEventWithStartDate:(NSDate *)startDate
                            endDate:(NSDate *)enDate{
    
    EKEventStore *store = [STCalendarReminderTool shareinstance];
    NSPredicate *predicate = [store predicateForEventsWithStartDate:startDate
                                                            endDate:enDate
                                                          calendars:nil];
    NSArray *events = [store eventsMatchingPredicate:predicate];
    [store enumerateEventsMatchingPredicate:predicate usingBlock:^(EKEvent * _Nonnull event, BOOL * _Nonnull stop) {
        
        NSLog(@"%@",event);
    }];
    return events;
}

+(NSArray *)fetchAllEventInUserCalendar{
    

    EKEventStore *store = [STCalendarReminderTool shareinstance];
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

+(EKEvent *)fetchEventWithIdentifer:(NSString *)eventidentifer{
    
    EKEventStore *store = [STCalendarReminderTool shareinstance];
    EKEvent *event = [store eventWithIdentifier:eventidentifer];
    return event;
}

+(void)saveEventWithTitle:(NSString *)title
                    notes:(NSString *)notes
                 location:(NSString *)location
                startDate:(NSDate *)startDate
                  endDate:(NSDate *)endDate
                   alarms:(NSArray<EKAlarm *> *)alarms
                      URL:(NSURL *)URL
             availability:(EKEventAvailability)availability
             successBlock:(STCalendarReminderToolSaveSuccessBlock)successBlock
                failBlock:(STCalendarReminderToolSaveFailBlock)failBlock{
    
    EKEventStore *store = [STCalendarReminderTool shareinstance];
    [store requestAccessToEntityType:EKEntityTypeEvent
                                completion:
     ^(BOOL granted, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             if (error) {
                 if (failBlock) {
                   failBlock(error);
                 }
                 return;
             }
             if (!granted) {
                 
                 //被用户拒绝，不允许访问日历
                 return;
             }
             
             EKEvent *event = [EKEvent eventWithEventStore:store];
             [event setCalendar:[store defaultCalendarForNewEvents]];
             
             event.title = title;
             event.notes = notes;
             event.availability = availability;
             event.startDate = startDate;
             event.endDate = endDate;
             event.location  = location;
             event.alarms = alarms;
             event.calendar = store.defaultCalendarForNewEvents;
             event.URL = URL;
             
             NSError *err = nil;
             [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
             if (!err) {
                 if (successBlock) {
                     successBlock(event.eventIdentifier);
                 }
             }else{

                 if (failBlock) {
                     failBlock(err);
                 }
             }
             NSLog(@"eventIdentifier %@",event.eventIdentifier);
         });
     }];
}

+(BOOL)deleteEventWithEventIdentifier:(NSString *)eventIdentifier{
    EKEventStore *store = [STCalendarReminderTool shareinstance];
    EKEvent *event = [store eventWithIdentifier:eventIdentifier];
    // YES立即删除事件;否则，更改将批处理，直到调用commit：方法。
    return  [store removeEvent:event span:EKSpanThisEvent commit:YES error:nil];
}

+(NSArray *)fetchAllReminder{

    EKEventStore *store = [STCalendarReminderTool shareinstance];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *oneDayAgoComponents = [[NSDateComponents alloc] init];
    oneDayAgoComponents.day = -1;
    NSDate *oneDayAgo = [calendar dateByAddingComponents:oneDayAgoComponents
                                                  toDate:[NSDate date]
                                                 options:0];

    NSDateComponents *oneYearFromNowComponents = [[NSDateComponents alloc] init];
    oneYearFromNowComponents.year = 1;
    NSDate *oneYearFromNow = [calendar dateByAddingComponents:oneYearFromNowComponents
                                                       toDate:[NSDate date]
                                                      options:0];
    
 
    NSPredicate *predicate = [store predicateForIncompleteRemindersWithDueDateStarting:oneDayAgo ending:oneYearFromNow calendars:[store calendarsForEntityType:EKEntityTypeReminder]];
    
    NSPredicate *predicateAll = [store predicateForRemindersInCalendars:nil];
    

    
    [store fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders) {
        for (EKReminder *reminder in reminders) {
            // do something for each reminder
        }
    }];
    [store calendarItemWithIdentifier:@""];
    
    
    [store fetchRemindersMatchingPredicate:predicateAll completion:^(NSArray *reminders) {
       
        for (EKReminder *reminder in reminders) {
            // do something for each reminder
        }
    }];
    
    
    [store fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders) {
        
        for (EKReminder *reminder in reminders) {
            // do something for each reminder
        }
    }];
    
//    [store predicateForIncompleteRemindersWithDueDateStarting:oneDayAgo
//                                                                                ending:oneYearFromNow
//                                                                             calendars:nil];
    

//    NSArray *events = [store eventsMatchingPredicate:predicate];
//    NSLog(@"eventsevents %@",events);
    return nil;

}
+(void)saveEventIntoReminderWithTitle:(NSString *)title
                                notes:(NSString *)notes
                            startDate:(NSDate *)startDate
                              endDate:(NSDate *)endDate
                                alarm:(EKAlarm *)alarm
                             priority:(NSInteger)priority
                            completed:(BOOL)completed
                         successBlock:(STCalendarReminderToolSaveSuccessBlock)successBlock
                            failBlock:(STCalendarReminderToolSaveFailBlock)failBlock{
    
    EKEventStore *store = [STCalendarReminderTool shareinstance];
    [store requestAccessToEntityType:EKEntityTypeReminder
                          completion:
     ^(BOOL granted, NSError *error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             if (error) {
                 if (failBlock) {
                     failBlock(error);
                 }
                 return;
             }
             if (!granted) {
                 //被用户拒绝，不允许访问提醒
                 return;
             }

             EKReminder *reminder = [EKReminder reminderWithEventStore:store];
             [reminder setCalendar:[store defaultCalendarForNewReminders]];
             reminder.title       = title;
             reminder.notes       = notes;
             reminder.completed   = completed;
             reminder.priority    = priority;
             [reminder addAlarm:alarm];
            
             NSCalendar *calender = [NSCalendar currentCalendar];
             [calender setTimeZone:[NSTimeZone systemTimeZone]];
             NSInteger flags      = NSCalendarUnitYear | NSCalendarUnitMonth |
             NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute |
             NSCalendarUnitSecond;
             NSDateComponents* startDateComp = [calender components:flags fromDate:startDate];
             startDateComp.timeZone = [NSTimeZone systemTimeZone];
            
             reminder.startDateComponents = startDateComp;
             
             NSDateComponents* endDateComp = [calender components:flags fromDate:startDate];
             endDateComp.timeZone   = [NSTimeZone systemTimeZone];
             reminder.dueDateComponents = endDateComp;
         
             NSError *err;
             [store saveReminder:reminder commit:YES error:&err];
             if (!err) {
                 if (successBlock) {
                     successBlock(reminder.calendarItemIdentifier);
                 }
             }else{
                 if (failBlock) {
                     failBlock(err);
                 }
             }
         });
     }];
}
@end
