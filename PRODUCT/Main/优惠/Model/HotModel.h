//
//  HotModel.h
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "BaseModel.h"

@interface HotModel : BaseModel


@property (nonatomic,copy)NSString *tCn;

@property (nonatomic,copy)NSString *img;

@property (nonatomic,copy)NSString *commonSpecial;

@property (nonatomic,copy)NSString *rd;

@property (nonatomic,strong)NSNumber *r;

@property (nonatomic,strong)NSNumber *NearestCinemaCount;

@property (nonatomic,strong)NSNumber *NearestShowtimeCount;

@property (nonatomic,strong)NSNumber *wantedCount;

@property (nonatomic,strong)NSNumber *is3D;

@property (nonatomic,strong)NSNumber *isIMAX;

@property (nonatomic,strong)NSNumber *isIMAX3D;

@property (nonatomic,strong)NSNumber *isDMAX;


@end
