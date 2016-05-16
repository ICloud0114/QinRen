//
//  BookingServiceViewController.m
//  QinRen
//
//  Created by Donny2g Hu on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "BookingServiceViewController.h"
#import "EAHttpAPIClient.h"
#import "JSONKit.h"
#import "DataParser.h"
#import "ServiceCell.h"
#import "MGSwipeButton.h"
#import "SVProgressHUD.h"
#import "BookingViewModel.h"
#import "MJRefresh.h"

@interface BookingServiceViewController ()<MGSwipeTableCellDelegate,BookingViewControllerDelegate>
{
    NSUInteger pageIndex;
    BOOL modify;
    NSMutableDictionary *pageDictionary;
}
@property (weak, nonatomic) IBOutlet UIImageView *noneImageView;
@property (weak, nonatomic) IBOutlet UILabel *noneLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (nonatomic) BookingType type;

@property (nonatomic, strong) NSMutableArray *dataArray1;
@property (nonatomic, strong) NSMutableArray *dataArray2;
@property (nonatomic, strong) NSMutableArray *dataArray3;


@end

@implementation BookingServiceViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                                                   nil];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:13], NSFontAttributeName,
                                [UIColor colorWithRed:115/255.0 green:115/255.0 blue:115/255.0 alpha:1], NSForegroundColorAttributeName,
                                nil];
    [self.segment setTitleTextAttributes:attributes forState:UIControlStateNormal];

    NSDictionary *attributes1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:13], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName,
                                nil];
    [self.segment setTitleTextAttributes:attributes1 forState:UIControlStateSelected];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
 
    self.noneImageView.hidden = YES;
    self.noneLabel.hidden = YES;
//    self.segment.hidden = YES;
//    self.tableView.hidden = YES;
    //01
    self.type = BookingType1;
    
    pageIndex = 1;
    self.dataArray1 = [NSMutableArray array];
    self.dataArray2 = [NSMutableArray array];
    self.dataArray3 = [NSMutableArray array];
    pageDictionary = [NSMutableDictionary dictionary];
    
    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:1] forKey:[NSString stringWithFormat:@"%ld",(long)BookingType1]];
    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:1] forKey:[NSString stringWithFormat:@"%ld",(long)BookingType2]];
    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:1] forKey:[NSString stringWithFormat:@"%ld",(long)BookingType3]];

    [self.tableView addHeaderWithTarget:self action:@selector(headrequestForServices)];
    [self.tableView headerBeginRefreshing];
}

- (void)showResultUI
{
    self.noneImageView.hidden = YES;
    self.noneLabel.hidden = YES;
    self.segment.hidden = NO;
    self.tableView.hidden = NO;
}

- (void)showNoReslutUI
{
    self.noneImageView.hidden = NO;
    self.noneLabel.hidden = NO;
    self.segment.hidden = YES;
    self.tableView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    modify = NO;

}



#pragma mark -
#pragma mark - Actions
- (IBAction)bookingService:(id)sender
{
    [self performSegueWithIdentifier:@"Booking" sender:self];
}

- (IBAction)segmentValueChange:(id)sender
{
    if (self.segment.selectedSegmentIndex == 0) {
        self.type = BookingType1;
        if (self.dataArray1.count <= 0) {
            [self.tableView headerBeginRefreshing];
        }else
        {
            [self.tableView reloadData];
        }
    }else if (self.segment.selectedSegmentIndex == 1) {
        self.type = BookingType2;
        if (self.dataArray2.count <= 0) {
            [self.tableView headerBeginRefreshing];
        }else
        {
            [self.tableView reloadData];
        }
    }else if (self.segment.selectedSegmentIndex == 2) {
        self.type = BookingType3;
        if (self.dataArray3.count <= 0) {
            [self.tableView headerBeginRefreshing];
        }else
        {
            [self.tableView reloadData];
        }
    }
}


