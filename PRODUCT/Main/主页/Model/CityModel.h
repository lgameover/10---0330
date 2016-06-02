//
//  CityModel.h
//  PRODUCT
//
//  Created by BEVER on 16/3/23.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "BaseModel.h"

@interface CityModel : BaseModel

@property (nonatomic,copy)NSString *idNumber;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *parentid;
@property (nonatomic,copy)NSString *nodepath;
@property (nonatomic,copy)NSString *namepath;
@property (nonatomic,copy)NSString *charindex;
@property (nonatomic,copy)NSString *level;
@property (nonatomic,copy)NSString *orderby;

/**
 *  {
 "id": "1",
 "name": "北京市",
 "parentid": "0",
 "nodepath": "0",
 "namepath": "北京市",
 "charindex": "B",
 "level": "1",
 "orderby": "1"
 }
 */


@end
