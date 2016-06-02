//
//  CityLIstViewController.h
//  PRODUCT
//
//  Created by BEVER on 16/3/23.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef void(^CityBlock)(NSString *cityName);

@interface CityListViewController : BaseViewController

@property(nonatomic,copy)CityBlock cityBlock;

-(void)setCityBlock:(CityBlock)cityBlock;

@end
