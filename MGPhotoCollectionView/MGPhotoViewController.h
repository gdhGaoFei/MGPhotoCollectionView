//
//  MGPhotoViewController.h
//  MGPhotoCollectionViewDemo
//
//  Created by 高得华 on 16/11/30.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGPhotoModel.h"

@interface MGPhotoViewController : UIViewController

/**!
 * 当前点击是第几张照片
 */
@property (nonatomic, assign) NSInteger clickIndex;

/**!
 * 数据源数组
 */
@property (nonatomic, strong) NSArray <MGPhotoModel *>* dataArray;

@end
