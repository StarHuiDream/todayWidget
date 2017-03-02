//
//  STEventLevelChangetTextFiled.m
//  todayWidget
//
//  Created by StarHui on 2017/3/2.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "STEventLevelChangetTextFiled.h"

static CGFloat height = 30.0f;

@interface STEventLevelChangetTextFiled()

@property (weak, nonatomic) UIView *coverView;
@property (weak, nonatomic) UIButton *addButton;
@property (weak, nonatomic) UIButton *lessenButton;

@end

@implementation STEventLevelChangetTextFiled
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
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
    self.coverView.frame = CGRectMake(height, 0, self.bounds.size.width - 2 *height, height);
    [self setNeedsUpdateConstraints];
    
}
-(void)setupSubviews{
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    
    self.rightViewMode = UITextFieldViewModeAlways;
    self.leftViewMode  = UITextFieldViewModeAlways;
    
    UIView *coverView = [[UIView alloc] init];
     coverView.backgroundColor = [UIColor clearColor];
    [self addSubview:coverView];
    self.coverView = coverView;
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, height, height )];
    [addButton setTitle:@"↑" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor lightGrayColor]];
    [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonOnClick) forControlEvents:UIControlEventTouchDown];
    self.rightView = addButton;
    self.addButton = addButton;
    
    
    UIButton *lessenButton = [[UIButton alloc] initWithFrame:CGRectMake(0 , 0, height, height)];
    [lessenButton setTitle:@"↓" forState:UIControlStateNormal];
    [lessenButton setBackgroundColor:[UIColor lightGrayColor]];
    [lessenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lessenButton addTarget:self action:@selector(lessenButtonOnClick) forControlEvents:UIControlEventTouchDown];
    self.leftView = lessenButton;
    self.lessenButton = lessenButton;
}
-(void)addButtonOnClick{
    if (self.levelTextFiledDelegate && [self.levelTextFiledDelegate respondsToSelector:@selector(eventchangeWithClickType:)]) {
        [self.levelTextFiledDelegate eventchangeWithClickType:STEventLevelChangetTextFiledClickAddType];
    }
}
-(void)lessenButtonOnClick{
    if (self.levelTextFiledDelegate && [self.levelTextFiledDelegate respondsToSelector:@selector(eventchangeWithClickType:)]) {
        [self.levelTextFiledDelegate eventchangeWithClickType:STEventLevelChangetTextFiledClicklessenType];
    }
}
@end
