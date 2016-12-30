//
//  MGPhotoCollectionView.m
//  MGPhotoCollectionView
//
//  Created by 高得华 on 16/10/31.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import "MGPhotoCollectionView.h"
#import "MGPhotoCollectionViewCell.h"
#import "UIImageView+WebCache.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define kCellPath 10

@interface MGPhotoCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UICollectionView * collectionView;
/**!
 *数据数组
 */
@property (nonatomic, strong) NSMutableArray <MGPhotoModel *> * photoDataArray;

/**!
 * 是否处于删除状态 Yes:删除状态 No:不是删除状态
 */
@property (nonatomic, assign) BOOL isDeleteState;

/**!
 * UITapGestureRecognizer * tapGes 轻击手势
 */
@property (nonatomic, strong) UITapGestureRecognizer * tapGes;

@end

@implementation MGPhotoCollectionView

/**!
 * 创建CollectionView   1.lineCounts:每一行显示多少列 2.frame,可以不指定大小，但是要确定位置
 */
-(instancetype)initWithFrame:(CGRect)frame
              withLineCounts:(NSInteger)lineCounts{
    self = [super initWithFrame:frame];
    if(self){
        self.lineCounts = lineCounts;
        [self loadCreateViewLayout];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self loadCreateViewLayout];
}
-(void)setLineCounts:(NSInteger)lineCounts{
    _lineCounts = lineCounts;
    [self loadCreateCollectionViewHeight];
}
-(void)setDataArray:(NSArray <MGPhotoModel *> *)dataArray{
    _dataArray = dataArray;
    [self.photoDataArray removeAllObjects];
    NSMutableArray <MGPhotoModel *> * array = [NSMutableArray array];
    if (self.isAddClickBtn && dataArray.count < self.maxPhotoNumber) {
        MGPhotoModel * firstModel = [MGPhotoModel CreateModelWithIcon:@"" withType:1 withImage:[UIImage imageNamed:@"addimageshadow"] withIsDelete:NO withIsModelType:YES withUrl:@""];
        [array addObject:firstModel];
    }else{//处于最大容量状态下
        if (self.MaxPhotoNumberStateBlock) {
            self.MaxPhotoNumberStateBlock();
        }
        if ([self.delegate respondsToSelector:@selector(MaxPhotoNumberState)]) {
            [self.delegate MaxPhotoNumberState];
        }
    }
    for (NSInteger i = (dataArray.count-1); i >= 0; i--) {
        MGPhotoModel * model = [self returnSelectModel:dataArray[i]];
        model.isDelete = self.isDeleteState;
        [array insertObject:model atIndex:0];
    }
    [self.photoDataArray addObjectsFromArray:array];
    [self loadCreateCollectionViewHeight];
}
- (void)setMaxPhotoNumber:(NSInteger)maxPhotoNumber {
    _maxPhotoNumber = maxPhotoNumber;
}
-(void)setIsDelete:(BOOL)isDelete{
    _isDelete = isDelete;
    if (isDelete) {
        UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAct:)];
        longPressGesture.minimumPressDuration = 0.8f;
        longPressGesture.delegate = self;
        [self addGestureRecognizer:longPressGesture];
    }
}
-(void)setIsAddClickBtn:(BOOL)isAddClickBtn{
    _isAddClickBtn = isAddClickBtn;
}


/**!
 *设置CollectionView的高度
 */
-(void)loadCreateCollectionViewHeight{
    
    NSInteger count = self.photoDataArray.count / self.lineCounts;
    
    if (self.photoDataArray.count % self.lineCounts != 0) {
        count += 1;
    }
    CGFloat height = ((WIDTH-kCellPath*(self.lineCounts+1))/self.lineCounts)*count+(count+1)*kCellPath;
    CGRect oldFrame = self.frame;
    oldFrame.size.height = height;
    self.frame = oldFrame;
    
    CGRect cvOldFrame = self.collectionView.frame;
    cvOldFrame.size.height = height;
    self.collectionView.frame = cvOldFrame;
    
    [self.collectionView reloadData];
}
/**!
 * 获取视图的高度
 */
-(CGFloat)ReturnViewHeight{
    return self.collectionView.frame.size.height;
}

/**!
 *设置页面的布局
 */
