//
//  PrivilegeViewController.m
//  PRODUCT
//
//  Created by BEVER on 16/3/21.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "PrivilegeViewController.h"
#import "SegmentView.h"
#import "HotModel.h"
#import "ComingModel.h"
#import "ComingViewCell.h"
#import "HotViewCell.h"
#import "AttentionModel.h"
#import "TopCollectionViewCell.h"


@interface PrivilegeViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

{
    SegmentView *_segment;
    
    UITableView *_tableView1,*_tableView2;
    
    NSMutableArray *_datalist1,*_datalist2,*_datalist3;
    
    UICollectionView *_collectionView;
    
    NSMutableDictionary *_dataDic;
    
    NSArray *_allkeys;
}

@end

@implementation PrivilegeViewController

-(instancetype)init
{
    if(self = [super init])
    {
        self.title = @"优惠";
        
        self.tabBarItem.image = [UIImage imageNamed:@"index_menu_coup.png"];
        
        self.tabBarItem.title = nil;
    }
    
    return self;
    
}

//调用block方法来设置标题
- (void)_createSegment{
    
    _segment = [[SegmentView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) titles:@[@"正在热映",@"即将上映"]];
    
    _segment.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_top_movie_background_cover"]];
    
    _segment.selectedImage = [UIImage imageNamed:@"color_line"];    [_segment segmentViewButtonClick:^(NSInteger selectedIndex) {
        
        
        [UIView animateWithDuration:0.3 animations:^{
            
            if (selectedIndex == 1) {
                
                CGAffineTransform newTransform = CGAffineTransformMakeTranslation(-kScreenWidth, 0);
                
                _tableView1.transform = newTransform;
                
                _tableView2.transform = newTransform;
                
            }else{
                
                CGAffineTransform oldTransform = CGAffineTransformIdentity;
                
                _tableView1.transform = oldTransform;
                
                _tableView2.transform = oldTransform;
                
                
            }
            
            
        }];
        
        
    }];
    
    //添加一个动画,点击那个,滑动到那个tableview
    
    //- (void)setSegmentBlock:(SegmentBlock)segmentBlock;
    
    
    
    [self.view addSubview:_segment];
    
    
    
    
}


