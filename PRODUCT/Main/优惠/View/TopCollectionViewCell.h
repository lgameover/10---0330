//
//  TopCollectionViewCell.h
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionModel.h"

@interface TopCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *releaseDate;

@property (weak, nonatomic) IBOutlet UIImageView *iamge;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *wantedCount;

@property (weak, nonatomic) IBOutlet UILabel *tyoe;

@property (weak, nonatomic) IBOutlet UILabel *director;

@property (weak, nonatomic) IBOutlet UILabel *actor;

@property (nonatomic,strong) AttentionModel *model;

@end
