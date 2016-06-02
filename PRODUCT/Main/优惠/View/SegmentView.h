//
//  SegmentView.h
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonSelectBlock)(NSInteger selectedIndex);

@interface SegmentView : UIView

@property (nonatomic,readonly,strong) NSArray *titles;

@property (nonatomic,strong)UIImage *selectedImage;

@property (nonatomic,assign)NSInteger selectedIndex;

@property (nonatomic,copy,readonly) ButtonSelectBlock selectBlock;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

/**
 *  点击分段控件按钮调用的方法
 */
-(void)segmentViewButtonClick:(ButtonSelectBlock)selectBlock;

@end
