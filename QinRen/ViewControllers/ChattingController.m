//
//  ChattingController.m
//  QinRen
//
//  Created by Easaa on 15/4/22.
//  Copyright (c) 2015年 Donny. All rights reserved.
//
#define height_Top   44
#define height_Toolbar   49
#define height_table JX_SCREEN_HEIGHT-height_Toolbar-height_Top-20

#import "ChattingController.h"
#import "JXSelectImageView.h"
//#import "JXUserObject.h"
#import "AppDelegate.h"

@interface ChattingController ()<UITextFieldDelegate,WCShareMoreDelegate>

@end

@implementation ChattingController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pool = [[NSMutableArray alloc]init];
         _array = [[NSMutableArray alloc]init];
        self.heightHeader = 44;
        self.heightFooter = 44;
        [self createHeadAndFoot];
        
        
        
        _table.backgroundColor = [UIColor whiteColor];
        _table.separatorStyle  = UITableViewCellSeparatorStyleNone;
        
//        _myHeadImage   = [UIImage imageNamed:[JXUserObject getHeadImage:[[NSUserDefaults standardUserDefaults]objectForKey:kMY_USER_ID]]];
//        _userHeadImage = [UIImage imageNamed:[JXUserObject getHeadImage:_chatPerson.userId]];
        
        //+选择图片调用的类
        _shareMoreView =[[JXSelectImageView alloc]init];
        [_shareMoreView setFrame:CGRectMake(0, 0, 320, 218)];
  
        
        [_shareMoreView setDelegate:self];
        [self initAudio];
        
        inputBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ToolViewBkg_Black.png"]];
//              inputBar.frame = CGRectMake(0, JX_SCREEN_HEIGHT-44-44, WIDTH, 44);
         inputBar.frame = CGRectMake(0, 0, WIDTH, 44);

        inputBar.userInteractionEnabled = YES;
        inputBar.backgroundColor=[UIColor redColor];

        [self.tableFooter addSubview:inputBar];
      
        
        messageText = [[UITextField alloc] initWithFrame:CGRectMake(45, 7, WIDTH-120, 30)];

        messageText.delegate = self;
        messageText.autocorrectionType = UITextAutocorrectionTypeNo;
      messageText.autocapitalizationType = UITextAutocapitalizationTypeNone;
        messageText.enablesReturnKeyAutomatically = YES;
        messageText.borderStyle = UITextBorderStyleRoundedRect;
        messageText.returnKeyType = UIReturnKeySend;
        messageText.clearButtonMode = UITextFieldViewModeWhileEditing;
        [inputBar addSubview:messageText];
       
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(WIDTH-30, 7, 30, 30);
        btn.showsTouchWhenHighlighted = YES;
       [btn setBackgroundImage:[UIImage imageWithContentsOfFile:[[g_App imageFilePath] stringByAppendingPathComponent:@"TypeSelectorBtn_Black.png"]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shareMore:) forControlEvents:UIControlEventTouchUpInside];
        [inputBar addSubview:btn];
        
        btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(45, 7, 205, 30);
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn setTitle:@"按住  说话" forState:UIControlStateNormal];
        [btn setTitle:@"松开  结束" forState:UIControlEventTouchDown];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleShadowOffset:CGSizeMake(1, 1)];
        [inputBar addSubview:btn];
        [btn addTarget:self action:@selector(recordStart:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(recordStop:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(recordCancel:) forControlEvents:UIControlEventTouchUpOutside];
        btn.selected = NO;
        _recordBtn = btn;
        _recordBtn.hidden = YES;
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 7, 30, 30);
        btn.showsTouchWhenHighlighted = YES;
        NSString* s2 = [NSString stringWithFormat:@"%@ToolViewInputVoice.png",[g_App imageFilePath]];
        NSString* s1 = [NSString stringWithFormat:@"%@keyboard_n@2x.png",[g_App imageFilePath]];
        [btn setBackgroundImage:[UIImage imageWithContentsOfFile:s2] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithContentsOfFile:s1] forState:UIControlStateSelected];
        btn.selected = NO;
        [inputBar addSubview:btn];
        [btn addTarget:self action:@selector(recordSwitch:) forControlEvents:UIControlEventTouchUpInside];
        _recordBtnLeft = btn;
        
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(WIDTH-65, 7, 30, 30);
        s2 = [NSString stringWithFormat:@"%@ToolViewEmotion.png",[g_App imageFilePath]];
        s1 = [NSString stringWithFormat:@"%@keyboard_n@2x.png",[g_App imageFilePath]];
        [btn setBackgroundImage:[UIImage imageWithContentsOfFile:s2] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithContentsOfFile:s1] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(actionFace:) forControlEvents:UIControlEventTouchUpInside];
        [inputBar addSubview:btn];
        _btnFace = btn;
        _btnFace.selected = NO;
        
