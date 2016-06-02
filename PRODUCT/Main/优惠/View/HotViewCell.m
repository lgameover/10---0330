//
//  HotViewCell.m
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "HotViewCell.h"

@implementation HotViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(HotModel *)model
{
    _model = model;
    
    [_img setImageWithURL:[NSURL URLWithString:_model.img]];
    
    _tCn.text = _model.tCn;
    
    //
    if (_model.commonSpecial.length>0) {
        
        _commonSpecial.text = _model.commonSpecial;
        
    }else{
        
        _commonSpecial.text = [NSString stringWithFormat:@"%@人期待上映",_model.wantedCount];
        
    }
    
    //评分
    NSString *rattingString = [NSString stringWithFormat:@"%.1f",[_model.r floatValue]];
    
    if ([_model.r floatValue]<0) {
        
        rattingString = @"0.0";
        
    }
    //处理字符串 个位字号大 小数点后一位字号小
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:rattingString];
    
    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, 1)];
    
    _rattingFinal.attributedText = attString;
    
    //日期
    //    _rd.text = _model.rd;
    
    _rd.text = [NSString stringWithFormat:@"%@月%@日",[_model.rd substringWithRange:NSMakeRange(4, 2)],[_model.rd substringWithRange:NSMakeRange(6, 2)]];
    
    _nearestCinemaCount.text = [NSString stringWithFormat:@"今日%@家影院 %@场",_model.NearestCinemaCount,_model.NearestShowtimeCount];
    
    /*————————————————————————————————————————————————————————————————————————*/
    
    //电影播放类型标记图
    //图片:icon_movie_3d icon_movie_imax icon_hot_show_IMAX3D icon_hot_show_DMAX
    NSInteger imgCount = 0;
    
    //x > 118 y > 114
    
    //处理复用
    
    for (UIView *subView in self.subviews) {
        
        if ([subView isKindOfClass:[UIImageView class]]&&subView.frame.size.width == 32) {
            
            [subView removeFromSuperview];
        }
    }
    
    if ([_model.is3D boolValue]) {
        
        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_movie_3d"]];
        
        iv.frame = CGRectMake(118 + imgCount * 32, 120, 32, 20);
        
        [self addSubview:iv];
        
        imgCount++;
    }
    
    if ([_model.isIMAX boolValue]) {
        
        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_movie_imax"]];
        
        iv.frame = CGRectMake(118 + imgCount * 32, 120, 32 , 20);
        
        [self addSubview:iv];
        
        imgCount++;
        
    }
    
    if ([_model.isIMAX3D boolValue]) {
        
        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_hot_show_IMAX3D"]];
        
        iv.frame = CGRectMake(118 + imgCount * 32, 120, 32 , 20);
        
        [self addSubview:iv];
        
        imgCount++;
        
    }
    
    if ([_model.isDMAX boolValue]) {
        
        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_hot_show_DMAX"]];
        
        iv.frame = CGRectMake(118 + imgCount * 32, 120, 32 , 20);
        
        [self addSubview:iv];
        
        imgCount++;
        
    }
    
    
}

@end
