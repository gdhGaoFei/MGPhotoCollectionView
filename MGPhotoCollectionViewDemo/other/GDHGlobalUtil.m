//
//  GDHGlobalUtil.m
//  MGPhotoCollectionViewDemo
//
//  Created by 高得华 on 16/11/30.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import "GDHGlobalUtil.h"
#import "CTActionSheet.h"

@interface GDHGlobalUtil ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation GDHGlobalUtil


/**
 单例创建GDHGlobalUtil对象
 
 @return GDHGlobalUtil对象
 */
+ (GDHGlobalUtil *)ShareGDHGlobalUtil {
    static GDHGlobalUtil * hander = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hander = [[GDHGlobalUtil alloc] init];
    });
    
    return hander;
}
-(instancetype)init {
    if ([super init]) {
        
    }
    return self;
}

/**!
 *调用相机
 */
- (void)TransferCameraWithViewController:(UIViewController *)viewController
                              ImageBlock:(ReturnImageBlock)returnImageBlock {
    self.returnImageBlock = returnImageBlock;
    
    //初始化相机
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    pickerController.editing = YES;
    
    [CTActionSheet ShowActionSheetWithTitle:@"上传照片"
                          cancelButtonTitle:@"取消"
                               ButtonTitles:@[@"拍照上传",@"从相册中选取"]
                                HandleBlock:^(CTActionSheet *actionSheet, int btnIndex) {
                                    if (btnIndex == 1) {//拍照
                                        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                                            [viewController presentViewController:pickerController animated:YES completion:nil];
                                        }
                                    } else if (btnIndex == 2) {//从相册获取
                                        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                                            pickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                                        }
                                        [viewController presentViewController:pickerController animated:YES completion:nil];
                                    } else {
                                        NSLog(@"//------Bug------\\");
                                    }
                                }];

}

//拿到照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    if (!originalImage) {
        originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    }
    if (self.returnImageBlock) {
        NSData *imageData = UIImageJPEGRepresentation(originalImage, 1);
        if  (imageData.length>300000){
            UIImage *image = [UIImage imageWithData:imageData];
            imageData = UIImageJPEGRepresentation(image, 0.005);
        }
        self.returnImageBlock([UIImage imageWithData:imageData]);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
