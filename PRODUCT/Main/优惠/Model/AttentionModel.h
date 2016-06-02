//
//  AttentionModel.h
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "BaseModel.h"

@interface AttentionModel : BaseModel

@property (nonatomic,copy)NSString *title,*image,*releaseDate,*type,*director,*actor1,*actor2;

@property (nonatomic,strong)NSNumber *wantedCount;

@end
