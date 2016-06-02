//
//  PosterBackView.m
//  PRODUCT
//
//  Created by BEVER on 16/3/24.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "PosterBackView.h"

@implementation PosterBackView

-(void)setModel:(HomeModel *)model{
    
    [_posterImg setImageWithURL:[NSURL URLWithString:model.img]];
    
    _movieName.text = model.title;
    
    _directorName.text = model.directorName;
    
    _type.text = model.type;
    
    _year.text = [NSString stringWithFormat:@"%@",model.rYear];
    
    
}

@end
