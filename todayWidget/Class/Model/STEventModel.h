//
//  STEventModel.h
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#define  DataPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"STEventList"];
@class STEventModel;
@interface STEventListModel : NSObject
@property (copy, nonatomic) NSArray <STEventModel*>*eventList;
/**
 * 向本地存储数据
 */
-(void)writeDataWith:(STEventModel *)eventModel;
/**
 * 获取本地存储的数据
 */
-(instancetype)fetchData;
@end

typedef NS_ENUM(NSInteger,eventLevelType) {
    eventLevelImportType = 0, // 重要
    eventLevelNormalType,     // 普通
    eventLevelLittleCaseType,  // 微小
    eventLevelLittleignoreType
};
@interface STEventModel : NSObject
/** 事件名称 */
@property (copy, nonatomic)  NSString *enentTile;
/** 事件内容 */
@property (copy, nonatomic)  NSString *enentConent;
/** 事件添加日期 */
@property (strong, nonatomic) NSDate *addDate;
/** 事件 开始日期 */
@property (strong, nonatomic) NSDate *beginDate;
@property (copy, nonatomic) NSString *beginDatestr;
/** 事件结束日期 */
@property (strong, nonatomic) NSDate *endDate;
@property (copy, nonatomic) NSString *endDatestr;
/** 事件的级别 */
@property (assign, nonatomic) eventLevelType level;
@property (copy, nonatomic) NSString *levelStr;
/** 日期格式 */
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@end
