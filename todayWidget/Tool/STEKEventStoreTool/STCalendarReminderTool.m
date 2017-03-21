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

+(NSArray *)fetchEventsWithStartDate:(NSDate *)startDate
                            endDate:(NSDate *)enDate{
    
    EKEventStore *store = [STCalendarReminderTool shareinstance];
    NSPredicate *predicate = [store predicateForEventsWithStartDate:startDate
                                                            endDate:enDate
                                                          calendars:nil];
    NSArray *events = [store eventsMatchingPredicate:predicate];
    NSInteger i = 1;
    for (EKEvent *event in events) {
         NSLog(@"第 %zd 个提醒 %@",i,event);
        i++;
    }
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
                     NSLog(@"calendarItemIdentifier  %@ \n\n\n eventIdentifier %@",event.calendarItemIdentifier,event.eventIdentifier) ;
                     successBlock(event.eventIdentifier);
                 }
             }else{

                 if (failBlock) {
                     failBlock(err);
                 }
             }
         });
     }];
}

+(BOOL)deleteEventWithEventIdentifier:(NSString *)eventIdentifier{
    
    EKEventStore *store = [STCalendarReminderTool shareinstance];
    EKEvent *event = [store eventWithIdentifier:eventIdentifier];
    return  [store removeEvent:event span:EKSpanThisEvent commit:YES error:nil];
}

+(void)fetchRemindersWithStartDate:(NSDate *)starDate
                          endDate:(NSDate *)endDate
                          success:(STCalendarReminderToolFetchSuccessBlock)success{
    
    EKEventStore *store = [STCalendarReminderTool shareinstance];
    NSPredicate *predicate = [store predicateForIncompleteRemindersWithDueDateStarting:starDate
                                                                                ending:endDate
                                                                             calendars:[store calendarsForEntityType:EKEntityTypeReminder]];
    [store fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders) {
        if (success) {
            success(reminders);
        }
    }];
}
+(void)fetchAllRemindersWithsuccess:(STCalendarReminderToolFetchSuccessBlock)success{
    
    EKEventStore *store      = [STCalendarReminderTool shareinstance];
    NSPredicate  *predicate  = [store predicateForRemindersInCalendars:nil];
    [store fetchRemindersMatchingPredicate:predicate completion:^(NSArray *reminders) {
        
        NSInteger i = 1;
        for (EKReminder *reminder in reminders) {
            NSLog(@"第 %zd 个提醒 %@",i,reminder);
            i++;
        }
        if (success) {
            success(reminders);
        }
    }];
}
+(EKCalendarItem *)fetchReminderWithIdentier:(NSString *)identifer{

    EKEventStore *store = [STCalendarReminderTool shareinstance];
    EKCalendarItem *item = [store calendarItemWithIdentifier:identifer];
    NSLog(@"item  item %@",item);
    return item;
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
+(BOOL)deleteReminderWithIdentifer:(NSString *)identifier{
    
    EKEventStore *store = [STCalendarReminderTool shareinstance];
    EKCalendarItem *item = [store calendarItemWithIdentifier:identifier];


    return YES;
}
@end
