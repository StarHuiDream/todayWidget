//
//  ViewController.m
//  todayWidget
//
//  Created by StarHui on 2017/3/1.
//  Copyright © 2017年 StarHui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<
UITextFieldDelegate
>
@property (weak, nonatomic) IBOutlet UITextField *titleTextF;
@property (weak, nonatomic) IBOutlet UITextField *contentTextF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
#pragma -mark UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{

}
- (IBAction)addButtonOnClick:(id)sender {
    [self.view endEditing:YES];
    
}
-(void)setupsubviews{
    self.titleTextF.delegate = self;
    self.contentTextF.delegate = self;
}
@end
