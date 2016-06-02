//
//  ComingViewCell.m
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "ComingViewCell.h"

@implementation ComingViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setComingModel:(ComingModel *)comingModel
{
    _comingModel = comingModel;
    
    self.title.text = _comingModel.title;
    
    self.rDay.text = [NSString stringWithFormat:@"%@日",_comingModel.rDay];
    
    [self.image setImageWithURL:[NSURL URLWithString:_comingModel.image]];
    
    self.wantedCount.text = [NSString stringWithFormat:@"%@人期待上映",_comingModel.wantedCount];
    
    self.type.text = _comingModel.type;
}
@end
