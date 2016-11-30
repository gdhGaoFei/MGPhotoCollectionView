//
//  MGPhotoCollectionViewCell.h
//  MGPhotoCollectionView
//
//  Created by 高得华 on 16/10/31.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView * iv;
@property (nonatomic, strong) UIButton * isDeleteBtn;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic, copy) void(^ReturnIsDeleteBtnClick)(NSInteger index);

@end
