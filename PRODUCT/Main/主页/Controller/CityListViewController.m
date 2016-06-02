//
//  CityLIstViewController.m
//  PRODUCT
//
//  Created by BEVER on 16/3/23.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "CityLIstViewController.h"
#import "CityModel.h"

#define kItemSpace 10
@interface CityListViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_allkeys;
    NSArray *_staticAllKeys;
}
@property(nonatomic,strong)NSMutableDictionary *citiesDic;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UITextField *searchField;
@end

@implementation CityListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"城市列表";
    
    [self _loadSearch];
    
    [self loadData];
    
    [self _loadCollection];
    
}

- (void)_loadSearch{
    
    _searchField = [[UITextField alloc]initWithFrame:CGRectMake(30, 5, kScreenWidth-60, 30)];
    
    _searchField.borderStyle = UITextBorderStyleRoundedRect;
    
    _searchField.placeholder = @"请输入检索的字母";
    
    [self.view addSubview:_searchField];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeText:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

- (void)changeText:(NSNotification *)notification{
    
    NSString *text = _searchField.text;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS [c] %@",text];
    
    NSArray *filteredArrary = [_allkeys filteredArrayUsingPredicate:predicate];
    
    _allkeys = filteredArrary;
    
    if (text.length == 0) {
        
        _allkeys = _staticAllKeys;
    }
    
    [_collectionView reloadData];
    
}



-(void)loadData{
    
    if (_citiesDic == nil) {
        
        _citiesDic = [[NSMutableDictionary alloc]init];
        
    }
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"cities" ofType:@"json" ]];
    
    NSDictionary *cities = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSDictionary *infor = [cities objectForKey:@"infor"];
    
    NSArray *listItems = [infor objectForKey:@"listItems"];
    
    NSMutableArray *hotArr = [[NSMutableArray alloc]init];
    
    [_citiesDic setObject:hotArr forKey:@"hot"];
    
    for (NSDictionary *cityDic in listItems) {
        
        CityModel *model = [[CityModel alloc]initWithDic:cityDic];
        
        NSMutableArray *cityArr = [_citiesDic objectForKey:model.charindex];
        
        if (cityArr == nil) {
            
            cityArr = [[NSMutableArray alloc]init];
            
            [cityArr addObject:model];
            
            [_citiesDic setObject:cityArr forKey:model.charindex];
            
        }else{
            
            [cityArr addObject:model];
            
        }
        
        if ([model.level isEqualToString:@"1"]) {
            
            [hotArr addObject:model];
        }
        
    }
    _allkeys = [[_citiesDic allKeys]sortedArrayUsingSelector:@selector(compare:)];
    _staticAllKeys = [[NSArray alloc]initWithArray:_allkeys];
    
    NSLog(@"%@",_citiesDic);
    

}


-(void)_loadCollection{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreenWidth-4*kItemSpace)/3, 30);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(kScreenWidth, 50);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-64-40)collectionViewLayout:layout];
    _collectionView.dataSource = self;
    
    _collectionView.delegate = self;
    
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"city_cell"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"city_header"];
    
    
}

#pragma mark --UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _allkeys.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSString *key = _allkeys[section];
    
    NSArray *cityArr = [_citiesDic objectForKey:key];
    
    return cityArr.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"city_cell" forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 10.0;
    
    cell.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    cell.layer.borderWidth = 3.0;
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    for (UIView *subView in cell.subviews) {
        
        if ([subView isMemberOfClass:[UILabel class]]) {
            
            [subView removeFromSuperview];
        }
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:cell.bounds];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = [UIColor whiteColor];
    
    label.font = [UIFont boldSystemFontOfSize:20];
    
    [cell addSubview:label];
    
    
    NSString *key = _allkeys[indexPath.section];
    
    NSArray *cityArr = [_citiesDic objectForKey:key];
    
    CityModel *model = cityArr[indexPath.item];
    
    label.text = model.name;
    
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"city_header" forIndexPath:indexPath];
        
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            //GCD : 应用生命周期内只运行一次的方法
            
        });
        
        
        for (UIView *subView in headerView.subviews) {
            
            if ([subView isMemberOfClass:[UILabel class]]||[subView isMemberOfClass:[UIImageView class]]) {
                
                [subView removeFromSuperview];
            }
        }
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:headerView.bounds];
        
        imageView.image = [UIImage imageNamed:@"topmenu_tab_bg.png"];
        
        [headerView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:headerView.bounds];
        
        label.textAlignment = NSTextAlignmentLeft;
        
        label.textColor = [UIColor whiteColor];
        
        label.font = [UIFont boldSystemFontOfSize:20];
        
        label.text = [NSString stringWithFormat:@"    %@",_allkeys[indexPath.section]];
        
        [headerView addSubview:label];
        
        return headerView;
        
        
    }
    
    return nil;
    
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(10, 5, 10, 5);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    
    NSString *key = _allkeys[indexPath.section];
    
    NSArray *array = [_citiesDic objectForKey:key];
    
    CityModel *model = array[indexPath.row];
    
    //调用block
    _cityBlock(model.name);
    
    [[NSUserDefaults standardUserDefaults]setObject:model.name forKey:kCurrentCityName];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end