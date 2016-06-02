//
//  HomeViewController.m
//  PRODUCT
//
//  Created by BEVER on 16/3/21.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "HomeModel.h"
#import "CityListViewController.h"
#import "PosterView.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *datalist;

@property (nonatomic,strong)PosterView *posterView;


@end

@implementation HomeViewController

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.title = @"主页";
        
        self.tabBarItem.image = [UIImage imageNamed:@"index_menu_home.png"];
        
        self.tabBarItem.title = nil;
        
        
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _loadNavigationBar];
    
    [self loadData];
    
    [self _createSubviews];
    
    
    
}

- (void)loadData{
    
    /*————————————————————————————————————————————————————————————————————————*/
    
    if (_datalist == nil) {
        
        _datalist = [[NSMutableArray alloc]init];
    }
    
    //3.从数据中读取字典或者数组
    NSDictionary *homeDic = [JsonParser jsonFromFileName:@"home_header"];
    
    //    NSLog(@"%@",homeDic);
    
    //4.通过movies键 获取数据列表
    NSArray *dataArr = [homeDic objectForKey:@"movies"];
    
    for (NSDictionary *dic in dataArr) {
        
        HomeModel *model = [[HomeModel alloc]initWithDic:dic];
        
        //        model.titleCn = dic[@"titleCn"];
        //
        //        model.ratingFinal = dic[@"ratingFinal"];
        //
        //        model.img = dic[@"img"];
        
        [_datalist addObject: model];
        
    }
    
    /**
     *  Model的作用:
     
     存储 数据列表中的每一个字典的内容 : 属性名->key 属性值->object
     
     
     *
     */
    
    
}

- (void)_createSubviews{
    
    
    //正面表视图
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    _tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
    
    //反面海报视图
    _posterView = [[PosterView alloc]initWithFrame:self.view.bounds];
    
    _posterView.hidden = YES;
    
    _posterView.datalist = _datalist;
    
    [self.view addSubview:_posterView];
    
}

- (void)_loadNavigationBar{
    
    /*————————— 左侧item ———————————————————————————————————————————————————————————————*/
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:kCurrentCityName]) {
        
        [leftBtn setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:kCurrentCityName] forState:UIControlStateNormal];
        
    }else{
        
        [leftBtn setTitle:@"济南市" forState:UIControlStateNormal];
        
    }
    
    
    [leftBtn addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    /*————————— 右侧item ———————————————————————————————————————————————————————————————*/
    
    
    /**
     点击按钮state: normal -> 点击没松手 -> highLight-> 松手 -> selected -> 点击 -> normal
     */
    UIButton *rightBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    
    rightBtn1.tag = 1001;
    
    [rightBtn1 setImage:[UIImage imageNamed:@"list_home.png"] forState:UIControlStateNormal];
    
    [rightBtn1 addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    
    rightBtn2.tag = 1002;
    
    [rightBtn2 setImage:[UIImage imageNamed:@"poster_home.png"] forState:UIControlStateNormal];
    
    [rightBtn2 addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    rightBtn2.hidden = YES;
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    
    rightView.backgroundColor = [UIColor clearColor];
    
    [rightView addSubview:rightBtn1];
    
    [rightView addSubview:rightBtn2];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    
}

- (void)leftAction:(UIButton *)button{
    
    //    NSLog(@"济南市");
    
    CityListViewController *clvc = [[CityListViewController alloc]init];
    
    //4.block赋值
    [clvc setCityBlock:^(NSString *cityName) {
        
        //6.将参数字符串 显示到导航栏按钮上
        [button setTitle:cityName forState:UIControlStateNormal];
        
    }];
    
    //当控制器被push的时候 隐藏底边标签栏
    clvc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:clvc animated:YES];
    
    
    
}

- (void)rightAction:(UIButton *)button{
    
    
    
    //获取导航栏右侧自定义视图
    UIView *rightView = self.navigationItem.rightBarButtonItem.customView;
    
    if (button.tag == 1001) {
        
        self.navigationController.navigationBar.alpha = 0.5;
        
        button.hidden = YES;
        
        UIButton *btn1002 = [rightView viewWithTag:1002];
        
        btn1002.hidden = NO;
        
        /**
         *      UIViewAnimationTransitionNone,
         UIViewAnimationTransitionFlipFromLeft,
         UIViewAnimationTransitionFlipFromRight,
         UIViewAnimationTransitionCurlUp,
         UIViewAnimationTransitionCurlDown,
         
         */
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:rightView cache:YES];
            
        }];
        
        /*————————————————————————————————————————————————————————————————————————*/
        
        _tableView.hidden = YES;
        
        _posterView.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
            
        }];
        
        
    }else{
        
        self.navigationController.navigationBar.alpha = 1;
        
        button.hidden = YES;
        
        UIButton *btn1001 = [rightView viewWithTag:1001];
        
        btn1001.hidden = NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:rightView cache:YES];
            
        }];
        
        /*————————————————————————————————————————————————————————————————————————*/
        
        _tableView.hidden = NO;
        
        _posterView.hidden = YES;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
            
        }];
        
        
    }
    
    
}

#pragma mark -
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _datalist.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"home_cell";
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        
        //        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HomeCell" owner:self options:nil]lastObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    HomeModel *model = _datalist[indexPath.row];
    
    cell.model = model;
    
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}



@end
