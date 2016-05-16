//
//  MallViewController.m
//  QinRen
//
//  Created by Donny on 15/2/28.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "MallViewController.h"
#import "MJRefresh.h"
#import "UIViewAdditions.h"
#import "EAHttpAPIClient.h"
#import "JSONKit.h"
#import "DataParser.h"
#import "GoodsCell.h"

@interface MallViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *allButton;
@property (strong, nonatomic) IBOutlet UIButton *promotionsButton;
@property (strong, nonatomic) IBOutlet UIButton *matchButton;
@property (strong, nonatomic) IBOutlet UITableView *allTableView;
@property (strong, nonatomic) IBOutlet UITableView *promotionsTableView;
@property (strong, nonatomic) IBOutlet UITableView *MatchTableView;
@property (strong, nonatomic) IBOutlet UIView *moveView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *moveViewLeft;

@end

@implementation MallViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                                                   nil];
 
}


#pragma mark - 
#pragma mark - 按钮事件
- (IBAction)allButtonAction:(id)sender
{
    self.moveViewLeft.constant = -16;
}

- (IBAction)promotionButtonAction:(id)sender
{
    self.moveViewLeft.constant = -16 + self.promotionsButton.width;
}

- (IBAction)matchButton:(id)sender
{
    self.moveViewLeft.constant = -16 + self.matchButton.width * 2;

}

#pragma mark - 
#pragma mark - Table DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
