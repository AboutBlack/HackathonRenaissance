//
//  PublicViewController.m
//  HackathonClient
//
//  Created by Yuqing Zhang on 16/6/25.
//  Copyright © 2016年 AboutBlack. All rights reserved.
//

#import "PublicViewController.h"
#import "Header.h"
#import "TZImagePickerController.h"
#import "AFNetworking.h"
#import "HSDatePickerViewController.h"
#import "NSString+Hack.h"
#import "SVProgressHUD.h"

@interface PublicViewController ()<UITextFieldDelegate,TZImagePickerControllerDelegate,HSDatePickerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UIButton *uploadImageButton;
- (IBAction)uploadImageButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButtonClick;


@property (strong,nonatomic) NSDate *selectDate;
@property (strong,nonatomic) NSArray *imageArray;

@end

@implementation PublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发布直播";
    
    
    [self.titleTextField setDelegate:self];
    [self.authorTextField setDelegate:self];
    [self.timeTextField setDelegate:self];

    
    [self.submitButtonClick addTarget:self action:@selector(submitButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)uploadImageButtonClick:(UIButton *)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:4 delegate:self];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.titleTextField) {
        return YES;
    } else if (textField == self.authorTextField) {
        return NO;
    } else if (textField == self.timeTextField) {
        [self showDatePicker];
        return NO;
    }
    return NO;
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    NSLog(@"photos:%@",photos);
    if (photos.count < 1) {
        return;
    }
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://hack2016.applinzi.com/index.php/Home/Index/fileUpload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (UIImage *image in photos) {
            NSData *dataObj = UIImageJPEGRepresentation(image,0.5);
            [formData appendPartWithFileData:dataObj name:@"photo[]" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
        }
    } error:nil];
    
    __weak PublicViewController *weakSelf = self;
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          [SVProgressHUD dismiss];
                          NSLog(@"Error: %@", error);
                          UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"上传图片失败，请重新上传" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                          [alert show];
                      } else {
                          [SVProgressHUD dismiss];
                          [self.uploadImageButton setEnabled:NO];
                          NSDictionary *dict = (NSDictionary *)responseObject;
                          NSArray *imageURLList = [dict objectForKey:@"data"];
                          weakSelf.imageArray = imageURLList;
                      }
                  }];
    
    [uploadTask resume];
    
    [SVProgressHUD show];
}


- (void)showDatePicker
{
    HSDatePickerViewController *hsdpvc = [[HSDatePickerViewController alloc] init];
    [hsdpvc setDelegate:self];
    [self presentViewController:hsdpvc animated:YES completion:nil];
}

- (void)hsDatePickerPickedDate:(NSDate *)date
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    self.timeTextField.text = currentDateStr;
    self.selectDate = date;
}

- (void)submitButtonDidClick
{
    NSString *title = self.titleTextField.text;
    NSString *author = [[NSUserDefaults standardUserDefaults]objectForKey:kUser_Name];
    NSArray *imageUrlArray = self.imageArray;
    NSTimeInterval timeInterval = [self.selectDate timeIntervalSince1970];
    
    if ([NSString isEmptyString:title]|| timeInterval == 0 || imageUrlArray.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"您的信息没有填写完整哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    
    NSDictionary *dict = @{@"title":title,@"time":@(timeInterval),@"img":imageUrlArray,@"user":author};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [SVProgressHUD show];
    [manager POST:@"http://hack2016.applinzi.com/index.php/Home/Index/fabu" parameters:dict progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        // 成功;
        [self.navigationController popViewControllerAnimated:NO];
        [SVProgressHUD showSuccessWithStatus:@"添加成功"];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kShouldRefreshData object:nil];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [SVProgressHUD dismiss];
    }];

    
}

@end
