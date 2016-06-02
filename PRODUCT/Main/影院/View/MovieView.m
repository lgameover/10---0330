//
//  MovieView.m
//  PRODUCT
//
//  Created by BEVER on 16/3/30.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "MovieView.h"
#import "SegmentView.h"

@interface MovieView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    SegmentView *_segment;
    
    UICollectionView *_collectionView;
    
    NSMutableArray *_datalist;
    
    NSArray *_plist;
    
    UIImageView *_subway;
}

@end

@implementation MovieView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self loadSubviews];
        
    }
    return self;
    
}

- (void)loadSubviews{
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cinema_head_bg"]];
    
    _plist = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"MovieList" ofType:@"plist"]];
    
    _datalist = _plist[0];
    
    _segment = [[SegmentView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40) titles:@[@"特色",@"商圈",@"地区",@"地铁"]];
    
    _segment.backgroundColor = [UIColor clearColor];
    
    //    _segment.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_top_movie_background_cover"]];
    
    _segment.selectedImage = [UIImage imageNamed:@"color_line"];
    
    [_segment segmentViewButtonClick:^(NSInteger selectedIndex) {
        
        if (selectedIndex == 3) {
            
            _datalist = nil;
            
            if (_subway == nil) {
                
                _subway = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-40)];
                
                _subway.image = [UIImage imageNamed:@"bus"];
                
                _subway.hidden = YES;
                
                [_collectionView addSubview:_subway];
            }
            
            _subway.hidden = NO;
            
            
            
        }else{
            
            _subway.hidden = YES;
            
            _datalist = _plist[selectedIndex];
            
        }
        
        
        [_collectionView reloadData];
        
    }];
    
    [self addSubview:_segment];
    
    /*————————————————————————————————————————————————————————————————————————*/
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.minimumLineSpacing = 0;
    
    layout.minimumInteritemSpacing = 0;
    
    layout.itemSize = CGSizeMake((self.frame.size.width -40)/3, (self.bounds.size.height-40-20)/3);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, self.bounds.size.width, self.bounds.size.height-40) collectionViewLayout:layout];
    
    //    UIImageView *bgView = [[UIImageView alloc]initWithFrame:_collectionView.bounds];
    
    //    bgView.image = [UIImage imageNamed:@"home_top_movie_background_cover"];
    
    //    _collectionView.backgroundView = bgView;
    
    _collectionView.backgroundColor = [UIColor clearColor];
    
    _collectionView.dataSource = self;
    
    _collectionView.delegate = self;
    
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MovieViewCell"];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _datalist.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieViewCell" forIndexPath:indexPath];
    
    for (UIView *subView in cell.subviews) {
        
        [subView removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:cell.bounds];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = [UIColor whiteColor];
    
    label.font = [UIFont systemFontOfSize:20];
    
    label.text = _datalist[indexPath.row];
    
    [cell addSubview:label];
    
    return cell;
    
}



@end