-(void)loadCreateViewLayout {
    
    //初始化
    self.isDeleteState = NO;
    self.isDelete      = YES;
    self.isAddClickBtn = YES;
    self.maxPhotoNumber = 12;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editIsDeleteImageView) name:MGPhotoEditIsDeleteImgView object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditIsDeleteImageView) name:MGPhotoEndEditIsDeleteImgView object:nil];
}

-(NSMutableArray<MGPhotoModel *> *)photoDataArray{
    if (_photoDataArray == nil) {
        MGPhotoModel * photoModel = [MGPhotoModel CreateModelWithIcon:@"" withType:1 withImage:[UIImage imageNamed:@"addimageshadow"] withIsDelete:NO withIsModelType:YES withUrl:@""];
        _photoDataArray = [NSMutableArray arrayWithObject:photoModel];
    }
    return _photoDataArray;
}


#pragma mark ==============  UICollectionViewDataSource =============
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoDataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MGPhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MGPhotoCollectionViewCell" forIndexPath:indexPath];
    
    MGPhotoModel * model = self.photoDataArray[indexPath.row];
    if (model.url.length > 0) {
        [cell.iv sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"loading"]];
    }else if (model.image != nil) {
        cell.iv.image = model.image;
    }else if (model.icon.length > 0){
        cell.iv.image = [UIImage imageNamed:model.icon];
    }else{
        cell.iv.backgroundColor = [UIColor redColor];
    }
    
    cell.isDeleteBtn.tag = indexPath.row+100;
    
    if (model.isDelete) {
        cell.isDeleteBtn.hidden = NO;
        cell.ReturnIsDeleteBtnClick = ^(NSInteger index){
            index = index-100;
            NSLog(@"====isDelete===%ld==",(long)(index));
            [self.photoDataArray removeObjectAtIndex:index];
            [self loadCreateCollectionViewHeight];
            [self.collectionView reloadData];
            
            NSMutableArray <MGPhotoModel *>* array = [NSMutableArray array];
            for (MGPhotoModel * model in self.photoDataArray) {
                if (!model.isModelType) {
                    model.isDelete = YES;
                    self.isDeleteState = YES;
                    [array addObject:[self returnSelectModel:model]];
                }
            }
            
            //结束删除
            if (array.count <= 0) {
                [self endEditIsDeleteImageView];
            }else{
                self.dataArray = array;
            }
            
            index = index ==  self.photoDataArray.count-1 ? index-1 : index;
            
            if (self.ReturnClickDeletePhoto) {
                self.ReturnClickDeletePhoto(self, array, index);
            }
            if ([self.delegate respondsToSelector:@selector(collectionView: photoArray:nextIndex:)]) {
                [self.delegate collectionView:self photoArray:array nextIndex:index];
            }
        };
    }else{
        cell.isDeleteBtn.hidden = YES;
    }
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (WIDTH-kCellPath*self.lineCounts)/self.lineCounts;
    return CGSizeMake(width, width);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //top left bottom right
    return UIEdgeInsetsMake(kCellPath, kCellPath, kCellPath, kCellPath);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray <MGPhotoModel *>* array = [NSMutableArray array];
    for (MGPhotoModel * photo in self.photoDataArray) {
        if (photo.isModelType) {
            continue;
        }
        [array addObject:[self returnSelectModel:photo]];
    }
    
    if (self.isAddClickBtn) {
        if (indexPath.row == self.photoDataArray.count-1) {//添加照片
            self.isDeleteState = NO;
            if (self.ReturnClickAddPhoto) {
                self.ReturnClickAddPhoto(array, self);
            }
            if (self.delegate) {
                [self.delegate collectionView:self addPhotoArray:array];
            }
            return;
        }
    }
    
    if (!self.isDeleteState) {
        if (self.ReturnClickIndexAndArray) {
            self.ReturnClickIndexAndArray(indexPath.row, array, self);
        }
        if (self.delegate) {
            [self.delegate collectionView:self clickIndex:indexPath.row photoArray:array];
        }
    }
}

-(MGPhotoModel *)returnSelectModel:(MGPhotoModel *)model{
    MGPhotoModel * photo = [MGPhotoModel CreateModelWithIcon:model.icon withType:model.type withImage:model.image withIsDelete:model.isDelete withIsModelType:model.isModelType withUrl:model.url];
    
    return photo;
}

