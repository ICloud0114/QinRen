//
//  MyDeviceController.m
//  QinRen
//
//  Created by Easaa on 15/4/7.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "MyDeviceController.h"
#import "XueyaCell.h"

@interface MyDeviceController ()

@end

@implementation MyDeviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    XueyaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"forIndexPath:indexPath];
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


@end
