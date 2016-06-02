//
//  HomeCell.h
//  PRODUCT
//
//  Created by BEVER on 16/3/22.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarRatingView.h"
#import "HomeModel.h"
@interface HomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleCn;
@property (weak, nonatomic) IBOutlet StarRatingView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *ratingFinal;


@property(nonatomic,strong)HomeModel *model;
@end
