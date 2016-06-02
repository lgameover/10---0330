//
//  BaseCollectionView.m
//  PRODUCT
//
//  Created by BEVER on 16/3/25.
//  Copyright © 2016年 李楠. All rights reserved.
//



#import "BaseCollectionView.h"

#define kItemWidth (self.frame.size.width-120)

@interface BaseCollectionView ()
//{
//    float _itemWidth;//cell宽度
//}

@end

@implementation BaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame itemWidth:(float)itemWidth{
    
    _itemWidth = itemWidth;
    
    //1.创建布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置水平滑动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //去掉最小间距,让item间没有空隙,更改cell的transformScale做出仿空隙效果
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    
    //保存cell宽度
    //    _itemWidth = frame.size.width-120;
    
    //设置cell尺寸
    layout.itemSize  = CGSizeMake(_itemWidth, frame.size.height);
    
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.delegate = self;
        
        self.dataSource = self;
        
        //关闭水平滚动条
        self.showsHorizontalScrollIndicator = NO;
        
     
    }
    return self;
    
}

#pragma mark --UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _datalist.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    
    
    return nil;
    
}

//改变内容视图偏移边界
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, (self.bounds.size.width-_itemWidth)/2, 0, (self.bounds.size.width-_itemWidth)/2);
}

#pragma mark --UIScrollViewDelegate

//将要停止拖动时调用
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    //1.获取X轴偏移量
    CGFloat offsetX = targetContentOffset->x;
    
    //2.根据偏移量计算index
    NSInteger index = (offsetX + _itemWidth/2)/_itemWidth;
    
    //    NSLog(@"%ld",index);
    
    //3.根据index重新设置偏移量 : 保证item在屏幕中间
    targetContentOffset->x = index * (_itemWidth + 0);
    
    //4.记录当前显示的下标
    self.currentIndex = index;
    
}



@end




//#import "BaseCollectionView.h"
//
//#define kItemWidth (self.frame.size.width-120)
//
//@interface BaseCollectionView ()
////
////{
////    float _itemWidth;
////}
//
//@end
//
//@implementation BaseCollectionView
//
//-(instancetype)initWithFrame:(CGRect)frame itemWideth:(float)itemWidth{
//    
//    _itemWidth = itemWidth;
//    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    
//    layout.minimumInteritemSpacing = 0.0;
//    layout.minimumLineSpacing = 0.0;
//        
//    layout.itemSize = CGSizeMake(_itemWidth, frame.size.height);
//    
//    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
//        self.delegate = self;
//        self.dataSource = self;
//        
//        
//        self.showsHorizontalScrollIndicator = NO;
//
//        
//    }
//    return self;
//}
//
//
//
//
//#pragma mark --UICollectionViewDataSource
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//    return _datalist.count;
//}
//
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return nil;
//    
//}
//
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    
//    return UIEdgeInsetsMake(0, (self.bounds.size.width-_itemWidth)/2, 0, (self.bounds.size.width-_itemWidth)/2);
//    
//}
//
//#pragma mark --UIScrollViewDelegate
//
////将要停止拖动时调用
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    
//    //1.获取X轴偏移量
//    CGFloat offsetX = targetContentOffset->x;
//    
//    //2.根据偏移量计算index
//    NSInteger index = (offsetX + _itemWidth/2)/_itemWidth;
//    
//    //    NSLog(@"%ld",index);
//    
//    //3.根据index重新设置偏移量 : 保证item在屏幕中间
//    targetContentOffset->x = index * (_itemWidth + 0);
//    
//    self.currentIndex = index;
//}
//
//
//@end
