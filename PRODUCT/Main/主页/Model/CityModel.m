//
//  CityModel.m
//  PRODUCT
//
//  Created by BEVER on 16/3/23.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

- (void)setAttributes:(NSDictionary *)dictionary{
    
    self.mapDic = @{@"id":@"idNumber"};
    
    [super setAttributes:dictionary];
    
}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"%@",self.charindex];
    
}

@end
