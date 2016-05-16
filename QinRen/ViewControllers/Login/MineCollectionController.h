//
//  MineCollectionController.h
//  QinRen
//
//  Created by Easaa on 15/4/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCollectionController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *CollectionBtn;
@property (weak, nonatomic) IBOutlet UIButton *CollectNewBtn;
@property (weak, nonatomic) IBOutlet UITableView *CollectTableview;
- (IBAction)CollectAction:(id)sender;

- (IBAction)CollectNewAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *CollectNewTableView;

@end
