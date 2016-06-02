//
//  BaseCollectionView.h
//  PRODUCT
//
//  Created by BEVER on 16/3/25.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)NSMutableArray *datalist;

@property (nonatomic,assign)NSInteger currentIndex;//当前显示的cell下标

@property (nonatomic,assign,readonly)float itemWidth;//cell的宽度

- (instancetype)initWithFrame:(CGRect)frame itemWidth:(float)itemWidth;

@end
