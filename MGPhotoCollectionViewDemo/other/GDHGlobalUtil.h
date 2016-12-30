//
//  GDHGlobalUtil.h
//  MGPhotoCollectionViewDemo
//
//  Created by 高得华 on 16/11/30.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**返回照片Block*/
typedef void(^ReturnImageBlock)(UIImage * image);

@interface GDHGlobalUtil : NSObject


/**
 单例创建GDHGlobalUtil对象

 @return GDHGlobalUtil对象
 */
+ (GDHGlobalUtil *)ShareGDHGlobalUtil;


/**!
 *调用相机
 */
- (void)TransferCameraWithViewController:(UIViewController *)viewController
                              ImageBlock:(ReturnImageBlock)returnImageBlock;
@property (nonatomic, copy) ReturnImageBlock returnImageBlock;


@end
