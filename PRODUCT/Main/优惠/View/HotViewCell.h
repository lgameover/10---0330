//
//  HotViewCell.h
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotModel.h"
@interface HotViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *tCn;
@property (weak, nonatomic) IBOutlet UILabel *commonSpecial;
@property (weak, nonatomic) IBOutlet UILabel *rd;
@property (weak, nonatomic) IBOutlet UILabel *nearestCinemaCount;
@property (weak, nonatomic) IBOutlet UILabel *rattingFinal;

@property (nonatomic,strong) HotModel *model;


@end
