//
//  EANewSiteViewController.m
//  QinRen
//
//  Created by LoveLi1y on 15/4/23.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "EANewSiteViewController.h"


#import <CoreText/CoreText.h>

@interface EANewSiteViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

{
    NSString *provinceId;
    NSString *cityId;
    NSString *areaId;
    
    NSString *province;
    NSString *city;
    NSString *area;
    
    UIPickerView *picker;
    
    NSMutableArray *firstArray;
    NSMutableArray *secondArray;
    NSMutableArray *thirdArray;
    
     BOOL        isCityChanged;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *siteTextField;
@property (weak, nonatomic) IBOutlet UITextField *detailTextField;


@end

@implementation EANewSiteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isCityChanged = NO;
    firstArray = [NSMutableArray array];
    secondArray = [NSMutableArray array];
    thirdArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    
    
    picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - 200 - INCREMENT - NAVHEIGHT, SCREENWIDTH, 200)];
//                picker.backgroundColor = [UIColor redColor];
    picker.delegate = self;
    picker.dataSource = self;
    UIToolbar *tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [selectButton setFrame:CGRectMake(SCREENWIDTH - 44, 0, 44, 30)];
    [selectButton setTitle:@"确定" forState:UIControlStateNormal];
    [selectButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(selectCityAction:) forControlEvents:UIControlEventTouchUpInside];
    [tool addSubview:selectButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [cancelButton setFrame:CGRectMake(0, 0, 44, 30)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [tool addSubview:cancelButton];
    
    self.siteTextField.inputView = picker;
    self.siteTextField.inputAccessoryView = tool;
    
    [self getProvinceData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectCityAction:(id)sender
{
        [self.detailTextField resignFirstResponder];
        [self.nameTextField resignFirstResponder];
        [self.phoneTextField resignFirstResponder];
    
    [self.siteTextField endEditing:YES];
    self.siteTextField.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
    
}
- (void)cancelSelectAction:(id)sender
{
//    if (self.editDictionary)
//    {
//        self.provinceid = [self.editDictionary objectForKey:@"provinceid"];
//        self.cityid = [self.editDictionary objectForKey:@"cityid"];
//        self.countryid = [self.editDictionary objectForKey:@"countyid"];
//    }
    
    [self.siteTextField endEditing:YES];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return firstArray.count;
    }
    else if(component == 1)
    {
        return secondArray.count;
    }
    else
    {
        return thirdArray.count;
    }
}
//所少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
//每列的宽度
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return SCREENWIDTH / 3.0f;
}
//每列的高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 25;
}

//-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    
//    switch (component)
//    {
//        case 0:
//            if (firstArray.count > 0)
//            {
//                return  [firstArray objectAtIndex:row][@"name"];
//            }
//            else
//            {
//                return  @"";
//            }
//            break;
//        case 1:
//            if (secondArray.count > 0)
//            {
//                return [secondArray objectAtIndex:row][@"name"];
//            }
//            else
//            {
//                return @"";
//            }
//            break;
//        case 2:
//            if (thirdArray.count > 0)
//            {
//                return [thirdArray objectAtIndex:row][@"name"];
//            }
//            else
//            {
//                return @"";
//            }
//            break;
//        default:
//            return @"";
//            break;
//    }
//    
//}

