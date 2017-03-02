//
//  STEventLevelChangetTextFiled.h
//  todayWidget
//
//  Created by StarHui on 2017/3/2.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,STEventLevelChangetTextFiledClickType){

    STEventLevelChangetTextFiledClickAddType = 0,   // 添加
    STEventLevelChangetTextFiledClicklessenType     // 减少
};
@protocol STEventLevelChangetTextFiledDelegate <NSObject>
-(void)eventchangeWithClickType:(STEventLevelChangetTextFiledClickType)clickType;
@end
@interface STEventLevelChangetTextFiled : UITextField
@property (weak, nonatomic) id<STEventLevelChangetTextFiledDelegate> levelTextFiledDelegate;
@end
