//
//  STDateAlertView.m
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "STDateAlertView.h"

@interface STDateAlertView()
@property (weak, nonatomic) UIDatePicker *datePicker;
@property (weak, nonatomic) UIButton *sureButton;
@end

@implementation STDateAlertView
+(instancetype)instance{
    
    STDateAlertView *view = [[STDateAlertView alloc] init];
    return view;
}
+(void)showDateAlertViewWithSelctBlock:(STDateClickBlock)selectBlock
                          dismissBlock:(STDateDismissBlock) dismissBlock{

}
-(instancetype)init{
    self = [super init];
    
    return self;
}
@end
