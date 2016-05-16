//
//  DailyMissionViewController.h
//  QinRen
//
//  Created by Donny2g Hu on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyMissionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSString *titleLab;

@end
