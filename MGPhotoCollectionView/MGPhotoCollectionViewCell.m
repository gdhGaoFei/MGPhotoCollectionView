//
//  MGPhotoCollectionViewCell.m
//  MGPhotoCollectionView
//
//  Created by 高得华 on 16/10/31.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import "MGPhotoCollectionViewCell.h"

@implementation MGPhotoCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    self.iv.userInteractionEnabled = YES;
    //self.iv.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.iv];
    
    
    self.isDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.isDeleteBtn.frame = CGRectMake(self.contentView.frame.size.width-18, 0, 18, 18);
    [self.contentView addSubview:self.isDeleteBtn];
    [self.isDeleteBtn setBackgroundImage:[UIImage imageNamed:@"gfdelete_error"] forState:UIControlStateNormal];
    self.isDeleteBtn.hidden = YES;
    [self.isDeleteBtn addTarget:self action:@selector(isDeleteBtnAct) forControlEvents:UIControlEventTouchUpInside];
}

-(void)isDeleteBtnAct{
    if (self.ReturnIsDeleteBtnClick) {
        self.ReturnIsDeleteBtnClick(self.isDeleteBtn.tag);
    }
}

@end
