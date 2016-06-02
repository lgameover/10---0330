//
//  BaseModel.m
//  PRODUCT
//
//  Created by BEVER on 16/3/22.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


- (instancetype)initWithDic:(NSDictionary *)dictionary{
    
    if (self = [super init]) {
        
        [self setAttributes:dictionary];
        
    }
    return self;
    
}

- (void)setAttributes:(NSDictionary *)dictionary{
    
    NSArray *allkeys = [dictionary allKeys];
    
    
    for (NSString *key in allkeys) {

        SEL setSelector = [self selFromAttributeName:key];
        
        if ([self respondsToSelector:setSelector]) {
            
            //5.获取key对应的字典中的对象
//            "img":"http://img31.mtime.cn/mt/2015/05/31/153259.70730086_1280X720X2.jpg"
            
            id object = [dictionary objectForKey:key];
            
            [self performSelector:setSelector withObject:object];
            
        }
        
   
        
        for (NSString *mapKey in [self.mapDic allKeys]) {
            
            NSString *attributeName = [self.mapDic objectForKey:mapKey];
            
            SEL setMehod = [self selFromAttributeName:attributeName];
            
            id object = [dictionary objectForKey:mapKey];
            
            if ([self respondsToSelector:setMehod]) {
                
                [self performSelector:setMehod withObject:object];
                
            }
            
        }
        
        
        
        
    }
    
    
    
}

- (SEL)selFromAttributeName:(NSString *)attributeName{
    
    NSString *firstChar = [[attributeName substringToIndex:1]uppercaseString];
    
    NSString *otherChars = [attributeName substringFromIndex:1];
    
    NSString *setMethod = [NSString stringWithFormat:@"set%@%@:",firstChar,otherChars];
    
    SEL setSelector = NSSelectorFromString(setMethod);
    
    return setSelector;
    
}


@end
