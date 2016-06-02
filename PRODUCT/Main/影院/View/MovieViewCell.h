//
//  MovieViewCell.h
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieModel.h"
@interface MovieViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *cinameName;

@property (weak, nonatomic) IBOutlet UILabel *minPrice;

@property (nonatomic,strong)MovieModel *model;

@end
