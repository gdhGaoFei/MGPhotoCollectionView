# MGPhotoCollectionView
A MGPhotoCollectionView view on iOS.

这是一个仿照QQ空间里面的上传照片样式，所封装的一个选择相册demo，并且进行了部分扩展点击能够放大查看大图。
1. 可以根据自己需求进行创建几列
2. 使用 通知代理(delegate) 或者 block 进行删除、点击查看 (具体方法请查看demo)

# 安装方法:
# 1. 从 github网址：
#               https://github.com/gdhGaoFei/MGPhotoCollectionView.git 
#               进行下载

# 2. 使用cocoaPods 进行管理 pod 'MGPhotoCollectionView'  使用方法如下: 
platform :ios, '7.0'<br/>
target :'自己项目名称' do<br/> (自己项目名称指的是: TARGETS)
pod 'MGPhotoCollectionView'<br/>
end<br/>

$ 之后  pod install<br/> 的即可

#将要 #import "MGPhotoCollectionView.h"、
#    #import "MGPhotoViewController.h"(不需要点击放大，可以不导入此头文件)，导入即可。       



建议及意见 请联系-> QQ: 964195787  邮箱:gdhgaofei@163.com 谢谢!



# 使用方法: 支持两种方式创建 1.纯代码手写 2.使用Storyboard/xib进行创建。 使用demo在 https://github.com/gdhGaoFei/MGPhotoCollectionView.git 已列出，欢迎查看使用。


# 1. 使用 block 方法 

# 点击其他方面的按钮
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

# 点击添加照片按钮
self.collectionView.ReturnClickAddPhoto = ^(NSMutableArray <MGPhotoModel *> * photoArray, MGPhotoCollectionView * collectionView){
[self loadCreateAddPhotoArray:photoArray];
};

# 点击删除按钮时 block返回
self.collectionView.ReturnClickDeletePhoto = ^(MGPhotoCollectionView * collectionView, NSMutableArray<MGPhotoModel *> *photoArray, NSInteger nextIndex){
if (photoArray.count > 0) {

}else{

}
};


# 2. 使用通知代理 
// =========== MGPhotoCollectionViewDelegate ========
# ========= 1. 添加图片
-(void)collectionView:(MGPhotoCollectionView *)collectionView addPhotoArray:(NSMutableArray <MGPhotoModel *> *)photoArray {
[self.daimaCurrentPhotoArray removeAllObjects];
[self.daimaCurrentPhotoArray addObjectsFromArray:photoArray];
[[GDHGlobalUtil ShareGDHGlobalUtil] TransferCameraWithViewController:self ImageBlock:^(UIImage *image) {
MGPhotoModel * photo = [MGPhotoModel CreateModelWithIcon:@"" withType:2 withImage:image withIsDelete:NO withIsModelType:NO];
[self.daimaCurrentPhotoArray addObject:photo];
self.daimaCollectionView.dataArray = self.daimaCurrentPhotoArray;
}];
}

# ========= 2.点击图片
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

# ==========3.是否处于删除状态
-(void)collectionView:(MGPhotoCollectionView *)collectionView isDeleteState:(BOOL)state photoArray:(NSMutableArray<MGPhotoModel *> *)photoArray {

}

# ========= 4. 点击删除按钮时 返回数据源及下一个按钮
/**
点击删除按钮时 返回数据源及下一个按钮

@param collectionView MGPhotoCollectionView对象
@param photoArray 数据源数组
@param nextIndex 下一个数组
*/
-(void)collectionView:(MGPhotoCollectionView *)collectionView photoArray:(NSMutableArray <MGPhotoModel *>*)photoArray nextIndex:(NSInteger)nextIndex {

}












