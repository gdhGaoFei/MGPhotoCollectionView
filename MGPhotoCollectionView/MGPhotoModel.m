//
//  MGPhotoModel.m
//  MGPhotoCollectionView
//
//  Created by 高得华 on 16/10/31.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import "MGPhotoModel.h"

@implementation MGPhotoModel

/**!
 * 创建Model 1.需要icon 图片名称 2.图片类型 3.UIImage 4.是否删除 5.isModelType YES 则为添加照片按钮
 */
+(instancetype)CreateModelWithIcon:(NSString *)icon
                          withType:(NSInteger)type
                         withImage:(UIImage *)image
                      withIsDelete:(BOOL)isDelete
                   withIsModelType:(BOOL)isModelType{
    
    MGPhotoModel * photo = [[MGPhotoModel alloc] init];
    
    photo.icon  = icon;
    photo.type  = type;
    photo.image = image;
    photo.isDelete = isDelete;
    photo.isModelType = isModelType;
    
    return photo;
}

@end
