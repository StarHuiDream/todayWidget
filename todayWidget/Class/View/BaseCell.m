//
//  BaseCell.m
//  todayWidget
//
//  Created by StarHui on 2017/3/3.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setsubViews];
}
-(instancetype)init{
    self = [super init];
    [self setsubViews];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}
-(void)setsubViews{
 self.selectionStyle = UITableViewCellSelectionStyleNone;
}
@end
