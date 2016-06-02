//
//  MovieModel.h
//  PRODUCT
//
//  Created by BEVER on 16/3/29.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "BaseModel.h"

@interface MovieModel : BaseModel

@property (nonatomic,copy) NSString *cinameName,*address;

@property (nonatomic,strong) NSNumber *minPrice;

@property (nonatomic,strong) NSDictionary *feature;

@property (nonatomic,strong) NSNumber *longitude,*latitude;

@end
/*
 {
 "cinemaId": 2735,
 "cinameName": "新世纪影城阳光100店",
 "address": "济南市阳光新路阳光100美乐汇购物广场3楼",
 "districtID": 1544,
 "isETicket": false,
 "isTicket": true,
 "ratingFinal": 8.714447,
 "longitude": 116.9825,
 "latitude": 36.63898,
 "baiduLongitude": 116.9893,
 "baiduLatitude": 36.64297,
 "movieCount": 17,
 "showtimeCount": 142,
 "minPrice": 3300,
 "feature": {
 "has3D": 1,
 "hasIMAX": 0,
 "hasVIP": 0,
 "hasPark": 1,
 "hasServiceTicket": 1,
 "hasWifi": 0,
 "hasLoveseat": 0,
 "hasFeature4K": 0,
 "hasFeatureDolby": 0,
 "hasFeatureHuge": 0,
 "hasFeature4D": 0
 },
 "couponActivityList": []
 }
 */