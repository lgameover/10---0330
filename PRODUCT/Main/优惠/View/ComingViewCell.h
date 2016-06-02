//
//  ComingViewCell.h
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComingModel.h"

@interface ComingViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *wantedCount;

@property (weak, nonatomic) IBOutlet UILabel *type;

@property (weak, nonatomic) IBOutlet UILabel *rDay;

@property (nonatomic,strong) ComingModel *comingModel;

@end

