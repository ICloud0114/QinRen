//
//  EAOrderDetailViewController.m
//  QinRen
//
//  Created by LoveLi1y on 15/4/21.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "EAOrderDetailViewController.h"

@interface EAOrderDetailViewController ()

@end

@implementation EAOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
            return 54;
            break;
        case 1:
            return 81;
            break;
        case 2:
            return 128;
            break;
        case 3:
            return 46;
            break;
        default:
            return 0.1;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section)
    {
        case 0:
        {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"about" forIndexPath:indexPath];
            
            
            return cell;
        }
            break;
            
        case 1:
        {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"address" forIndexPath:indexPath];
            
            
            return cell;
        }
            break;
            
        case 2:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list" forIndexPath:indexPath];
            
            
            return cell;
        }
            break;
            
        case 3:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"price" forIndexPath:indexPath];
            
            
            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }
    
    
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
