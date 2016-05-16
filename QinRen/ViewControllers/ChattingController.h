//
//  ChattingController.h
//  QinRen
//
//  Created by Easaa on 15/4/22.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PullRefreshTableViewController.h"
#import "JXSelectImageView.h"
#import <AVFoundation/AVFoundation.h>
#import "PullRefreshTableViewController.h"
#import "emojiViewController.h"

@class JXEmoji;
@class JXSelectImageView;
@interface ChattingController : PullRefreshTableViewController<UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    NSMutableArray *_array;
    NSMutableArray *_pool;
    UIImage *_myHeadImage,*_userHeadImage;
      JXSelectImageView *_shareMoreView;
    UIImageView *inputBar;
    UITextField *messageText;
    UIButton* _recordBtn;
    UIButton* _recordBtnLeft;
        UIButton* _btnFace;
    BOOL recording;
    NSTimer *peakTimer;
    emojiViewController* _faceView;
    JXEmoji* _messageConent;
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    NSURL *pathURL;
    UIView* talkView;
    NSString* _lastRecordFile;
    NSString* _lastPlayerFile;
    NSTimeInterval _lastPlayerTime;
    int _lastIndex;
    
    double lowPassResults;
    NSTimeInterval _timeLen;
    int _refreshCount;
}

@end
