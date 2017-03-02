//
//  ViewController.m
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "ViewController.h"

#import "STEventModel.h"

@interface ViewController ()
<
UITextFieldDelegate
>
@property (weak, nonatomic) IBOutlet UITextField *titleTextF;
@property (weak, nonatomic) IBOutlet UITextField *contentTextF;
@property (strong, nonatomic) STEventModel *eventModel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma -mark UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.titleTextF) {
        self.eventModel.enentTile = textField.text;
    }else if (textField == self.contentTextF){
        self.eventModel.enentConent = textField.text;
    }
}
- (IBAction)addButtonOnClick:(id)sender {
    [self.view endEditing:YES];
}
-(void)setupsubviews{
    self.titleTextF.delegate = self;
    self.contentTextF.delegate = self;
}
-(STEventModel *)eventModel{
    if (!_eventModel) {
        _eventModel = [[STEventModel alloc] init];
    }
    return _eventModel;
}
@end