//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0)
//{
//
//    NSMutableAttributedString *attriString = nil;
//    
//    switch (component)
//    {
//        case 0:
//            if (firstArray.count > 0)
//            {
////                return  [firstArray objectAtIndex:row][@"name"];
//               attriString = [[NSMutableAttributedString alloc] initWithString:[firstArray objectAtIndex:row][@"name"]];
//               
//            }
//            else
//            {
//                return  attriString;
//            }
//            break;
//        case 1:
//            if (secondArray.count > 0)
//            {
////                return [secondArray objectAtIndex:row][@"name"];
//                attriString = [[NSMutableAttributedString alloc] initWithString:[secondArray objectAtIndex:row][@"name"]];
//            }
//            else
//            {
//                return attriString;
//            }
//            break;
//        case 2:
//            if (thirdArray.count > 0)
//            {
////                return [thirdArray objectAtIndex:row][@"name"];
//                attriString = [[NSMutableAttributedString alloc] initWithString:[thirdArray objectAtIndex:row][@"name"]];
//            }
//            else
//            {
//                return attriString;
//            }
//            break;
//        default:
//            return attriString;
//            break;
//    }
//    
//    [attriString addAttribute:(NSString *)kCTFontAttributeName
//                        value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)[UIFont boldSystemFontOfSize:10].fontName,10,NULL))range:NSMakeRange(0, [attriString length])];
//    return attriString;
//}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, SCREENWIDTH / 3.0f, 25)];
    myLabel.font = [UIFont systemFontOfSize:15];
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.backgroundColor = [UIColor lightGrayColor];
    switch (component)
    {
        case 0:
            if (firstArray.count > 0)
            {
                myLabel.text=  [firstArray objectAtIndex:row][@"name"];
            }
            else
            {
                myLabel.text=   @"";
            }
            break;
        case 1:
            if (secondArray.count > 0)
            {
                myLabel.text=  [secondArray objectAtIndex:row][@"name"];
            }
            else
            {
                myLabel.text=  @"";
            }
            break;
        case 2:
            if (thirdArray.count > 0)
            {
                myLabel.text=  [thirdArray objectAtIndex:row][@"name"];
            }
            else
            {
                myLabel.text=  @"";
            }
            break;
        default:
            myLabel.text=  @"";
            break;
    }
    
    return myLabel;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (component)
    {
        case 0:
            if (firstArray.count > 0)
            {
                //                [self getCityDataWith:[firstArray objectAtIndex:row][@"id"] andTpye:@"1"];
                [NSThread detachNewThreadSelector:@selector(getCityDataByProvinceID:) toTarget:self withObject:[firstArray objectAtIndex:row][@"id"]];
                province = firstArray[row][@"name"];
                provinceId = firstArray[row][@"id"];
                
                //                [pickerView selectRow:0 inComponent:1 animated:YES];
                //                [pickerView selectRow:0 inComponent:2 animated:YES];
            }
            
            break;
        case 1:
            if (secondArray.count > 0)
            {
                
                [NSThread detachNewThreadSelector:@selector(getCountryDataByCityID:) toTarget:self withObject:[secondArray objectAtIndex:row][@"id"]];
                city = secondArray[row][@"name"];
                cityId = secondArray[row][@"id"];
                //                [pickerView selectRow:0 inComponent:2 animated:YES];
                
            }
            NSLog(@"选中--%@ %@ %@",province,city,area);
            break;
        case 2:
            if (thirdArray.count == 0)
            {
                area = @"";
            }
            else
            {
                area = [thirdArray[row] objectForKey:@"name"];
                areaId = [thirdArray[row] objectForKey:@"id"];
            }
            NSLog(@"选中--%@ %@ %@",province,city,area);
            break;
            
        default:
            break;
    }
}


#pragma mark 获取 省 市 县
- (void)getProvinceData
{

    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"act":@"0"};
    
    [manager GetWithParameters:parameters method:@"get.area.list" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            if ([dictionary[@"data"] isKindOfClass:[NSArray class]])
            {
                
                [firstArray setArray:[dictionary objectForKey:@"data"]];
                province = firstArray [0][@"name"];
                provinceId = firstArray [0][@"id"];
                [NSThread detachNewThreadSelector:@selector(getCityDataByProvinceID:) toTarget:self
                                       withObject:[firstArray objectAtIndex:0][@"id"]];
                
            }
            
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            province = @"";
            provinceId = @"";
            city = @"";
            cityId = @"";
            area = @"";
            areaId = @"";
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        province = @"";
        provinceId = @"";
        city = @"";
        cityId = @"";
        area = @"";
        areaId = @"";
        
        
    }];
}