//====== 开始删除 ImageView ====
-(void)editIsDeleteImageView{
    NSMutableArray <MGPhotoModel *>* array = [NSMutableArray array];
    
    for (MGPhotoModel * model in self.photoDataArray) {
        if (!model.isModelType) {
            model.isDelete = YES;
            self.isDeleteState = YES;
            [array addObject:[self returnSelectModel:model]];
        }
    }
    
    if (self.ReturnClickIsDeleteState) {//处于删除状态
        self.ReturnClickIsDeleteState(YES, self, array);
    }
    
    if ([self.delegate respondsToSelector:@selector(collectionView:isDeleteState: photoArray:)]) {
        [self.delegate collectionView:self isDeleteState:YES photoArray:array];
    }
    
    [self loadCreateTapGes];
    [self.collectionView reloadData];
}
//====== 结束删除 ImageView ======
-(void)endEditIsDeleteImageView{
    NSMutableArray <MGPhotoModel *>* array = [NSMutableArray array];

    for (MGPhotoModel * model in self.photoDataArray) {
        if (!model.isModelType) {
            model.isDelete = NO;
            self.isDeleteState = NO;
            [array addObject:[self returnSelectModel:model]];
        }
    }
    
    //block 返回是否删除状态
    if (self.ReturnClickIsDeleteState) {//处于非删除状态
        self.ReturnClickIsDeleteState(NO, self, array);
    }
    //delegate 返回是否删除状态
    if ([self.delegate respondsToSelector:@selector(collectionView:isDeleteState: photoArray:)]) {
        [self.delegate collectionView:self isDeleteState:NO photoArray:array];
    }
        
    [self loadCreateTapGes];
    [self.collectionView reloadData];
}

/**在处于删除状态下 在创建轻击手势**/
-(void)loadCreateTapGes{
    if (self.isDeleteState) {
        if (self.tapGes == nil) {
            self.tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAct:)];
            self.tapGes.numberOfTapsRequired = 1;
            self.tapGes.numberOfTouchesRequired = 1;
            self.tapGes.delegate = self;
            [self addGestureRecognizer:self.tapGes];
        }
    }else{
        [self removeGestureRecognizer:self.tapGes];
        self.tapGes = nil;
    }
}


//长按手势
-(void)longPressGestureAct:(UILongPressGestureRecognizer *)longPress{
    NSIndexPath * indexPath;
    if (longPress.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [longPress locationInView:self];
        indexPath = [self.collectionView indexPathForItemAtPoint:point];
        if (indexPath != nil) {
            MGPhotoModel * model = self.photoDataArray[indexPath.row];
            if (!model.isDelete) {
                //开始编辑
                [self editIsDeleteImageView];
            }
        }else{
            //完成编辑
            [self endEditIsDeleteImageView];
        }
    }
}
//轻击手势
-(void)tapGestureAct:(UITapGestureRecognizer *)sender{
    if (sender.numberOfTapsRequired == 1) {
        NSIndexPath * indexPath;
        CGPoint point = [sender locationInView:self];
        indexPath = [self.collectionView indexPathForItemAtPoint:point];
        if (indexPath == nil) {
            //完成编辑
            [self endEditIsDeleteImageView];
            return;
        }
    }
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //    NSLog(@"====[touch.view class]=====%@===",[touch.view class]);
    
    //点击事件
    if ([[gestureRecognizer class] isSubclassOfClass:[UITapGestureRecognizer class]]) {
        if ([NSStringFromClass([touch.view class]) isEqualToString:@"UICollectionView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
            return YES;//开启手势
        }else if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIImageView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
            return NO;//关闭手势
        }else{
            return YES;
        }
    }else if ([[gestureRecognizer class] isSubclassOfClass:[UILongPressGestureRecognizer class]]){
        if ([NSStringFromClass([touch.view class]) isEqualToString:@"UICollectionView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
            return NO;//关闭手势
        }else if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIImageView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
            return YES;//开启手势
        }else{
            return NO;
        }
    }
    
    return NO;
}


#pragma mark ===============// 懒加载 \\================
-(UICollectionViewFlowLayout *)CreateFlowLayout{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = kCellPath;
    layout.minimumInteritemSpacing = 0.0f;
    return layout;
}
-(UICollectionView *)collectionView{
    
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, (WIDTH-kCellPath*self.lineCounts)/self.lineCounts) collectionViewLayout:[self CreateFlowLayout]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        //注册单元格
        [_collectionView registerClass:[MGPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"MGPhotoCollectionViewCell"];
        [self addSubview:_collectionView];
//        _collectionView.backgroundColor = [UIColor colorWithRed:200/255.f green:200/255.f blue:200/255.f alpha:1.0f];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end
