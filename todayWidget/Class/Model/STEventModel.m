//
//  STEventModel.m
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "STEventModel.h"
 #import <objc/runtime.h>

@interface STEventListModel()<NSCoding>
@end

@implementation STEventListModel

-(void)writeDataWith:(STEventModel *)eventModel{
    
    NSString *path = DataPath;
    [NSKeyedArchiver archiveRootObject:nil toFile:path];
}
-(instancetype)fetchData{

    return nil;
}

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


@interface STEventModel()<NSCoding>
@end
@implementation STEventModel
-(instancetype)init{
    self = [super init];
    if (self) {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy年MM月dd日 HH:mm";
        self.dateFormatter = dateFormatter;
        self.level         = 0;
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
-(void)setLevel:(eventLevelType)level{
    _level = level;
    switch (level) {
        case eventLevelImportType:
            _levelStr = @"重要";
            break;
        case eventLevelNormalType:
            _levelStr = @"普通";
            break;
        case eventLevelLittleCaseType:
            _levelStr = @"微小";
            break;
        case eventLevelLittleignoreType:
            _levelStr = @"忽略";
            break;
            
        default:
            _levelStr = @"";
            break;
    }
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    //归档存储自定义对象
    unsigned int count = 0;
    //获得指向该类所有属性的指针
    objc_property_t *properties =     class_copyPropertyList([self class], &count);
    for (int i =0; i < count; i ++) {
        //获得
        objc_property_t property = properties[i];        //根据objc_property_t获得其属性的名称--->C语言的字符串
        const char *name = property_getName(property);
        NSString *key = [NSString   stringWithUTF8String:name];
        //      编码每个属性,利用kVC取出每个属性对应的数值
        [encoder encodeObject:[self valueForKeyPath:key] forKey:key];
    }
    free(properties);
}
- (instancetype)initWithCoder:(NSCoder *)decoder{
    
    if (self = [super init]) {
        //归档存储自定义对象
        unsigned int count = 0;
        //获得指向该类所有属性的指针
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (int i =0; i < count; i ++) {
            objc_property_t property = properties[i];        //根据objc_property_t获得其属性的名称--->C语言的字符串
            const char *name = property_getName(property);
            NSString *key = [NSString stringWithUTF8String:name];        //解码每个属性,利用kVC取出每个属性对应的数值
            [self setValue:[decoder decodeObjectForKey:key] forKeyPath:key];
        }
        free(properties);
    }
    return self;
}
@end
