//
//  STEventModel.h
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>





#define  DataPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"STEventList"];

#define stsystemVersion  [[[UIDevice currentDevice] systemVersion] floatValue]


static NSString *AppGroupNameStr = @"group.STTodyaWidget.data";
static NSString *eventLsitData   = @"eventLsitDataKey";

@interface STBaseMdodel : NSObject
@end

@class STEventModel;
@interface STEventListModel : STBaseMdodel
@property (copy, nonatomic) NSArray <STEventModel*>*eventList;

/**
 * 获取本地存储的数据
 */
+(instancetype)fetchData;
/**
 * 删除一个事件
 */
-(BOOL)deleteEventWithEventModel:(STEventModel *)eventModel;
@end

typedef NS_ENUM(NSInteger,eventLevelType) {
    eventLevelImportType = 1, // 重要
    eventLevelNormalType,     // 普通
    eventLevelLittleCaseType  // 微小
};
@interface STEventModel : STBaseMdodel
/** 事件编号 */
@property (copy, nonatomic) NSString *eventId;
/** 事件名称 */
@property (copy, nonatomic)  NSString *eventTitle;
/** 事件内容 */
@property (copy, nonatomic)  NSString *eventContent;
/** 事件添加日期 */
@property (strong, nonatomic) NSDate *createDate;
@property (copy, nonatomic) NSString *createDateStr;
/** 事件 开始日期 */
@property (strong, nonatomic) NSDate *beginDate;
@property (copy, nonatomic) NSString *beginDatestr;
@property (copy, nonatomic) NSString *beginTimestr;

/** 事件结束日期 */
@property (strong, nonatomic) NSDate *endDate;
@property (copy, nonatomic) NSString *endDatestr;
@property (copy, nonatomic) NSString *endTimestr;
/** 事件的级别 */
@property (assign, nonatomic) eventLevelType eventLevel;
@property (copy, nonatomic) NSString *levelStr;
/** 日期格式 */
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
/** 时间格式 */
@property (strong, nonatomic) NSDateFormatter *timeFormatter;
/*
 * 将数据存入本地
 */
-(BOOL)writeData;
@end
