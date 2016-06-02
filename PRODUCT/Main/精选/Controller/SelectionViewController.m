//
//  SelectionViewController.m
//  PRODUCT
//
//  Created by BEVER on 16/3/21.
//  Copyright © 2016年 李楠. All rights reserved.
//

#import "SelectionViewController.h"

@interface SelectionViewController ()

@end

@implementation SelectionViewController

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.title = @"时光精选";
        
        self.tabBarItem.image = [UIImage imageNamed:@"index_menu_top.png"];
        
        self.tabBarItem.title = nil;
        
        
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
