//
//  HomeCell.m
//  PRODUCT
//
//  Created by BEVER on 16/3/22.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)setModel:(HomeModel *)model{
    
    _model = model;
    
    _ratingView.rating = [_model.ratingFinal floatValue];
    
    [_img setImageWithURL:[NSURL URLWithString:_model.img]];
    
    _titleCn.text = _model.title;
    
    _ratingFinal.text = [NSString stringWithFormat:@"%@",_model.ratingFinal];
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
