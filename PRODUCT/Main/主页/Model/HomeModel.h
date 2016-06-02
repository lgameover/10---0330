//
//  HomeModel.h
//  PRODUCT
//
//  Created by BEVER on 16/3/22.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "BaseModel.h"

@interface HomeModel : BaseModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,strong) NSNumber *ratingFinal;
@property (nonatomic,copy) NSString *directorName;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,strong) NSNumber *rYear;




/**
 *  {
 "movieId": 208253,
 "titleCn": "分歧者2：绝地反击",
 "titleEn": "Insurgent",
 "img": "http://img31.mtime.cn/mt/2015/05/31/153259.70730086_1280X720X2.jpg",
 "ratingFinal": 6.9,
 "length": 119,
 "directorName": "罗伯特·斯文克",
 "actorName1": "谢琳·伍德蕾",
 "actorName2": "提奥·詹姆斯",
 "type": "冒险 | 科幻 | 惊悚",
 "rYear": 2015,
 "rMonth": 6,
 "rDay": 19,
 "isNew": false,
 "isHot": false,
 "commonSpecial": "练练听力挺好的",
 "wantedCount": 3195,
 "is3D": true,
 "isIMAX": false,
 "isIMAX3D": true,
 "isDMAX": true,
 "nearestShowtime": {
 "nearestCinemaCount": 88,
 "nearestShowtimeCount": 280,
 "nearestShowDay": 1435708800,
 "isTicket": true
 }
 }
 */


@end
