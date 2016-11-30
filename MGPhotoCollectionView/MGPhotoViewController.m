//
//  MGPhotoViewController.m
//  MGPhotoCollectionViewDemo
//
//  Created by 高得华 on 16/11/30.
//  Copyright © 2016年 GaoFei. All rights reserved.
//

#import "MGPhotoViewController.h"
#import "UIImageView+WebCache.h"

@interface MGPhotoViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;//照片容器
@property (nonatomic, assign) NSInteger index;//图片的偏移量

@end

@implementation MGPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadCreateViewLayout];
}

/**!
 * 设置页面布局
 */
- (void)loadCreateViewLayout {
    NSInteger count = self.dataArray.count;
    if (count <= 0) {
        return;
    }
    
    CGRect frame = self.view.frame;
    CGFloat width  = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    
    self.scrollView.contentSize = CGSizeMake(count * width, height);
    
    //创建view
    for (NSInteger i = 0; i < count; i++) {
        //创建UIImageView
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //设置图片
        MGPhotoModel * model = self.dataArray[i];
        if (model.image != nil) {
            imageView.image = model.image;
        }else{
            if (model.icon.length <= 0) {
                imageView.backgroundColor = [UIColor redColor];
            }
            if([model.icon rangeOfString:@"http"].location != NSNotFound){
                [imageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"gf_loading"]];
            }else{
                imageView.image = [UIImage imageNamed:model.icon];
            }
        }
        
        //设置响应事件
        imageView.userInteractionEnabled = YES;
        
        //添加手势 ---点击消失
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAct:)];
        [imageView addGestureRecognizer:tap];
        [self.scrollView addSubview:imageView];
    }
    
    //设置_scrollView的偏移
    [self.scrollView scrollRectToVisible:CGRectMake(self.clickIndex * width, 0, width, height) animated:YES];
}

//点击图片的响应事件
-(void)tapAct:(UITapGestureRecognizer *)tap{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ======= UIScrollViewDelegate ======
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.index = scrollView.contentOffset.x/CGRectGetWidth(self.view.frame);
}

#pragma mark ======== 懒加载 =======
-(UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
        //_scrollView的属性
        _scrollView.pagingEnabled = YES;
        //开始时隐藏
//        _scrollView.hidden = YES;
        //设置代理
        _scrollView.delegate = self;
        //添加_scrollView
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma mark ======= 重写Setter方法 ========
-(void)setDataArray:(NSArray<MGPhotoModel *> *)dataArray {
    _dataArray = dataArray;
}
-(void)setClickIndex:(NSInteger)clickIndex {
    _clickIndex = clickIndex;
}


@end
