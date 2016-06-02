//
//  MovieViewController.m
//  PRODUCT
//
//  Created by BEVER on 16/3/21.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "MovieViewController.h"
#import "StarRatingView.h"
#import "SegmentView.h"
#import "MovieModel.h"
#import "MovieViewCell.h"
#import "MovieView.h"

#define kLocationLongitude 116.9825
#define kLocationLatitude 36.63898

@interface MovieViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    SegmentView *_segment;
    
    UITableView *_tableView;
    
    MovieView *_movieView;
    
    
}

@property (nonatomic,strong) NSMutableArray *datalist;

@property (nonatomic,strong) NSArray *data;

@end

@implementation MovieViewController

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.title = @"影院";
        
        self.tabBarItem.image = [UIImage imageNamed:@"index_menu_ciname.png"];
        
        self.tabBarItem.title = nil;
        
    }
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _datalist = [[NSMutableArray alloc]init];
    
    NSArray *movie = [JsonParser jsonFromFileName:@"cinema"];
    
    for (NSDictionary *dic in movie) {
        
        MovieModel *model = [[MovieModel alloc]initWithDic:dic];
        
        [_datalist addObject:model];
        
    }
    
    _data = [NSArray arrayWithArray:_datalist];
    
    
    /*————————————————————————————————————————————————————————————————————————*/
    
    _segment = [[SegmentView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) titles:@[@"全部",@"价格",@"附近",@"筛选"]];
    
    _segment.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_top_movie_background_cover"]];
    
    _segment.selectedImage = [UIImage imageNamed:@"color_line"];
    
    [_segment segmentViewButtonClick:^(NSInteger selectedIndex) {
        
        switch (selectedIndex) {
            case 0:
            {
                //全部
                _datalist = [NSMutableArray arrayWithArray:_data];
                
                [_tableView reloadData];
                
                [self hideMovieView];
            }
                break;
            case 1:
            {
                //价格
                [self byPrice];
            }
                break;
            case 2:
            {
                //附近
                [self byDistance];
            }
                break;
            case 3:
            {
                //筛选
                [self byChoose];
            }
                break;
                
            default:
                break;
        }
        
        
        
    }];
    
    [self.view addSubview:_segment];
    
    /*————————————————————————————————————————————————————————————————————————*/
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-64-40-49) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    _tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    
}

- (void)byPrice{
    
    for (int i = 0; i < _datalist.count; i++) {
        
        for (int j = 0; j < _datalist.count - i; j++) {
            
            MovieModel *model1 = _datalist[i];
            MovieModel *model2 = _datalist[j];
            
            if (model1.minPrice < model2.minPrice) {
                
                [_datalist exchangeObjectAtIndex:i withObjectAtIndex:j];
                
            }
            
        }
        
    }
    
    [_tableView reloadData];
    
    
    [self hideMovieView];
    
}

- (void)byDistance{
    
    //lat 36.55  long 116.73
    for (int i = 0; i < _datalist.count; i++) {
        
        for (int j = 0; j < _datalist.count - i; j++) {
            
            MovieModel *model1 = _datalist[i];
            MovieModel *model2 = _datalist[j];
            
            //比较距离
            CGFloat long1 = [model1.longitude floatValue];
            CGFloat lat1 = [model1.latitude floatValue];
            
            CGFloat dis1 = pow(long1-kLocationLongitude, 2) + pow(lat1-kLocationLatitude, 2);
            
            CGFloat long2 = [model2.longitude floatValue];
            CGFloat lat2 = [model2.latitude floatValue];
            
            CGFloat dis2 = pow(long2-kLocationLongitude, 2) + pow(lat2-kLocationLatitude, 2);
            
            
            if (dis1 < dis2) {
                
                [_datalist exchangeObjectAtIndex:i withObjectAtIndex:j];
                
            }
        }
        
    }
    
    [_tableView reloadData];
    
    [self hideMovieView];
    
    
}

- (void)byChoose{
    
    if (_movieView == nil) {
        _movieView = [[MovieView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 240)];
        
        _movieView.hidden = YES;
        
        [self.view addSubview:_movieView];
    }
    
    _movieView.hidden = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _movieView.transform = CGAffineTransformMakeTranslation(0, -240-64-49);
        
    }];
    
}

- (void)hideMovieView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _movieView.transform = CGAffineTransformIdentity;
        
    }];
    
}

#pragma mark -
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _datalist.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"MovieViewCell";
    
    MovieViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MovieViewCell" owner:self options:nil]firstObject];
        
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    
    MovieModel *model = _datalist[indexPath.row];
    
    cell.model = model;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


@end
