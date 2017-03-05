//
//  STEventListCell.h
//  todayWidget
//
//  Created by StarHui on 2017/3/2.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
@class STEventModel;
@interface STEventListCell : BaseCell
+(instancetype)instanceWithEventModel:(STEventModel *)eventModel tableView:(UITableView *)tableView;
@end
