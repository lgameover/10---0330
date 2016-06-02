//
//  SegmentView.m
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "SegmentView.h"

#define kSelectedImgHeight 2
#define kNormalFontSize 17
#define kSelectedFontSize 20
#define kNormalColor [UIColor whiteColor]
#define kSelectedColor [UIColor orangeColor]

@interface SegmentView ()
{
    UIView *_selectView;
    
    
}
@end

@implementation SegmentView

//XIB文件创建
- (void)awakeFromNib{
    
    [super awakeFromNib];
    
}

//代码创建
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    
    if (self = [super initWithFrame:frame]) {
        
        //保存标题数组
        _titles = titles;
        
        //加载子视图
        [self _loadSubViews];
        
    }
    return self;
}

//使用一个附有block参数的方法 将block传入保存到属性中
- (void)segmentViewButtonClick:(ButtonSelectBlock)selectBlock{
    
    _selectBlock = selectBlock;
}

//用户更改选中index的方法
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    
    _selectedIndex = selectedIndex;
    
    //将index与按钮状态建立联系
    [self _changeStateWithAnimated:NO];
    
}

- (void)setSelectedImage:(UIImage *)selectedImage{
    
    _selectedImage = selectedImage;
    
    /*———————— 如果设置了图片 ————————————————————————————————————————————————————————————————*/
    
    //移除原有的选中视图
    [_selectView removeFromSuperview];
    
    //重新加载新的视图
    _selectView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - kSelectedImgHeight, self.bounds.size.width/_titles.count, kSelectedImgHeight)];
    
    //设置图片
    UIImageView *sv = (UIImageView *)_selectView;
    
    sv.image = _selectedImage;
    
    [self addSubview:_selectView];
    
    
}


- (void)_loadSubViews{
    
    //1.默认的背景颜色
    self.backgroundColor = [UIColor whiteColor];
    
    //2.根据传入的title个数创建按钮
    
    //计算按钮宽度
    CGFloat buttonWidth = self.bounds.size.width/_titles.count;
    
    for (int i = 0; i < _titles.count; i++) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, self.bounds.size.height - kSelectedImgHeight)];
        
        button.tag = i + 1000;
        
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        
        [button setTitleColor:kNormalColor forState:UIControlStateNormal];
        
        //设置默认字号
        button.titleLabel.font = [UIFont systemFontOfSize:kNormalFontSize];
        
        if (i == 0) {
            
            button.titleLabel.font = [UIFont systemFontOfSize:kSelectedFontSize];
            
            [button setTitleColor:kSelectedColor forState:UIControlStateNormal];
            
        }
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
    }
    
    //3.默认选中视图
    _selectView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - kSelectedImgHeight, buttonWidth, kSelectedImgHeight)];
    
    _selectView.backgroundColor = [UIColor blackColor];
    
    [self addSubview:_selectView];
    
}

- (void)buttonClick:(UIButton *)sender{
    
    _selectedIndex = sender.tag - 1000;
    
    [self _changeStateWithAnimated:YES];
    
    //如果block存在的话 调用block 将选中的index作为参数调用
    if (_selectBlock) {
        
        _selectBlock(_selectedIndex);
        
    }
    
    
    
    
}

/**
 *  更改当前选中的按钮状态 (可选动画)
 */
- (void)_changeStateWithAnimated:(BOOL)animated{
    
    //去除除当前按钮外的所有选中状态
    for (UIView *subView in self.subviews) {
        
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *btn  = (UIButton *)subView;
            
            [btn setTitleColor:kNormalColor forState:UIControlStateNormal];
            
            btn.titleLabel.font = [UIFont systemFontOfSize:kNormalFontSize];
        }
        
    }
    
    UIButton *selectButton = [self viewWithTag:_selectedIndex+1000];
    
    selectButton.titleLabel.font = [UIFont systemFontOfSize:kSelectedFontSize];
    
    [selectButton setTitleColor:kSelectedColor forState:UIControlStateNormal];
    
    //根据用户选择 决定有无动画
    CGFloat duration = animated?0.3:0.0;
    
    [UIView animateWithDuration:duration animations:^{
        
        _selectView.frame = CGRectMake(_selectedIndex * (self.bounds.size.width/_titles.count), _selectView.frame.origin.y, _selectView.frame.size.width, _selectView.frame.size.height);
        
    }];
    
    
}


@end

