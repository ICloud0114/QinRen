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
@property (strong, nonatomic) IBOutlet UIImageView *noneImageView;
@property (strong, nonatomic) IBOutlet UILabel *noneLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;

@end
