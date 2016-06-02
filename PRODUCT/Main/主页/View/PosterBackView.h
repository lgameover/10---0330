//
//  PosterBackView.h
//  PRODUCT
//
//  Created by BEVER on 16/3/24.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface PosterBackView : UIView

@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *directorName;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UIImageView *posterImg;

@property (nonatomic,strong)HomeModel *model;

@end
