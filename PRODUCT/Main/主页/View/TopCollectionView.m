//
//  TopCollectionView.m
//  PRODUCT
//
//  Created by BEVER on 16/3/25.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "TopCollectionView.h"
#import "HomeModel.h"

@implementation TopCollectionView

- (instancetype)initWithFrame:(CGRect)frame itemWidth:(float)itemWidth{
    
    if ([super initWithFrame:frame itemWidth:itemWidth]) {
        
        //注册单元格
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"top_cell"];
    }
    return self;
    
}


#pragma mark --UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"top_cell" forIndexPath:indexPath];
    
    //x y 方向缩小比例为原来的0.95倍
    cell.transform = CGAffineTransformMakeScale(0.95, 0.95);
    
    HomeModel *model = self.datalist[indexPath.row];
    
    for (UIView *subView in cell.subviews) {
        
        if ([subView isMemberOfClass:[UIImageView class]]) {
            
            [subView removeFromSuperview];
        }
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.bounds];
    
    [imageView setImageWithURL:[NSURL URLWithString:model.img]];
    
    [cell addSubview:imageView];
    
    return cell;
    
}

#pragma mark --UIScrollViewDelegate

//点击单元格时调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //集合视图将某个单元格滑动到指定位置
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    //更新本次的index 以便于下一次比较
    self.currentIndex = indexPath.row;
    
}


@end
