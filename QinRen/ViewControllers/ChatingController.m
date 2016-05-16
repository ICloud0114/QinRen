//
//  ChatingController.m
//  QinRen
//
//  Created by Easaa on 15/4/17.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "ChatingController.h"
#import "MessageCell.h"
#import "MessageFrameModel.h"
#import "MessageModel.h"

@interface ChatingController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *MytableView;
@property (nonatomic,strong)NSMutableArray *allMessagesFrame;
- (IBAction)StarVoiceBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *Textfiled;
@property (weak, nonatomic) IBOutlet UIButton *speakBtn;
@property (weak, nonatomic) IBOutlet UIButton *AddPic;

- (IBAction)SmeilBtn:(id)sender;

- (IBAction)VoiceBtn:(id)sender;

- (IBAction)AddBtn:(id)sender;

- (IBAction)SendBtn:(id)sender;

@end

@implementation ChatingController

- (void)viewDidLoad {
    [super viewDidLoad];
    _MytableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _MytableView.allowsSelection=NO;
    _MytableView.backgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
    
    NSArray *array= [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist1"]];
    _allMessagesFrame=[[NSMutableArray alloc]init];
    NSString *previousTime=nil;
    for(NSDictionary *dic in array)
    {
        MessageFrameModel *messageFrame=[[MessageFrameModel alloc]init];
        MessageModel *message=[[MessageModel alloc]init];
        message.dict=dic;
        
        messageFrame.showTime=![previousTime isEqualToString:message.time];
        messageFrame.message=message;
        previousTime=message.time;
        [_allMessagesFrame addObject:messageFrame];

    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //设置textField输入起始位置
    _Textfiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    _Textfiled.leftViewMode = UITextFieldViewModeAlways;
    
    _Textfiled.delegate = self;
    
    
    
    
}

#pragma mark - 键盘处理
#pragma mark 键盘即将显示
//- (void)keyBoardWillShow:(NSNotification *)note{
//
//}
//#pragma mark 键盘即将退出
//- (void)keyBoardWillHide:(NSNotification *)note{
//
//}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    
//    // 1、增加数据源
//    NSString *content = textField.text;
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    NSDate *date = [NSDate date];
//    fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
//    NSString *time = [fmt stringFromDate:date];
//    [self addMessageWithContent:content time:time];
//    // 2、刷新表格
//    [self.MytableView reloadData];
//    // 3、滚动至当前行
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
//    [self.MytableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    // 4、清空文本框内容
//    _Textfiled.text = nil;
//    return YES;
//}

#pragma mark 给数据源增加内容
- (void)addMessageWithContent:(NSString *)content time:(NSString *)time{
    
    MessageFrameModel *mf = [[MessageFrameModel alloc] init];
    MessageModel *msg = [[MessageModel alloc] init];
    msg.content = content;
    msg.time = time;
    msg.icon = @"1-1.jpg";
    msg.type = MessageTypeMe;
    mf.message = msg;
    
    [_allMessagesFrame addObject:mf];
}
- (IBAction)StarVoiceBtn:(id)sender {
    
    
}

- (IBAction)TextFiledBtn:(id)sender {
}

- (IBAction)SmeilBtn:(id)sender {
}

- (IBAction)VoiceBtn:(id)sender {
       
    if (_Textfiled.hidden) { //输入框隐藏，按住说话按钮显示
        _Textfiled.hidden = NO;
        _speakBtn.hidden = YES;
        [sender setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_nor.png"] forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_press.png"] forState:UIControlStateSelected];
        [_Textfiled becomeFirstResponder];
    }else{ //输入框处于显示状态，按住说话按钮处于隐藏状态
        _Textfiled.hidden = YES;
        _speakBtn.hidden = NO;
        [sender setBackgroundImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor.png"] forState:UIControlStateNormal];
        [sender setBackgroundImage:[UIImage imageNamed:@"chat_bottom_keyboard_press.png"] forState:UIControlStateSelected];
        [_Textfiled resignFirstResponder];
    }

}

- (IBAction)AddBtn:(id)sender {
    
    [_AddPic setFrame:CGRectMake(0, 0, 320, 218)];


}

- (IBAction)SendBtn:(id)sender {
    
    _Textfiled.text=sender;

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark - tableView数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allMessagesFrame.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
//    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (cell == nil) {
//        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    // 设置数据
//    cell.messageFrame = _allMessagesFrame[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_allMessagesFrame[indexPath.row] CellHeight];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
@end
