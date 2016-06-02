//
//  ComingModel.h
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "BaseModel.h"

@interface ComingModel : BaseModel

@property (nonatomic,copy)NSString *title,*image,*type;

@property (nonatomic,strong)NSNumber *rMonth,*rDay,*wantedCount;



@end
