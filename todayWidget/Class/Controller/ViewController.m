//
//  ViewController.m
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "ViewController.h"

#import "STEventModel.h"
#import "STDateAlertView.h"
#import "STEventLevelChangetTextFiled.h"

@interface ViewController ()
<
UITextFieldDelegate
,STEventLevelChangetTextFiledDelegate
>
@property (weak, nonatomic) IBOutlet UITextField *titleTextF;
@property (weak, nonatomic) IBOutlet UITextField *contentTextF;
@property (strong, nonatomic) STEventModel *eventModel;
@property (weak, nonatomic) IBOutlet STEventLevelChangetTextFiled *levelTextFiled;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupsubviews];
}
#pragma -mark UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.titleTextF) {
        self.eventModel.enentTile = textField.text;
    }else if (textField == self.contentTextF){
        self.eventModel.enentConent = textField.text;
    }
    
    else if (textField == self.levelTextFiled){
    
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.returnKeyType = UIReturnKeyDone;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma  -mark STEventLevelChangetTextFiledDelegate
-(void)eventchangeWithClickType:(STEventLevelChangetTextFiledClickType)clickType{
    [self.view endEditing:YES];
    
    NSInteger level = self.eventModel.level;
    if (clickType == STEventLevelChangetTextFiledClicklessenType) {
        level =  (level <  3 ) ? level+1 : 0;
    }else{
        level = (level >  0 ) ? level-1 : 3;
    }
    
    self.eventModel.level = level;
    self.levelTextFiled.text = self.eventModel.levelStr;
}
- (IBAction)selectBeginDate:(id)sender {
    [self.view endEditing:YES];
    UIButton *button = (UIButton *)sender;
    [STDateAlertView showDateAlertViewWithSelctBlock:^(NSDate *selectDate) {
        self.eventModel.beginDate = selectDate;
        [button setTitle:self.eventModel.beginDatestr forState:UIControlStateNormal];
    }];
}
- (IBAction)selectEndDate:(id)sender {
    [self.view endEditing:YES];
    UIButton *button = (UIButton *)sender;
    [STDateAlertView showDateAlertViewWithSelctBlock:^(NSDate *selectDate) {
        [button setTitle:self.eventModel.endDatestr forState:UIControlStateNormal];
        self.eventModel.endDate = selectDate;
    }];
}
- (IBAction)addButtonOnClick:(id)sender {
    [self.view endEditing:YES];
}
-(void)setupsubviews{
    self.titleTextF.delegate   = self;
    self.contentTextF.delegate = self;
    self.levelTextFiled.delegate = self;
    self.levelTextFiled.levelTextFiledDelegate = self;
    self.levelTextFiled.text = self.eventModel.levelStr;
}
-(STEventModel *)eventModel{
    if (!_eventModel) {
        _eventModel = [[STEventModel alloc] init];
    }
    return _eventModel;
}
@end