#pragma mark -
#pragma mark - 请求
- (void)headrequestForServices
{
    
    pageIndex = 1;
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user = [User sharedUser];
 
    NSDictionary *parameters = @{@"isuse":@"0",/*@"name":user.uid,*/@"sn":@"",@"pagesize":@"10",@"pageindex":[NSString stringWithFormat:@"%ld",(unsigned long)pageIndex],@"stype":[NSString stringWithFormat:@"%ld",self.type]};
    
    [manager GetWithParameters:parameters method:@"get.fitness.subscribe" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        if ([responseObject isKindOfClass:[NSData class]]) {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
      //  NSLog(@"dictonary :%@",[dictionary description]);
        
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            if ([[dictionary objectForKey:@"total"]intValue] <= 0)
            {
//                [self showNoReslutUI];
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD dismiss];
                
                [self.tableView reloadData];
            }else
            {
//                [self showResultUI];
                switch (self.type) {
                    case 1:
                        [self.dataArray1 removeAllObjects];
                        break;
                    case 2:
                        [self.dataArray2 removeAllObjects];
                        break;
                    case 3:
                        [self.dataArray3 removeAllObjects];
                        break;
                    default:
                        break;
                }

                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                    pageIndex ++;
                    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:pageIndex] forKey:[NSString stringWithFormat:@"%ld",self.type]];
                    [self.tableView addFooterWithTarget:self action:@selector(footerRequestForService)];
                }
                switch (self.type) {
                    case 1:
                        [self.dataArray1 addObjectsFromArray:[dictionary objectForKey:@"data"]];
                        NSLog(@"self.dataArray1====%@",self.dataArray1);
                        break;
                    case 2:
                        [self.dataArray2 addObjectsFromArray:[dictionary objectForKey:@"data"]];
                        NSLog(@"self.dataArray2===%2",self.dataArray2);
                        break;
                    case 3:
                        [self.dataArray3 addObjectsFromArray:[dictionary objectForKey:@"data"]];
                        NSLog(@"self.dataArray3===%2",self.dataArray3);
                        break;
                    default:
                        break;
                }
                
                [self.tableView reloadData];
            }
            [self.tableView headerEndRefreshing];

        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            [self.tableView headerEndRefreshing];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [self.tableView headerEndRefreshing];

    }];
}


- (void)footerRequestForService
{
    
    for (NSString *number in pageDictionary.allKeys) {
        if ([number integerValue] == self.type)
        {
            pageIndex = [[pageDictionary objectForKey:number]intValue];
        }
    }
    
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user = [User sharedUser];

    NSDictionary *parameters = @{@"isuse":@"0",@"name":user.username,@"sn":@"",@"pagesize":@"10",@"pageindex":[NSString stringWithFormat:@"%ld",(unsigned long)pageIndex]};
    //  get.fitness.subscribe
    [manager GetWithParameters:parameters method:@"get.fitness.subscribe" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        if ([responseObject isKindOfClass:[NSData class]]) {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
        NSLog(@"dictonary :%@",[dictionary description]);
        
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            if ([[dictionary objectForKey:@"total"]intValue] <= 0)
            {
                [self.tableView reloadData];
            }else
            {
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                    pageIndex ++;
                    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:pageIndex] forKey:[NSString stringWithFormat:@"%ld",self.type]];

                 }else
                 {
                     [self.tableView removeFooter];
                 }
                switch (self.type) {
                    case 1:
                        [self.dataArray1 addObjectsFromArray:[dictionary objectForKey:@"data"]];
                        break;
                    case 2:
                        [self.dataArray2 addObjectsFromArray:[dictionary objectForKey:@"data"]];
                        break;
                    case 3:
                        [self.dataArray3 addObjectsFromArray:[dictionary objectForKey:@"data"]];
                        break;
                    default:
                        break;
                }
                [self.tableView reloadData];
                
                
            }
            [self.tableView footerEndRefreshing];

        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            [self.tableView footerEndRefreshing];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self.tableView footerEndRefreshing];

    }];
}

