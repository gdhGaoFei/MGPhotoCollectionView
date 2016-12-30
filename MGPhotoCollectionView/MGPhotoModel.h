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

/**
 创建照片Model

 @param icon 图片名称
 @param type 图片编号
 @param image UIImage类型
 @param isDelete 是否为删除图片类型
 @param isModelType 是否为添加按钮 默认YES
 @param url 图片Url
 @return MGPhotoModel对象
 */
+(instancetype)CreateModelWithIcon:(NSString *)icon
                          withType:(NSInteger)type
                         withImage:(UIImage *)image
                      withIsDelete:(BOOL)isDelete
                   withIsModelType:(BOOL)isModelType
                           withUrl:(NSString *)url;


@property (nonatomic, strong) UIImage * image;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, assign) BOOL isModelType;
@property (nonatomic, copy)   NSString * url;
@property (nonatomic, copy)   NSString * icon;

@end
