//
//  StarRatingView.m
//  PRODUCT
//
//  Created by BEVER on 16/3/22.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "StarRatingView.h"

@interface StarRatingView ()
{
    UIView *_yellowView;
    
    UIView *grayView;
}
@end

@implementation StarRatingView


- (void)awakeFromNib{
    
    [self _loadSubViews];
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width/5.0)]) {
        
        [self _loadSubViews];
        
    }
    return self;
    
}

- (void)_loadSubViews{
    
    UIImage *gray = [UIImage imageNamed:@"gray.png"];
    
    UIImage *yellow = [UIImage imageNamed:@"yellow.png"];
    
    CGFloat imgWidth = gray.size.width;
    
    CGFloat imgHeight = gray.size.height;
    
    grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5*imgWidth, 1*imgHeight)];
    
    grayView.backgroundColor = [UIColor colorWithPatternImage:gray];
    
    grayView.transform = CGAffineTransformMakeScale(self.frame.size.width/grayView.frame.size.width, self.frame.size.height/grayView.frame.size.height);
    
    grayView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    [self addSubview:grayView];
    
    _yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5*imgWidth, 1*imgHeight)];
    
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellow];
    
    _yellowView.transform = CGAffineTransformMakeScale(self.frame.size.width/_yellowView.frame.size.width, self.frame.size.height/_yellowView.frame.size.height);
    
    _yellowView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    [self addSubview:_yellowView];
    
}

- (void)setRating:(float)rating{
    
    CGFloat scale = rating/10.0;
    
    _yellowView.frame = CGRectMake(grayView.frame.origin.x, grayView.frame.origin.y, grayView.frame.size.width * scale, grayView.frame.size.height);
    
    
}



@end