- (void)deleteService:(NSString *)subscribeid indexPath:(NSIndexPath *)indexPath
{
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"Subscribeid":subscribeid};
    // set.fitness.subscribedelete
    [manager GetWithParameters:parameters method:@"get.fitness.subscribedelete" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        if ([responseObject isKindOfClass:[NSData class]]) {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
       // NSLog(@"dictonary :%@",[dictionary description]);
        
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            if ([[dictionary objectForKey:@"total"]intValue] <= 0)
            {
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD showErrorWithStatus:@"取消失败"];
                [self.tableView reloadData];
            }else
            {
                //
                [SVProgressHUD showSuccessWithStatus:@"取消成功"];
                [self.dataArray1 removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
                
            }
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}
#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.type == BookingType1)
    {
        NSLog(@"self.dataArray1.count===%d",self.dataArray1.count);
        return self.dataArray1.count;

    }else if (self.type == BookingType2)
    {
        NSLog(@"self.dataArray2.count===%d",self.dataArray2.count);
        return self.dataArray2.count;

    }else if (self.type == BookingType3)
    {
        NSLog(@"self.dataArray3.count===%d",self.dataArray3.count);
        return self.dataArray3.count;

    }
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"ServiceCell";

    ServiceCell *cell;
    
    cell = [_tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.delegate = self;
    cell.allowsMultipleSwipe = YES;
    
    
    NSDictionary *dictionary;// = [self.dataArray1 objectAtIndex:indexPath.section];
    
    if (self.type == BookingType1)
    {
        dictionary = [self.dataArray1 objectAtIndex:indexPath.section];
    }else if (self.type == BookingType2)
    {
        dictionary = [self.dataArray2 objectAtIndex:indexPath.section];
    }else if (self.type == BookingType3)
    {
        dictionary = [self.dataArray3 objectAtIndex:indexPath.section];
    }
    
    
    cell.nameLabel.text = [dictionary objectForKey:@"bodys"];
    NSString *time = [dictionary objectForKey:@"subscribeTime"];
    time = [BookingViewModel convertToTime:time];
    cell.timeLabel.text = time;
    
    BookingStatus status = [[dictionary objectForKey:@"state"]intValue];;
    NSString * statusstring = [BookingViewModel statusToString:status];
    cell.statusLabel.text = statusstring;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    modify = YES;
    [self performSegueWithIdentifier:@"Booking" sender:self];
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings;
{
    
    if (direction == MGSwipeDirectionLeftToRight) {
        return nil;;
    }
    else {
        expansionSettings.buttonIndex = 0;
        expansionSettings.fillOnTrigger = YES;
        return [self createRightButtons:1];
    }
}

-(NSArray *) createRightButtons: (int) number
{
    NSMutableArray * result = [NSMutableArray array];
    NSString* titles[1] = {@"取消"};
    UIColor * colors[1] = {[UIColor redColor]};
    for (int i = 0; i < number; ++i)
    {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * sender){
            NSLog(@"Convenience callback received (right).");
            BOOL autoHide = i != 0;
            return autoHide; //Don't autohide in delete button to improve delete expansion animation
        }];
        [result addObject:button];
    }
    return result;
}


 -(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion
 {
     if (direction == MGSwipeDirectionRightToLeft && index == 0)
     {
         NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
         NSDictionary *dictionary;// = [self.dataArray1 objectAtIndex:indexPath.section];
         
         if (self.type == BookingType1)
         {
             dictionary = [self.dataArray1 objectAtIndex:indexPath.section];
         }else if (self.type == BookingType2)
         {
             dictionary = [self.dataArray2 objectAtIndex:indexPath.section];
         }else if (self.type == BookingType3)
         {
             dictionary = [self.dataArray3 objectAtIndex:indexPath.section];
         }
         
         NSString *subscribeid = [dictionary objectForKey:@"subscribeid"];
         
         [self deleteService:subscribeid indexPath:indexPath];
         
         return NO;
     }
     return YES;
 
}
 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"Booking"]) {
        BookingViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        if (modify) {
            NSIndexPath *indexPath = [self.tableView  indexPathForSelectedRow];
        
            NSDictionary *dictionary;// = [self.dataArray1 objectAtIndex:indexPath.section];
            
            if (self.type == BookingType1)
            {
                dictionary = [self.dataArray1 objectAtIndex:indexPath.section];
            }else if (self.type == BookingType2)
            {
                dictionary = [self.dataArray2 objectAtIndex:indexPath.section];
            }else if (self.type == BookingType3)
            {
                dictionary = [self.dataArray3 objectAtIndex:indexPath.section];
            }
            
            controller.modify = YES;
            controller.dictionary = dictionary;
        }
        controller.type = self.type;

    }
    
}


- (void)bookingViewControllerDidFinishAdd:(BookingViewController *)controller
{
    [self.tableView headerBeginRefreshing];
}
@end
