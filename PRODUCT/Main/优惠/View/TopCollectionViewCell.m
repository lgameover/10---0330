//
//  TopCollectionViewCell.m
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "TopCollectionViewCell.h"

@implementation TopCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)setModel:(AttentionModel *)model
{
    _model = model;
    
    self.releaseDate.text = _model.releaseDate;
    
    self.title.text = _model.title;
    
    [self.iamge setImageWithURL:[NSURL URLWithString:_model.image]];
    
    self.wantedCount.text = [NSString stringWithFormat:@"%@人期待上映",_model.wantedCount];
    
    self.tyoe.text = _model.type;
    
    self.director.text = _model.director;
    
    self.actor.text = [NSString stringWithFormat:@"%@ %@",_model.actor1,_model.actor2];
    
    
}


@end
