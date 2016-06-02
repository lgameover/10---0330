//
//  PosterCell.h
//  PRODUCT
//
//  Created by BEVER on 16/3/24.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "PosterBackView.h"

@interface PosterCell : UICollectionViewCell

@property (nonatomic,strong)UIImageView *frontImgView;

@property (nonatomic,strong)PosterBackView *backView;

@property (nonatomic,strong)HomeModel *model;

- (void)flip;//点击单元格翻转的方法

- (void)flipToFront;//翻转到正面

- (void)flipToBack;//翻转到反面
@end