//        _messageConent=[[JXEmoji alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
//        _messageConent.backgroundColor = [UIColor clearColor];
//        _messageConent.userInteractionEnabled = NO;
//        _messageConent.numberOfLines = 0;
//        _messageConent.lineBreakMode = UILineBreakModeWordWrap;
//        _messageConent.font = [UIFont systemFontOfSize:15];
//        _messageConent.offset = -12;
        
        UIButton* _btn = [g_App createFooterButton:@"返回" action:@selector(actionQuit) target:self];
        _btn.frame = CGRectMake(5, (49-33)/2, 53, 66/2);
        //[self.tableHeader addSubview:_btn];
    }
    return self;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideKeyboard];
}

-(void)onHideKeyboard{
    [self hideKeyboard];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)actionFace:(UIButton *)sender
{
    self.tableFooter.frame = CGRectMake(0, JX_SCREEN_HEIGHT-460+150, 320, 44);
    _table.frame = CGRectMake(0, 20, 320, JX_SCREEN_HEIGHT-460);
    [self offRecordBtns];
    if(sender.selected){

        [messageText becomeFirstResponder];
        [_faceView removeFromSuperview];
        _faceView.hidden = YES;
        sender.selected = NO;
    }else{
        if(_faceView==nil){
            _faceView = g_App.faceView;
            _faceView.delegate = messageText;
        }
        [messageText resignFirstResponder];
        [self.view addSubview:_faceView];
        _faceView.hidden = NO;
        sender.selected = YES;
    }
    [self doBeginEdit];
}
#pragma mark ---触摸关闭键盘----
-(void)handleTap:(UIGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
}
#pragma mark ----键盘高度变化------
-(void)changeKeyBoard:(NSNotification *)aNotifacation
{
    
   // return;
    //获取到键盘frame 变化之前的frame
    NSValue *keyboardBeginBounds=[[aNotifacation userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyboardBeginBounds CGRectValue];
    
    //获取到键盘frame变化之后的frame
    NSValue *keyboardEndBounds=[[aNotifacation userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect endRect=[keyboardEndBounds CGRectValue];
      NSLog(@"endRect.origin.y-beginRect.origin.y==%f",endRect.origin.y-beginRect.origin.y);
    
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y-100;
    //拿frame变化之后的origin.y-变化之前的origin.y，其差值(带正负号)就是我们self.view的y方向上的增量
    deltaY=-endRect.size.height;
     [self.view setFrame:CGRectMake(0, 0+deltaY+218+65, self.view.frame.size.width, self.view.frame.size.height)];
    NSLog(@"deltaY:%f",deltaY);
    [CATransaction begin];
    [UIView animateWithDuration:0.4f animations:^{
        //        [self.view setFrame:CGRectMake(0, 0+deltaY+218+65, self.view.frame.size.width, self.view.frame.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
    [CATransaction commit];
    

}
-(void)doBeginEdit{
//    	inputBar.frame = CGRectMake(0, JX_SCREEN_HEIGHT-480+156, WIDTH, 44);
//    	_table.frame = CGRectMake(0, 0, 320, JX_SCREEN_HEIGHT-480+145+44);
    self.tableFooter.frame = CGRectMake(0, JX_SCREEN_HEIGHT-460+150, 320, 44);
    _table.frame = CGRectMake(0, 20, 320, JX_SCREEN_HEIGHT-460);

}
-(void)doEndEdit{
    //	inputBar.frame = CGRectMake(0, JX_SCREEN_HEIGHT-49-44-15, 320, 44);
    //	_table.frame = CGRectMake(0, 0, 320, height_table);
    self.tableFooter.frame = CGRectMake(0, JX_SCREEN_HEIGHT-self.heightFooter, 320, self.heightFooter);
    _table.frame =CGRectMake(0,self.heightHeader,self.view.frame.size.width,JX_SCREEN_HEIGHT-self.heightHeader-self.heightFooter);
    _faceView.hidden = YES;
    [_faceView removeFromSuperview];
}
-(void)offRecordBtns{
    _recordBtnLeft.selected = NO;
    _recordBtn.hidden = YES;
    messageText.hidden = NO;
}
-(void)shareMore:(UIButton *)sender
{
    [messageText setInputView:messageText.inputView?nil: _shareMoreView];
    [messageText reloadInputViews];
    [messageText becomeFirstResponder];
    
}
-(void)initAudio{
    //    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES]; //建议在播放之前设置yes，播放结束设置NO，这个功能是开启红外感应
    
    //添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sensorStateChange:)
                                                 name:@"UIDeviceProximityStateDidChangeNotification"
                                               object:nil];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMsgCome:) name:kXMPPNewMsgNotifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
}
//录制语音
-(void)recordStart:(UIButton *)sender
{
//    if(recording)
//        return;
//    
//    [audioPlayer pause];
//    recording=YES;
//    
//    NSDictionary *settings=[NSDictionary dictionaryWithObjectsAndKeys:
//                            [NSNumber numberWithFloat:8000],AVSampleRateKey,
//                            [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
//                            [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
//                            [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
//                            [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
//                            [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
//                            nil];
//    
//    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
//    [[AVAudioSession sharedInstance] setActive:YES error:nil];
//    
//    NSDate *now = [NSDate date];
//    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
//    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
//    NSString *fileName = [NSString stringWithFormat:@"rec_%@_%@.wav",@"这个写用户名",[dateFormater stringFromDate:now]];
//   // NSString *fullPath = [[[ChatCacheFileUtil sharedInstance] userDocPath] stringByAppendingPathComponent:fileName];
//   // NSURL *url = [NSURL fileURLWithPath:fullPath];
//   // pathURL = url;
//    
//    NSError *error;
//    audioRecorder = [[AVAudioRecorder alloc] initWithURL:pathURL settings:settings error:&error];
//    audioRecorder.delegate = self;
//    
//    peakTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updatePeak:) userInfo:nil repeats:YES];
//    [peakTimer fire];
//    
//    [audioRecorder prepareToRecord];
//    [audioRecorder setMeteringEnabled:YES];
//    [audioRecorder peakPowerForChannel:0];
//    [audioRecorder record];

}
- (void)recordStop:(UIButton *)sender {
//    if(!recording)
//        return;
//    [peakTimer invalidate];
//    peakTimer = nil;
//    
//    //    [self offRecordBtns];
//    
//    _timeLen = audioRecorder.currentTime;
//    [audioRecorder stop];
  //  NSString *amrPath = [VoiceConverter wavToAmr:pathURL.path];
  //  NSData *recordData = [NSData dataWithContentsOfFile:amrPath];
    
//    [[ChatCacheFileUtil sharedInstance] deleteWithContentPath:pathURL.path];
//    [[ChatCacheFileUtil sharedInstance] deleteWithContentPath:amrPath];
  //  _lastRecordFile = [[amrPath lastPathComponent] copy];
    
 //   NSLog(@"音频文件路径:%@\n%@",pathURL.path,amrPath);
    //    if (_timeLen<1) {
    //        [g_App showAlert:@"录的时间过短"];
    //        return;
    //    }
//    [self sendVoice:recordData];
 
   // recording = NO;
}
-(void)recordCancel:(UIButton *)sender
{
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self doBeginEdit];
    _btnFace.selected = NO;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self doEndEdit];
    return YES;
}

- (BOOL) hideKeyboard {
    [self doEndEdit];
    [messageText resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self hideKeyboard];
//     if(textField.tag == kWCMessageTypeGif)//切记一定要改
//    if(textField.tag == 5)
//        [self sendGif:textField];
//    else
//        [self sendIt:textField];
    return YES;
}
-(void)scrollToPageUp{
    if(_isLoading)
        return;
    _page ++;
    [self getServerData];
}

-(void)scrollToPageDown{
    if(_isLoading)
        return;
    _page=0;
    [self getServerData];
}

//-(void)getServerData{
//    _isLoading = YES;
//    [self refresh:nil];
//    [self stopLoading];
//    _isLoading = NO;
//}
//-(void)viewWillAppear:(BOOL)animated{
//    [self refresh:nil];
//}

#pragma mark   ---------tableView协议----------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}


//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    JXMessageObject *msg=[_array objectAtIndex:indexPath.row];
//    //    NSLog(@"msg0=%d",msg.retainCount);
//    NSString * identifier= [NSString stringWithFormat:@"friendCell_%d_%d",_refreshCount,indexPath.row];
//    JXMsgCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
//    
//    if (!cell) {
//        cell=[[JXMsgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        [_pool addObject:cell];
//        
//        //        NSLog(@"bb=%d",[msg.type intValue]);
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        cell.index    = indexPath.row;
//        cell.delegate = self;
//        cell.didTouch = @selector(onSelect:);
//        cell.msg      = msg;
//        
//        if([cell isMeSend])
//            [cell setHeadImage:_myHeadImage];
//        else
//            [cell setHeadImage:[UIImage imageNamed:[JXUserObject getHeadImage:msg.fromUserId]]];
//        //        NSLog(@"msg1=%d",msg.retainCount);
//    }
//    return cell;
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    JXMessageObject *msg=[_array objectAtIndex:indexPath.row];
//    int n = [msg.type intValue];
//    if(n == kWCMessageTypeImage)
//        return 66+70;
//    else
//        if( n == kWCMessageTypeVoice)
//            return 66;
//        else
//            if( n == kWCMessageTypeGif)
//                return 80;
//            else{
//                _messageConent.frame = CGRectMake(0, 0, 200, 20);
//                _messageConent.text   = [_array[indexPath.row]content];
//                n=_messageConent.frame.size.height;
//                NSLog(@"heightForRowAtIndexPath_%d,%d:=%@",indexPath.row,n,_messageConent.text);
//                if(n<66)
//                    n = 66;
//                return n;
//            }
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self hideKeyboard];
//}
@end
