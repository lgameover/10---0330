//
//  PosterCollectionView.m
//  PRODUCT
//
//  Created by BEVER on 16/3/24.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "PosterCollectionView.h"
#import "HomeModel.h"
#import "PosterCell.h"

@implementation PosterCollectionView

- (instancetype)initWithFrame:(CGRect)frame itemWidth:(float)itemWidth{
    
    if ([super initWithFrame:frame itemWidth:itemWidth]) {
        
        //注册单元格
        [self registerClass:[PosterCell class] forCellWithReuseIdentifier:@"poster_cell"];
    }
    return self;
    
}

#pragma mark --UICollectionViewDataSource

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//
//    return _datalist.count;
//}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PosterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"poster_cell" forIndexPath:indexPath];
    
    //x y 方向缩小比例为原来的0.95倍
    cell.transform = CGAffineTransformMakeScale(0.95, 0.95);
        
    HomeModel *model = self.datalist[indexPath.row];
    
    //    for (UIView *subView in cell.subviews) {
    //
    //        if ([subView isMemberOfClass:[UIImageView class]]) {
    //
    //            [subView removeFromSuperview];
    //        }
    //    }
    //
    //    UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.bounds];
    //
    //    [imageView setImageWithURL:[NSURL URLWithString:model.img]];
    //
    //    [cell addSubview:imageView];
    
    //将数据model传递给cell
    cell.model = model;
    
    return cell;
    
}

#pragma mark --UIScrollViewDelegate

//点击单元格时调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //判断当前点击的cell是否是显示在中间的cell 1.如果是->翻转 2.如果不是->滑动到cell
    
    //根据indexPath获取cell
    PosterCell *cell = (PosterCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (indexPath.row == self.currentIndex) {
        
        //调用cell的翻转方法
        [cell flip];
        
    }else{
        
        /**
         *
         UICollectionViewScrollPositionNone                 = 0,
         UICollectionViewScrollPositionTop                  = 1 << 0,
         UICollectionViewScrollPositionCenteredVertically   = 1 << 1,
         UICollectionViewScrollPositionBottom               = 1 << 2,
         UICollectionViewScrollPositionLeft                 = 1 << 3,
         UICollectionViewScrollPositionCenteredHorizontally = 1 << 4,
         UICollectionViewScrollPositionRight
         */
        
        //集合视图将某个单元格滑动到指定位置
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        //更新本次的index 以便于下一次比较
        self.currentIndex = indexPath.row;
        
    }
    
}

//cell已经结束显示时调用
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PosterCell *cell1 = (PosterCell *)cell;
    
    [cell1 flipToFront];
    
}


@end
