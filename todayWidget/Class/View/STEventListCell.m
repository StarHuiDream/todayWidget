//
//  STEventListCell.m
//  todayWidget
//
//  Created by StarHui on 2017/3/2.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "STEventListCell.h"
#import "STEventModel.h"

@interface STEventListCell()
@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *enentContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventCreateDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventBeginDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventEndDateLabel;

@property (strong, nonatomic) STEventModel *eventModel;

@end

@implementation STEventListCell
+(instancetype)instanceWithEventModel:(STEventModel *)eventModel tableView:(UITableView *)tableView{

    STEventListCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"STEventListCell"];
    cell.eventModel = eventModel;
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
-(void)layoutSubviews{

    [super layoutSubviews];
    self.contentView.frame = CGRectMake(8, 5, self.bounds.size.width - 18 , self.bounds.size.height - 12);
    
    self.contentView.layer.cornerRadius = 5.0f;
    self.contentView.layer.borderWidth  = 1.0f;
    
    switch (self.eventModel.eventLevel) {
        case eventLevelImportType:
            self.contentView.layer.borderColor = [UIColor redColor].CGColor;
            self.eventLevelLabel.textColor = [UIColor redColor];
            break;
        case eventLevelNormalType:
            self.contentView.layer.borderColor = [UIColor blueColor].CGColor;
            self.eventLevelLabel.textColor = [UIColor blueColor];
            break;
        case eventLevelLittleCaseType:
            self.contentView.layer.borderColor = [UIColor greenColor].CGColor;
            self.eventLevelLabel.textColor = [UIColor greenColor];
            break;
            
        default:
            break;
    }
    [self setNeedsUpdateConstraints];
}
-(void)setEventModel:(STEventModel *)eventModel{
    _eventModel                    = eventModel;
    self.eventTitleLabel.text      = [NSString stringWithFormat:@"标题:%@",eventModel.eventTitle] ;
    self.enentContentLabel.text    = eventModel.eventContent;
    self.eventCreateDateLabel.text = [NSString stringWithFormat:@"创建日期:%@",eventModel.createDateStr];
    self.eventBeginDateLabel.text  = [NSString stringWithFormat:@"开始日期:%@",eventModel.beginDatestr];
    self.eventEndDateLabel.text    = [NSString stringWithFormat:@"结束日期:%@",eventModel.endDatestr];
    self.eventLevelLabel.text      = [NSString stringWithFormat:@"级别:%@",eventModel.levelStr];
}
@end
