//
//  ViewController.m
//  MGPhotoCollectionViewDemo
//
//  Created by 高得华 on 16/11/30.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import "ViewController.h"
#import "MGPhotoCollectionView.h"
#import "GDHGlobalUtil.h"
#import "MGPhotoViewController.h"

@interface ViewController ()<MGPhotoCollectionViewDelegate>

@property (weak, nonatomic) IBOutlet MGPhotoCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewLayoutHeight;

/**当前照片容器的数据源数组**/
@property (nonatomic, strong) NSMutableArray <MGPhotoModel *>* currentPhotoArray;

@property (nonatomic, strong) MGPhotoCollectionView * daimaCollectionView;
@property (nonatomic, strong) NSMutableArray <MGPhotoModel *>* daimaCurrentPhotoArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.daimaCollectionView];
    
    //设置照片容器
    self.collectionView.lineCounts = 5;
    self.collectionViewLayoutHeight.constant = [self.collectionView ReturnViewHeight];
    //点击其他方面的按钮
    self.collectionView.ReturnClickIndexAndArray = ^(NSInteger index, NSArray <MGPhotoModel *> * photoArray, MGPhotoCollectionView * collectionView){
        if (photoArray.count > 0) {
            MGPhotoViewController * vc = [[MGPhotoViewController alloc] init];
            vc.dataArray = photoArray;
            vc.clickIndex = index;
            [self presentViewController:vc animated:YES completion:^{
                
            }];
        }else{
        }
    };
    //点击添加照片按钮
    self.collectionView.ReturnClickAddPhoto = ^(NSMutableArray <MGPhotoModel *> * photoArray, MGPhotoCollectionView * collectionView){
        [self loadCreateAddPhotoArray:photoArray];
    };
    //点击删除按钮时 block返回
    self.collectionView.ReturnClickDeletePhoto = ^(MGPhotoCollectionView * collectionView, NSMutableArray<MGPhotoModel *> *photoArray, NSInteger nextIndex){
        if (photoArray.count > 0) {
            
        }else{
            
        }
    };
}

/**!
 * 添加照片
 */
-(void)loadCreateAddPhotoArray:(NSArray <MGPhotoModel *> * )photoArray{
    
    [self.currentPhotoArray removeAllObjects];
    [self.currentPhotoArray addObjectsFromArray:photoArray];
    [[GDHGlobalUtil ShareGDHGlobalUtil] TransferCameraWithViewController:self ImageBlock:^(UIImage *image) {
        self.collectionViewLayoutHeight.constant = [self.collectionView ReturnViewHeight];
        MGPhotoModel * photo = [MGPhotoModel CreateModelWithIcon:@"" withType:2 withImage:image withIsDelete:NO withIsModelType:NO];
        [self.currentPhotoArray addObject:photo];
        self.collectionView.dataArray = self.currentPhotoArray;
        self.collectionViewLayoutHeight.constant = [self.collectionView ReturnViewHeight];
    }];
}

- (IBAction)delete:(id)sender {
    if (self.currentPhotoArray.count > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MGPhotoEditIsDeleteImgView object:nil];
    }
}
- (IBAction)finish:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:MGPhotoEndEditIsDeleteImgView object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// =========== MGPhotoCollectionViewDelegate ========
//========= 1. 添加图片
-(void)collectionView:(MGPhotoCollectionView *)collectionView addPhotoArray:(NSMutableArray <MGPhotoModel *> *)photoArray {
    [self.daimaCurrentPhotoArray removeAllObjects];
    [self.daimaCurrentPhotoArray addObjectsFromArray:photoArray];
    [[GDHGlobalUtil ShareGDHGlobalUtil] TransferCameraWithViewController:self ImageBlock:^(UIImage *image) {
        MGPhotoModel * photo = [MGPhotoModel CreateModelWithIcon:@"" withType:2 withImage:image withIsDelete:NO withIsModelType:NO];
        [self.daimaCurrentPhotoArray addObject:photo];
        self.daimaCollectionView.dataArray = self.daimaCurrentPhotoArray;
    }];
}
//========= 2.点击图片
-(void)collectionView:(MGPhotoCollectionView *)collectionView clickIndex:(NSInteger)index photoArray:(NSMutableArray<MGPhotoModel *> *)photoArray {
    if (photoArray.count > 0) {
        MGPhotoViewController * vc = [[MGPhotoViewController alloc] init];
        vc.dataArray = photoArray;
        vc.clickIndex = index;
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }else{
    }
}

//==========3.是否处于删除状态
-(void)collectionView:(MGPhotoCollectionView *)collectionView isDeleteState:(BOOL)state photoArray:(NSMutableArray<MGPhotoModel *> *)photoArray {
    
}

/**
 点击删除按钮时 返回数据源及下一个按钮
 
 @param collectionView MGPhotoCollectionView对象
 @param photoArray 数据源数组
 @param nextIndex 下一个数组
 */
-(void)collectionView:(MGPhotoCollectionView *)collectionView photoArray:(NSMutableArray <MGPhotoModel *>*)photoArray nextIndex:(NSInteger)nextIndex {
    
}

#pragma mark ====== // 懒加载 \\ ========
-(NSMutableArray<MGPhotoModel *> *)currentPhotoArray{
    if (_currentPhotoArray == nil) {
        _currentPhotoArray = [NSMutableArray array];
    }
    return _currentPhotoArray;
}
-(NSMutableArray<MGPhotoModel *> *)daimaCurrentPhotoArray {
    if (_daimaCurrentPhotoArray == nil) {
        _daimaCurrentPhotoArray = [NSMutableArray array];
    }
    return _daimaCurrentPhotoArray;
}

-(MGPhotoCollectionView *)daimaCollectionView {
    if (_daimaCollectionView == nil) {
        _daimaCollectionView = [[MGPhotoCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)/2, CGRectGetHeight(self.view.frame), 0) withLineCounts:6];
        [self.view addSubview:_daimaCollectionView];
        
        _daimaCollectionView.delegate = self;
    }
    return _daimaCollectionView;
}


@end
