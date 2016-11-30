//
//  MGPhotoModel.h
//  MGPhotoCollectionView
//
//  Created by 高得华 on 16/10/31.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MGPhotoModel : NSObject

/**!
 * 创建Model 1.需要icon 图片名称 2.图片类型 3.UIImage 4.是否删除 5.isModelType YES 则为添加照片按钮
 */
+(instancetype)CreateModelWithIcon:(NSString *)icon
                          withType:(NSInteger)type
                         withImage:(UIImage *)image
                      withIsDelete:(BOOL)isDelete
                   withIsModelType:(BOOL)isModelType;

@property (nonatomic, strong) UIImage * image;
@property (nonatomic, copy)   NSString * icon;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, assign) BOOL isModelType;

@end
