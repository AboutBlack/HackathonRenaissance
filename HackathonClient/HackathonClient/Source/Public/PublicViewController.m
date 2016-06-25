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

@interface PublicViewController ()<UITextFieldDelegate,TZImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UIButton *uploadImageButton;
- (IBAction)uploadImageButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButtonClick;

@property (strong,nonatomic) NSArray *imageArray;

@end

@implementation PublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发布商品";
}

- (void)awakeFromNib
{
    [self.titleTextField setDelegate:self];
    [self.authorTextField setDelegate:self];
    [self.timeTextField setDelegate:self];
    NSString *author = [[NSUserDefaults standardUserDefaults]objectForKey:kUser_Name];
    self.authorTextField.text = author;
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
    } else if (textField == self.titleTextField) {
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
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          NSLog(@"Error: %@", error);
                      } else {
                          NSLog(@"%@ %@", response, responseObject);
                          [self.uploadImageButton setEnabled:NO];
                      }
                  }];
    
    [uploadTask resume];
    
    
}
@end
