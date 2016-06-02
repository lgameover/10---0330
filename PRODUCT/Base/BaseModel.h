//
//  BaseModel.h
//  PRODUCT
//
//  Created by BEVER on 16/3/22.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic,strong)NSDictionary *mapDic;

- (instancetype)initWithDic:(NSDictionary *)dictionary;

- (void)setAttributes:(NSDictionary *)dictionary;


@end