- (void)getCityDataByProvinceID:(NSString *)ProvinceId
{
    
    
    if ([secondArray count])
    {
        [secondArray removeAllObjects];
    }
    if ([thirdArray count])
    {
        [thirdArray removeAllObjects];
    }

    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                ProvinceId,@"hid"
                                ,@"1",@"act"
                                , nil];
    
    [manager GetWithParameters:parameters method:@"get.area.list" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            if ([dictionary[@"data"] isKindOfClass:[NSArray class]])
            {
                
                [secondArray setArray:[dictionary objectForKey:@"data"]];
                city = secondArray [0][@"name"];
                cityId = secondArray [0][@"id"];
                

                [NSThread detachNewThreadSelector:@selector(getCountryDataByCityID:) toTarget:self
                                       withObject:[secondArray objectAtIndex:0][@"id"]];

            }
            
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            city = @"";
            cityId = @"";
            area = @"";
            areaId = @"";
            
        }
        [picker reloadAllComponents];
        [picker selectRow:0 inComponent:1 animated:YES];
        [picker selectRow:0 inComponent:2 animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        city = @"";
        cityId = @"";
        area = @"";
        areaId = @"";
        [picker reloadAllComponents];
        [picker selectRow:0 inComponent:1 animated:YES];
        [picker selectRow:0 inComponent:2 animated:YES];
        
        
    }];
    
    
}

- (void)getCountryDataByCityID:(NSString *)CityId
{
    
    if ([thirdArray count])
    {
        [thirdArray removeAllObjects];
    }
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters =[[NSDictionary alloc] initWithObjectsAndKeys:
                               CityId,@"hid"
                               ,@"2",@"act"
                               , nil];
    
    [manager GetWithParameters:parameters method:@"get.area.list" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            if ([dictionary[@"data"] isKindOfClass:[NSArray class]])
            {
                [thirdArray setArray:[dictionary objectForKey:@"data"]];
                if ([thirdArray count])
                {
                    area = thirdArray [0][@"name"];
                    areaId = thirdArray[0][@"id"];
                }
                else
                {
                    area = @"";
                    areaId = @"";
                }
                

            }
            
            
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            area = @"";
            areaId = @"";
            
        }
        [picker reloadAllComponents];
        [picker selectRow:0 inComponent:2 animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        area = @"";
        areaId = @"";
        [picker reloadAllComponents];
        [picker selectRow:0 inComponent:2 animated:YES];
        
    }];
    
}

#pragma mark - 验证手机号码
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1(([0-9])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    //    NSString *strRex = @"^((13[0-9])|(15[^4,//D])|(18[0,5-9]))//d{8}$";
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strRex];
    //    if ([predicate evaluateWithObject:mobileNum])
    //    {
    //        return YES;
    //    }
    //    return NO;
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.siteTextField)
    {
        isCityChanged = YES;
    }
    
}
- (IBAction)saveAddressAction:(id)sender
{
    if (self.siteTextField.text.length == 0|| self.nameTextField.text.length == 0 || self.phoneTextField.text.length == 0|| self.codeTextField.text.length == 0 )
    {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提醒" message:@"请填写完整的信息！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
        [SVProgressHUD showErrorWithStatus:@"请填写完整信息"];

        return;
    }
    
    if (![self isMobileNumber:self.phoneTextField.text])
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提醒" message:@"请输入正确的手机号！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
         [SVProgressHUD showErrorWithStatus:@"手机格式错误"];
        
        return;
    }
    
    User *user = [User sharedUser];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          user.uid,@"uid",
                          provinceId,@"provinceid" ,
                          cityId,@"cityid",
                          self.detailTextField.text,@"address",
                          self.phoneTextField.text,@"mobilephone",
                          self.nameTextField.text,@"realname",
                          self.codeTextField.text,@"zipcode",
                          @"1",@"iddefault",
                          areaId,@"countyid",
                          nil];
    //    [self setUserAddress:dict];
    [self performSelector:@selector(setUserAddress:) withObject:dict afterDelay:0.1f];
    
}

- (void)setUserAddress:(NSDictionary *)sendDictionary
{
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GetWithParameters:sendDictionary method:@"set.user.address" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
        }
        [picker reloadAllComponents];
        [picker selectRow:0 inComponent:2 animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        
    }];
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