//创建tableview
-(void)_createTableView
{
    
    //创建正在热映的表视图
    _tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight-64-40-49) style:UITableViewStylePlain];
    
    _tableView1.delegate = self;
    
    _tableView1.dataSource = self;
    
    _tableView1.backgroundColor = [UIColor clearColor];
    
    _tableView1.separatorColor = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:_tableView1];
    
    //创建即将上映的表视图
    
    _tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 40, kScreenWidth, kScreenHeight-64-40-49) style:UITableViewStylePlain];
    
    _tableView2.dataSource = self;
    
    _tableView2.delegate = self;
    
    _tableView2.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView2];
    
    //创建正在上映的头视图
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, _tableView2.frame.size.width, 180)];
    
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 30)];
    
    label.text = @"最受关注";
    
    label.font = [UIFont boldSystemFontOfSize:20];
    
    label.textColor = [UIColor whiteColor];
    
    [headerView addSubview:label];
    
    
    //创建collectionview
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(kScreenWidth-10, 150);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, 150) collectionViewLayout:layout];
    
    _collectionView.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:_collectionView];
    
    _collectionView.delegate = self;
    
    _collectionView.dataSource = self;
    
    //注册单元格
    
    [_collectionView registerNib:[UINib nibWithNibName:@"TopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"attention_cell"];
    
    _collectionView.pagingEnabled = YES;
    
    _tableView2.tableHeaderView = headerView;
    
    
    
}


-(void)_loadData

{
    //获取第一个的数据
    
    if (_datalist1 == nil)
    {
        _datalist1 = [[NSMutableArray alloc]init];
        
    }
    
    
    NSDictionary *hotDic = [JsonParser jsonFromFileName:@"buy_now"];
    
    NSArray *hotArray = [hotDic objectForKey:@"ms"];
    
    for (NSDictionary *dic in hotArray) {
        
        HotModel *model1 = [[HotModel alloc]initWithDic:dic];
        
        [_datalist1 addObject:model1];
        
    }
    
    /*----------------获取第二个数据----------------------------------*/
    
    
    if (_datalist2 == nil)
    {
        _datalist2 = [[NSMutableArray alloc]init];
        
    }
    
    
    NSDictionary *comingDic = [JsonParser jsonFromFileName:@"buy_new"];
    
    NSArray *comingArray = [comingDic objectForKey:@"moviecomings"];
    
    NSArray *attentionArray = [comingDic objectForKey:@"attention"];
    
    _datalist3 = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in attentionArray)
    {
        AttentionModel *model = [[AttentionModel alloc]initWithDic:dic];
        
        [_datalist3 addObject:model];
    }
    
    
    for (NSDictionary *dic in comingArray) {
        
        ComingModel *model = [[ComingModel alloc]initWithDic:dic];
        
        NSString *rMonth = [NSString stringWithFormat:@"%@",model.rMonth];
        
        
        [_datalist2 addObject:model];
        
        
    }
    
    
    
    
    
//    _datalist2 = [[NSMutableArray alloc]init];
//    
//    NSDictionary *newDic=[JsonParser jsonFromFileName:@"buy_new"];
//    
//    NSArray *attentionArray = [newDic objectForKey:@"attention"];
//    
//    
//    for (NSDictionary *dic in attentionArray) {
//        
//        AttentionModel *model=[[AttentionModel alloc]initWithDic:dic];
//        
//        [_datalist_h addObject:model];
//    }
//    
//    NSArray *moviecomings=[newDic objectForKey:@"moviecomings"];
//    
//    for (NSDictionary *dic in moviecomings) {
//        
//        ComingModel *model=[[ComingModel alloc]initWithDic:dic];
//        
//        NSString *rMonth=[NSString stringWithFormat:@"%@",model.rMonth];
//        
//        NSMutableArray *days=[_dataDic2 objectForKey:rMonth];
//        
//        if (days==nil) {
//            
//            days=[[NSMutableArray alloc]init];
//            
//            [days addObject:model];
//            
//            [_dataDic2 setObject:days forKey:rMonth];
//            
//            
//        }else{
//            
//            [days addObject:model];
//            
//        }
//        
//    }
//    
//    _allKeys=[_dataDic2 allKeys];
//    NSLog(@"%@",_allKeys);

    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createSegment];
    
    [self _loadData];
    
    [self _createTableView];
    
    
}


#pragma mark-----UITableViewDataSource

//返回单元格的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == _tableView1)
    {
        return _datalist1.count;
    }
    
    
    else if(tableView == _tableView2)
    {
        
        
        return _datalist2.count;
    }
    
    return 0;
    
}


//返回每个单元格的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView  == _tableView1)
    {
        
        static NSString *identifier = @"hot_cell";
        
        HotViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"HotViewCell" owner:self options:nil]lastObject];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
        }
        
        HotModel *hotmodel = _datalist1[indexPath.row];
        
        cell.model = hotmodel;
        
        return cell;
        
    }
    /*-------------------------创建第二个单元格---------------------*/
    
    if (tableView == _tableView2)
        
    {
        static NSString *identifer = @"coming_cell";
        
        ComingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ComingViewCell" owner:self options:nil]lastObject];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor clearColor];
        }
        
        ComingModel *model = _datalist2[indexPath.row];
        
        cell.comingModel = model;
        
//        NSArray *days=[_dataDic objectForKey:_allkeys[indexPath.section]];
//        
//        ComingModel *model = days[indexPath.row];
//        
//        cell.comingModel=model;
        
        return cell;
    }
    
    return nil;
}

#pragma mark-----UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (tableView ==_tableView1)
    {
        return 150;
    }
    
    return 150;
}


//返回头视图高度

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
    
    imageV.image = [UIImage imageNamed:@"ico_index_title_1"];
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
    
    [imageV addSubview:label];
    
    //label.text = [NSString stringWithFormat:@"   %@月",_allkeys [section]];
    
    label.textColor = [UIColor whiteColor];
    
    label.font = [UIFont boldSystemFontOfSize:20];
    
    label.backgroundColor = [UIColor clearColor];
    
    return imageV;

    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    if (tableView ==_tableView2)
        
    {
        return 25;
    }
    
    return 0;
}


#pragma mark----UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _datalist3.count;
    
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    TopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"attention_cell"forIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TopCollectionViewCell" owner:self options:nil]lastObject];
        
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    AttentionModel *model = _datalist3[indexPath.item];
    
    cell.model = model;
    
    return cell;
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 10);
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



@end
