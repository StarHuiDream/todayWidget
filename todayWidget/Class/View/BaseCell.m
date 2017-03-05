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
}
-(instancetype)init{
    self = [super init];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}
//-(void)setFrame:(CGRect)frame{
//    //修改cell的左右边距为10;
//    //修改cell的Y值下移10;
//    //修改cell的高度减少10;
//    
//    static CGFloat margin = 10;
//    frame.origin.x = margin;
//    frame.size.width -= 2 * frame.origin.x;
//    frame.origin.y += margin;
//    frame.size.height -= margin;
//    [super setFrame:frame];
//};
@end
