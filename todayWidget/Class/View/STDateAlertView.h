//
//  STDateAlertView.h
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 选择日期之后的回掉 */
typedef void(^STDateClickBlock) (NSDate *selectDate);
/** 消失 */
typedef void(^STDateDismissBlock)();

@interface STDateAlertView : UIView
+(instancetype)instance;
+(void)showDateAlertViewWithSelctBlock:(STDateClickBlock)selectBlock
                          dismissBlock:(STDateDismissBlock) dismissBlock;
@end
