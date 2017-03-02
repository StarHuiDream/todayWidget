//
//  STEventModel.h
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface STEventListModel : NSObject
@property (copy, nonatomic) NSArray *eventList;
@end

typedef NS_ENUM(NSInteger,eventLevelType) {
    eventLevelImportType = 0,
    eventLevelNormalType,
    eventLevelLittleCaseType
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
/** 事件结束日期 */
@property (strong, nonatomic) NSDate *endDate;
/** 事件的级别 */
@property (assign, nonatomic) eventLevelType level;

@end
