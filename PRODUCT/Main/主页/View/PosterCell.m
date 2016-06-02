//
//  PosterCell.m
//  PRODUCT
//
//  Created by BEVER on 16/3/24.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "PosterCell.h"


@implementation PosterCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self _loadSubViews];
    }
    return self;
    
}

- (void)_loadSubViews{
    
    _frontImgView = [[UIImageView alloc]initWithFrame:self.bounds];
    
    //    _frontImgView.hidden = YES;
    
    [self addSubview:_frontImgView];
    
    /*————————————————————————————————————————————————————————————————————————*/
    
    //使用XIB文件加载UIView
    _backView = [[[NSBundle mainBundle]loadNibNamed:@"PosterBackView" owner:self options:nil]lastObject];
    
    _backView.frame = self.bounds;
    
    _backView.hidden = YES;//默认隐藏背面视图
    
    [self addSubview:_backView];
    
    
}

- (void)setModel:(HomeModel *)model{
    
    _model = model;
    
    /*————————————————————————————————————————————————————————————————————————*/
    
    [_frontImgView setImageWithURL:[NSURL URLWithString:_model.img]];
    
    //将数据model传递给反面视图
    _backView.model = _model;
    
}

- (void)flip{
    
    if (_backView.hidden == YES) {
        
        [self flipToBack];
        
    }else{
        
        [self flipToFront];
        
    }
    
}

- (void)flipToBack{
    
    _backView.hidden = NO;
    
    _frontImgView.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:YES];
        
    }];
}

- (void)flipToFront{
    
    _backView.hidden = YES;
    
    _frontImgView.hidden = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
        
    }];
    
}

@end