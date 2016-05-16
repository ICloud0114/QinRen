//
//  QRXMPP.h
//  QinRen
//
//  Created by Easaa on 15/4/23.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "XMPPFramework.h"
#import "FMDatabase.h"
@class JXMessageObject;

@interface QRXMPP : NSObject
{
    XMPPStream *xmppStream;
    XMPPReconnect *xmppReconnect;
    XMPPRoster *xmppRoster;
    XMPPRosterCoreDataStorage *xmppRosterCoreDataStorage;
    
    NSString *password;
    BOOL allowSelfSignedCertificates;
    BOOL allowSSLHostNameMismatch;
    BOOL isXmppConnected;
    FMDatabase* _db;
    NSString* _userIdOld;
}


- (NSManagedObjectContext *)managedObjectContext_roster;
@property (readonly, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (assign, nonatomic) XMPPStream* stream;
@property (assign, nonatomic) BOOL isLogined;
//@property (retain, nonatomic) JXRoomPool* roomPool; //这个还要改

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (BOOL)connect;
- (void)disconnect;
//- (FMDatabase*)getDatabase;
- (FMDatabase*)openUserDb:(NSString*)userId;




+(QRXMPP*)sharedInstance;


#pragma mark -------配置XML流-----------

- (void)setupStream;
- (void)teardownStream;


#pragma mark ----------收发信息------------
- (void)goOnline;
- (void)goOffline;

- (void)login;
- (void)logout;

- (void)sendMessage:(JXMessageObject*)msg roomName:(NSString*)roomName;
- (void)addSomeBody:(NSString *)userId;


#pragma mark ---------文件传输-----------
-(void)sendFile:(NSData*)aData toJID:(XMPPJID*)aJID;
@end
