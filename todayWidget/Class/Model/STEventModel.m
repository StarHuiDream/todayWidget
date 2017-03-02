//
//  STEventModel.m
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "STEventModel.h"
 #import <objc/runtime.h>

@interface STBaseMdodel()<NSCoding>
@end

@implementation STBaseMdodel
// 有继承关系对象的归档解档
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        Class c = self.class;
        // 截取类和父类的成员变量
        while (c && c != [NSObject class]) {
            unsigned int count = 0;
            Ivar *ivars = class_copyIvarList(c, &count);
            for (int i = 0; i < count; i++) {
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
                id value = [aDecoder decodeObjectForKey:key];
                [self setValue:value forKey:key];
            }
            // 获得c的父类
            c = [c superclass];
            free(ivars);
        }
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    Class c = self.class;
    // 截取类和父类的成员变量
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        
        Ivar *ivars = class_copyIvarList(c, &count);
        
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            id value = [self valueForKey:key];
            
            [aCoder encodeObject:value forKey:key];
        }
        c = [c superclass];
        // 释放内存
        free(ivars);
    }
}
@end


@implementation STEventListModel
-(void)writeDataWith:(STEventModel *)eventModel{
    NSString *path = DataPath;
    STEventListModel *listModel = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSMutableArray *tempMutarr = [listModel.eventList copy];
    if (tempMutarr.count > 0) {
        tempMutarr = [NSMutableArray array];
    }
    [tempMutarr addObject:eventModel];
    listModel.eventList = [tempMutarr copy];
    [NSKeyedArchiver archiveRootObject:listModel toFile:path];
}
+(instancetype)fetchData{
    NSString *path = DataPath;
    STEventListModel *listModel = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return listModel;
}
-(BOOL)deleteEventWithEventModel:(STEventModel *)eventModel{
    BOOL result = NO;
    NSString *path = DataPath;
    STEventListModel *listModel = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSMutableArray *tempMutarr  = [NSMutableArray arrayWithArray:[listModel.eventList copy]];
    if (tempMutarr.count > 0) {
        for (STEventModel *Model in tempMutarr) {
            if ([Model.eventId isEqualToString:eventModel.eventId]) {
                [tempMutarr removeObject:Model];
                result = YES;
                break;
            }
        }
    }
    listModel.eventList = [tempMutarr copy];
    self.eventList      = [listModel.eventList copy];
    return ([NSKeyedArchiver archiveRootObject:listModel toFile:path]  && result);
}
@end
@implementation STEventModel
-(instancetype)init{
    self = [super init];
    if (self) {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy年MM月dd日";
        self.dateFormatter = dateFormatter;
        self.eventLevel         = 1;
    }
    return self;
}
-(void)setBeginDate:(NSDate *)beginDate{
    _beginDate = beginDate;
    if (beginDate) {
        _beginDatestr = [_dateFormatter stringFromDate:beginDate];
    }
}
-(void)setEndDate:(NSDate *)endDate{
    _endDate = endDate;
    if (endDate) {
        _endDatestr = [_dateFormatter stringFromDate:endDate];
    }
}
-(void)setCreateDate:(NSDate *)createDate{
    _createDate =createDate;
    if (createDate) {
        _createDateStr = [_dateFormatter stringFromDate:createDate];
    }
}
-(void)setEventLevel:(eventLevelType)eventLevel{
    _eventLevel = eventLevel;
    switch (eventLevel) {
        case eventLevelImportType:
            _levelStr = @"重要";
            break;
        case eventLevelNormalType:
            _levelStr = @"普通";
            break;
        case eventLevelLittleCaseType:
            _levelStr = @"微小";
            break;
        default:
            _levelStr = @"";
            break;
    }

}
-(BOOL)writeData{
    NSString *path = DataPath;
    self.eventId    = [self setupRandomString];
    self.createDate = [NSDate date];
    STEventListModel *listModel = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSMutableArray *tempMutarr = [NSMutableArray arrayWithArray:[listModel.eventList copy]];
    if (!(tempMutarr.count > 0) ) {
        listModel = [[STEventListModel alloc] init];
        tempMutarr = [NSMutableArray array];
    }
    [tempMutarr addObject:self];
    listModel.eventList = [tempMutarr copy];
    return  [NSKeyedArchiver archiveRootObject:listModel toFile:path];
}
-(NSString *)setupRandomString{
    NSMutableString *tempMutStr =[[NSMutableString alloc] init];
    for(int i = 0; i < 6; i++){
        NSString *randomnumStr = [NSString stringWithFormat:@"%zd", arc4random() % 10];
        tempMutStr = (NSMutableString *)[tempMutStr stringByAppendingString:randomnumStr];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%@%@",currentDateStr,tempMutStr];
}
@end
