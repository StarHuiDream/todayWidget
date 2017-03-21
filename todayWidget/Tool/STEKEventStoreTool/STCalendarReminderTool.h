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

/** 查询一个时间范围内的事件
 * startDate enDate 查询的日期范围
 */
+(NSArray *)fetchEventsWithStartDate:(NSDate *)startDate
                             endDate:(NSDate *)enDate;

/** 用唯一标示查询一个事件(只能查询日历里面的事件)
 * eventidentifer 唯一标示
 */
+(EKEvent *)fetchEventWithIdentifer:(NSString *)eventidentifer;

/** 向日历添加一个事件
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
/** 
 * 删除一个事件
 * eventIdentifier 事件唯一标示
 */
+(BOOL)deleteEventWithEventIdentifier:(NSString *)eventIdentifier;

/**
 * 查询所有的提醒
 */
+(void)fetchAllRemindersWithsuccess:(STCalendarReminderToolFetchSuccessBlock)success;

/** 
 * 查询一个时间范围里面的提醒
 * starDate endDate
 */
+(void)fetchRemindersWithStartDate:(NSDate *)starDate
                           endDate:(NSDate *)endDate
                           success:(STCalendarReminderToolFetchSuccessBlock)success;
/**
 * 用唯一标示查询提醒（⚠️这个方法也可以查询日历里面的事件）
 */
+(EKCalendarItem *)fetchReminderWithIdentier:(NSString *)identifier;
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
/**
 * 删除一个提醒
 */
+(BOOL)deleteReminderWithIdentifer:(NSString *)identifier;
@end
