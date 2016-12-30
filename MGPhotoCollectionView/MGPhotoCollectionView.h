//
//  MGPhotoCollectionView.h
//  MGPhotoCollectionView
//
//  Created by 高得华 on 16/10/31.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGPhotoModel.h"

/**开始删除ImageView*/
static NSString * const MGPhotoEditIsDeleteImgView = @"MGPhotoEditIsDeleteImgView";
/**结束删除ImageView*/
static NSString * const MGPhotoEndEditIsDeleteImgView = @"MGPhotoEndEditIsDeleteImgView";


@class MGPhotoCollectionView;
#pragma mark ====== MGPhotoCollectionViewDelegate ===
@protocol MGPhotoCollectionViewDelegate <NSObject>

//必须实现的方法
//========= 1. 添加图片
-(void)collectionView:(MGPhotoCollectionView *)collectionView addPhotoArray:(NSMutableArray <MGPhotoModel *> *)photoArray;
//========= 2.点击图片
-(void)collectionView:(MGPhotoCollectionView *)collectionView clickIndex:(NSInteger)index photoArray:(NSMutableArray<MGPhotoModel *> *)photoArray;

@optional//非必需实现的方法
//==========3.是否处于删除状态
-(void)collectionView:(MGPhotoCollectionView *)collectionView isDeleteState:(BOOL)state photoArray:(NSMutableArray<MGPhotoModel *> *)photoArray;

/**
 点击删除按钮时 返回数据源及下一个按钮

 @param collectionView MGPhotoCollectionView对象
 @param photoArray 数据源数组
 @param nextIndex 下一个数组
 */
-(void)collectionView:(MGPhotoCollectionView *)collectionView photoArray:(NSMutableArray <MGPhotoModel *>*)photoArray nextIndex:(NSInteger)nextIndex;

/**!
 * 处于最多照片个数状态下 剩下的就交给各位处理啦 一般是给个提示
 */
- (void)MaxPhotoNumberState;

@end

@interface MGPhotoCollectionView : UIView

/**!
 * 创建CollectionView   1.lineCounts:每一行显示多少列 2.frame,可以不指定大小，但是要确定位置
 */
-(instancetype)initWithFrame:(CGRect)frame
              withLineCounts:(NSInteger)lineCounts;

/**!
 * 每一行需要显示几列
 */
@property (nonatomic, assign) NSInteger lineCounts;

/**!
 * 数据源数组 数据类型为：MGPhotoModel
 */
@property (nonatomic, strong) NSArray <MGPhotoModel *> * dataArray;

/**!
 *MGPhotoCollectionViewDelegate 代理
 */
@property (nonatomic, assign) id <MGPhotoCollectionViewDelegate> delegate;

/**!
 * block 返回点击的是第几个 及数据源数组
 */
@property (nonatomic, copy) void(^ReturnClickIndexAndArray)(NSInteger index, NSArray <MGPhotoModel *> * photoArray, MGPhotoCollectionView * collectionView);
/**!
 *block 点击的是添加照片的按钮
 */
@property (nonatomic, copy) void(^ReturnClickAddPhoto)(NSMutableArray <MGPhotoModel *> * photoArray, MGPhotoCollectionView * collectionView);

/**!
 *block 处于编辑状态
 */
@property (nonatomic, copy) void(^ReturnClickIsDeleteState)(BOOL state, MGPhotoCollectionView * collectionView, NSMutableArray<MGPhotoModel *> *photoArray);

/**
 点击删除按钮时 返回下一个的数据及数据源
 */
@property (nonatomic, copy) void(^ReturnClickDeletePhoto)(MGPhotoCollectionView * collectionView, NSMutableArray<MGPhotoModel *> *photoArray, NSInteger nextIndex);

/**!
 * 获取视图的高度
 */
-(CGFloat)ReturnViewHeight;

/**!
 * 是否需要删除按钮，默认需要删除
 */
@property (nonatomic, assign) BOOL isDelete;

/**!
 *是否需要添加按钮 默认需要添加按钮
 */
@property (nonatomic, assign) BOOL isAddClickBtn;

/**!
 * 最多照片的个数 默认是12个
 */
@property (nonatomic, assign) NSInteger maxPhotoNumber;

/**!
 * 处于最多照片个数状态下 剩下的就交给各位处理啦 一般是给个提示
 */
@property (nonatomic, copy) void(^MaxPhotoNumberStateBlock)();

@end
