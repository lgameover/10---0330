//
//  MovieViewCell.m
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "MovieViewCell.h"

@implementation MovieViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)setModel:(MovieModel *)model{
    
    _model = model;
    
    _address.text = _model.address;
    
    _cinameName.text = _model.cinameName;
    
    _minPrice.text = [NSString stringWithFormat:@"¥%.1f",[_model.minPrice floatValue]/100.0];
    
    /*————————————————————————————————————————————————————————————————————————*/
    
    //影院功能图
    /**
     *  {
     "has3D": 1,              v10_18_Feature3D
     "hasIMAX": 0,            v10_18_FeatureIMAX
     "hasVIP": 0,               v10_18_VIP
     "hasPark": 1,            v10_18_park
     "hasServiceTicket": 1,   v10_18_serviceTicket
     "hasWifi": 0,              v10_18_wifi
     "hasLoveseat": 0,
     "hasFeature4K": 0,
     "hasFeatureDolby": 0,
     "hasFeatureHuge": 0,
     "hasFeature4D": 0
     }
     */
    NSInteger imgCount = 0;
    NSDictionary *key_imgName = @{@"has3D":@"v10_18_Feature3D",
                                  @"hasIMAX":@"v10_18_FeatureIMAX",
                                  @"hasVIP":@"v10_18_VIP",
                                  @"hasPark":@"v10_18_park",
                                  @"hasServiceTicket":@"v10_18_serviceTicket",
                                  @"hasWifi":@"v10_18_wifi"};
    
    
    for (UIView *subView in self.subviews) {
        
        if ([subView isKindOfClass:[UIImageView class]]&&subView.frame.size.width == 36) {
            
            [subView removeFromSuperview];
        }
    }
    
    //循环+判断 创建影院设施图片
    for (int i = 0; i<6; i++) {
        
        NSString *key_feature = [key_imgName allKeys][i];
        
        if ([_model.feature[key_feature]integerValue]==1) {
            
            UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:key_imgName[key_feature]]];
            
            iv.frame = CGRectMake(8 + imgCount * (36+3), 60, 36, 36);
            
            [self addSubview:iv];
            
            imgCount++;
        }
        
        
    }

    
    
}



@end
