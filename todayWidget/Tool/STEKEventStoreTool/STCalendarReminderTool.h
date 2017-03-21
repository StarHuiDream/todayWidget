//
//  STCalendarReminderTool.h
//  todayWidget
//
//  Created by StarHui on 2017/3/12.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

/**
 * STCalendarReminderToolSaveSuccessBlock
 * eventIdentifier
 */
typedef void (^STCalendarReminderToolSaveSuccessBlock)(NSString* eventIdentifier);

typedef void (^STCalendarReminderToolSaveFailBlock)(NSError *err);
/**
 * STCalendarReminderToolFetchSuccessBlock
 */
typedef void (^STCalendarReminderToolFetchSuccessBlock)(NSArray *eventArr);

@interface STCalendarReminderTool : NSObject
+(NSArray *)fetchAllEventInUserCalendar;
+(EKEvent *)fetchEventWithIdentifer:(NSString *)eventidentifer;
/*
 * title  事件标题
 * notes  事件备注
 * location 事件地址
 * startDate 开始日期
 * endDate   结束日期
 * alarms 闹钟
 * availability 事件调度
 */
+(void)saveEventWithTitle:(NSString *)title
                    notes:(NSString *)notes
                 location:(NSString *)location
                startDate:(NSDate *)startDate
                  endDate:(NSDate *)endDate
                   alarms:(NSArray<EKAlarm *> *)alarms
                      URL:(NSURL *)URL
             availability:(EKEventAvailability)availability
             successBlock:(STCalendarReminderToolSaveSuccessBlock)successBlock
                failBlock:(STCalendarReminderToolSaveFailBlock)failBlock;
//+(void)modifyEventWith:(NSString *)eventIdentifier;
+(BOOL)deleteEventWithEventIdentifier:(NSString *)eventIdentifier;

+(NSArray *)fetchAllReminder;
/*
 * title  事件标题
 * notes  事件备注
 * startDate 开始日期
 * endDate   结束日期
 * alarms 闹钟
 * priority 事件调度(1-4 高 5中   6-9低  0 不设置）
 * completed 
 */
+(void)saveEventIntoReminderWithTitle:(NSString *)title
                                notes:(NSString *)notes
                            startDate:(NSDate *)startDate
                              endDate:(NSDate *)endDate
                                alarm:(EKAlarm *)alarm
                             priority:(NSInteger)priority
                            completed:(BOOL)completed
                         successBlock:(STCalendarReminderToolSaveSuccessBlock)successBlock
                            failBlock:(STCalendarReminderToolSaveFailBlock)failBlock;
@end
