//
//  STTWEventCell.m
//  todayWidget
//
//  Created by StarHui on 2017/3/8.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "STTWEventCell.h"
#import "STEventModel.h"

@interface STTWEventCell()
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (strong, nonatomic) STEventModel *eventModel;
@end

@implementation STTWEventCell
+(instancetype)instanceWithEventModel:(STEventModel *)eventModel tableView:(UITableView *)tableView{
    
    STTWEventCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"STTWEventCell"];
    cell.eventModel = eventModel;
    return cell;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    if (stsystemVersion >= 10.0) {
    
    }else{
        self.eventTitleLabel.textColor   = [UIColor whiteColor];
        self.beginTimeLabel.textColor    = [UIColor whiteColor];
        self.endTimeLabel.textColor      = [UIColor whiteColor];
    }
}

-(void)setEventModel:(STEventModel *)eventModel{
    _eventModel                        = eventModel;
    self.eventTitleLabel.text          = [NSString stringWithFormat:@"今天要做：%@",eventModel.eventTitle];
    self.beginTimeLabel.text           = [NSString stringWithFormat:@"开始于：%@",eventModel.beginTimestr];
    self.endTimeLabel.text             = [NSString stringWithFormat:@"结束于：%@",eventModel.endTimestr];
}
@end
