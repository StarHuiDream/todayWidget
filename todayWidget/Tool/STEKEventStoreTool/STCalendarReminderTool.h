//
//  STCalendarReminderTool.h
//  todayWidget
//
//  Created by StarHui on 2017/3/12.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>

@interface STCalendarReminderTool : NSObject
+(bool)saveEventIntoCalendar;
+(NSArray *)fetchAllEventInUserCalendar;
@end
