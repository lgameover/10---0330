//
//  JsonParser.m
//  PRODUCT
//
//  Created by BEVER on 16/3/25.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "JsonParser.h"

@implementation JsonParser

+ (id)jsonFromFileName:(NSString *)fileName{
    
    //1.文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:fileName ofType:@"json"];
    
    //2.文件 -> data
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //3.从数据中读取字典或者数组
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    return json;
}

@end
