//
//  HealthDetectViewController.h
//  QinRen
//
//  Created by Donny on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthDetectViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableview1;
@property (strong, nonatomic) IBOutlet UIImageView *noneImageView;
@property (strong, nonatomic) IBOutlet UILabel *noneLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)SpideSumBtn:(id)sender;
- (IBAction)paobuSumBtn:(id)sender;
- (IBAction)TotalSumBtn:(id)sender;

@end
