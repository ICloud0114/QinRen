//
//  XueYaController.m
//  QinRen
//
//  Created by Easaa on 15/4/7.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "XueYaController.h"
#import "XueyaCell.h"

@interface XueYaController ()

@end

@implementation XueYaController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    
     self.tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    if (_dataArr.count ==0)
    //    {
    //        return 0;
    //    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //  QRModelGetClient *get = _dataArr[indexPath.row];
    // TESTUser *test = get.data;
    //    if(indexPath.row==0)
    //    {
    //
    XueyaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XueyaCell"forIndexPath:indexPath];
    //
    //        [cell updateGoodsCellUiWithAttributes:self.dataArr[indexPath.row]];
    //
    //        return cell;
    //    }
    //    else
    //    {
    //        PraseCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PraseCell" forIndexPath:indexPath];
    //        return cell;
    //    }
    
    // [cell updateGoodsCellUiWithAttributes:_dataArr[indexPath.row]];
    
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
