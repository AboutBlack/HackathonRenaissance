//
//  PublicViewController.m
//  HackathonClient
//
//  Created by Yuqing Zhang on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import "PublicViewController.h"
#import "Header.h"

@interface PublicViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UIButton *uploadImageButton;
- (IBAction)uploadImageButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButtonClick;

@end

@implementation PublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)awakeFromNib
{
    [self.titleTextField setDelegate:self];
    [self.authorTextField setDelegate:self];
    [self.timeTextField setDelegate:self];
    NSString *author = [[NSUserDefaults standardUserDefaults]objectForKey:kUser_Name];
    self.authorTextField = author;
}

- (IBAction)uploadImageButtonClick:(UIButton *)sender {
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.titleTextField) {
        return YES;
    } else if (textField == self.authorTextField) {
        return NO;
    } else if (textField == self.titleTextField) {
        return NO;
    }
    return NO;
}
@end
