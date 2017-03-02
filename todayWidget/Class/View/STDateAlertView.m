//
//  STDateAlertView.m
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "STDateAlertView.h"

#define SCREENWIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT  [[UIScreen mainScreen] bounds].size.height
#define rgba(r, g, b, a)    [UIColor colorWithRed: r/255.0 green: g/255.0 blue: b/255.0 alpha: a]

static CGFloat buttonHeight  = 40.0f;
static CGFloat buttonBorderW = 0.0f;
static CGFloat margin        = 0.0f;

@interface STDateAlertView()
@property (weak, nonatomic) UIDatePicker *datePicker;
@property (weak, nonatomic) UIButton *sureButton;
@property (strong, nonatomic) STDateSureBlock sureBlock;
@property (weak, nonatomic) UIView *bcgView;
@end

@implementation STDateAlertView
+(instancetype)instanceWithSelectBlock:(STDateSureBlock)sureBlock{
    
    STDateAlertView *view = [[STDateAlertView alloc] init];
    view.sureBlock        = sureBlock;
    return view;
}
+(void)showDateAlertViewWithSelctBlock:(STDateSureBlock)sureBlock{
    
    STDateAlertView *view = [STDateAlertView instanceWithSelectBlock:sureBlock];
     view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.datePicker.frame = CGRectMake(0, SCREENHEIGHT / 2, SCREENWIDTH, SCREENHEIGHT / 2 - buttonHeight - 2 *buttonBorderW);
    self.sureButton.frame = CGRectMake(margin , CGRectGetMaxY(self.datePicker.frame), SCREENWIDTH - 2 * margin, buttonHeight);
}
/**
 * 初始化所有控件
 */
-(void)setupSubviews{
    
    self.backgroundColor = rgba(1, 1, 1, 0.7);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissThisView)];
    [self addGestureRecognizer:tap];

    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker setMinimumDate:[NSDate date]];
    datePicker.backgroundColor = [UIColor whiteColor];
    [self addSubview:datePicker];
    self.datePicker = datePicker;
    
    UIButton *sureButton = [[UIButton alloc] init];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTintColor:[UIColor blackColor]];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureButton addTarget:self action:@selector(sureButtonOnClick) forControlEvents:UIControlEventTouchDown];
    [sureButton setBackgroundColor:rgba(78, 184, 248,1)];
//    sureButton.layer.cornerRadius = 5;
    [self addSubview:sureButton];
    self.sureButton = sureButton;
}
-(void)dismissThisView{
    [self removeFromSuperview];
}
-(void)sureButtonOnClick{
    
    [self dismissThisView];
    if (self.sureBlock) {
        NSDate *date = self.datePicker.date;
        if (!date) {
            date = [NSDate date];
        }
        self.sureBlock(date);
    }
}
@end
