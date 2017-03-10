//
//  STTWEventCell.h
//  todayWidget
//
//  Created by StarHui on 2017/3/8.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "BaseCell.h"
@class STEventModel;


@interface STTWEventCell : BaseCell
+(instancetype)instanceWithEventModel:(STEventModel *)eventModel tableView:(UITableView *)tableView;
@end
