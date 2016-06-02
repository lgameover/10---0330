//
//  PosterView.m
//  PRODUCT
//
//  Created by BEVER on 16/3/24.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "PosterView.h"
#import "PosterCollectionView.h"
#import "TopCollectionView.h"
#import "HomeModel.h"

@interface PosterView ()

@property (nonatomic,strong) UIView *headerView;//下拉视图

@property (nonatomic,strong) UILabel *titleLabel;//电影标题

@property (nonatomic,strong) UIView *maskView;//阴影视图

@property (nonatomic,strong) PosterCollectionView *posterCV;

@property (nonatomic,strong) TopCollectionView *topCV;


@end

@implementation PosterView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor yellowColor];
        
        [self _loadSubviews];
    }
    return self;
    
}

- (void)setDatalist:(NSMutableArray *)datalist{
    
    //保存数据列表
    _datalist = datalist;
    
    //并将数据列表传递给子视图
    _posterCV.datalist = _datalist;
    
    _topCV.datalist = _datalist;
    
    HomeModel *model = _datalist[0];
    
    _titleLabel.text = model.title;
    
}

- (void)_loadSubviews{
    
    //1.电影标题label
    [self _createTitleLabel];
    
    NSLog(@"%f",self.bounds.size.height);
    
    //2.self上的大海报集合视图
    _posterCV = [[PosterCollectionView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, self.bounds.size.height -49 -64 - 35 -30) itemWidth:kScreenWidth-120];
    
    _posterCV.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_posterCV];
    
    //3.聚光灯
    [self _createLight];
    
    //4.阴影
    [self _createMask];
    
    //5.顶端下拉视图
    [self _createHeaderView];
    
    //6.下拉视图上的集合视图
    _topCV = [[TopCollectionView alloc]initWithFrame:CGRectMake(0, 0, _headerView.bounds.size.width, 120) itemWidth:100];
    
    [_headerView addSubview:_topCV];
    
    //7.添加KVO监听者
    
    [self _addKVO];
    
}

- (void)_addKVO{
    
    //1.大海报监听小海报的index
    [_topCV addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:nil];
    
    //2.小海报监听大海报index
    [_posterCV addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:nil];
    
}


//KVO监听者调用的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    
    /**
     *  KeyPath : 监听的键值路径
     Object : 监听的对象
     change : 字典 -> new:新值 old:旧值
     */
    if ([keyPath isEqualToString:@"currentIndex"]) {
        
        NSInteger newIndex = [[change objectForKey:@"new"]integerValue];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:newIndex inSection:0];
        
        
        HomeModel *model = _datalist[newIndex];
        
        _titleLabel.text = model.title;
        
        
        if ([object isMemberOfClass:[TopCollectionView class]] && _posterCV.currentIndex != newIndex) {
            
            //小海报index改变 -> 更新大海报index
            [_posterCV scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            
            //更新index保证下一次KVO正确出发
            _posterCV.currentIndex = newIndex;
            
            
        }else if ([object isMemberOfClass:[PosterCollectionView class]] && _topCV.currentIndex != newIndex){
            
            [_topCV scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            
            _topCV.currentIndex = newIndex;
            
        }
        
        
    }
    
    
}


- (void)_createHeaderView{
    
    //indexBG_home 下拉背景图
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -120, kScreenWidth, 150)];
    
    _headerView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_headerView];
    
    //背景图片
    UIImage *bgImg = [[UIImage imageNamed:@"indexBG_home"]stretchableImageWithLeftCapWidth:0 topCapHeight:1];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:bgImg];
    
    imageView.frame = _headerView.bounds;
    
    [_headerView addSubview:imageView];
    
    //下拉按钮
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((_headerView.bounds.size.width-26)/2, _headerView.bounds.size.height-20, 26, 20)];
    
    [button setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateSelected];
    
    [button addTarget:self action:@selector(pullDown:) forControlEvents:UIControlEventTouchUpInside];
    
    [_headerView addSubview:button];
    
}

/**
 *  点击下拉按钮调用
 */
- (void)pullDown:(UIButton *)button{
    
    button.selected = !button.selected;
    
    if (button.selected == YES) {
        
        _maskView.hidden = NO;
        
        //下拉动画
        [UIView animateWithDuration:0.3 animations:^{
            
            _headerView.transform = CGAffineTransformMakeTranslation(0, 120);
            
        }];
        
    }else{
        
        _maskView.hidden = YES;
        
        //收起动画
        [UIView animateWithDuration:0.3 animations:^{
            
            _headerView.transform = CGAffineTransformIdentity;
            
        }];
        
    }
    
}

- (void)_createLight{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    
    imageView.image = [UIImage imageNamed:@"pic_title_bg.9"];
    
    [self addSubview:imageView];
    
    UIImageView *leftLight = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 124, 204)];
    
    leftLight.image = [UIImage imageNamed:@"light"];
    
    [self addSubview:leftLight];
    
    UIImageView *rightLight = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-124, 10, 124, 204)];
    
    rightLight.image = [UIImage imageNamed:@"light"];
    
    [self addSubview:rightLight];
    
    
    
}

- (void)_createTitleLabel{
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-35-64-49, kScreenWidth, 35)];
    
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _titleLabel.textColor = [UIColor whiteColor];
    
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    _titleLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"poster_title_home"]];
    
    [self addSubview:_titleLabel];
    
}

- (void)_createMask{
    
    _maskView = [[UIView alloc]initWithFrame:self.bounds];
    
    _maskView.backgroundColor = [UIColor darkGrayColor];
    
    _maskView.alpha = 0.2;
    
    _maskView.hidden = YES;
    
    //    [self insertSubview:_maskView belowSubview:_headerView];
    
    [self addSubview:_maskView];
    
}

@end
