//
//  it_ariescomunicazioneAppDelegate.h
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "it_ariescomunicazioneDetailViewController.h"
#import "ComuneDetailViewController.h"

@interface it_ariescomunicazioneAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) it_ariescomunicazioneDetailViewController *detail;
@property (strong, nonatomic) ComuneDetailViewController *detailComune;


-(void) copyDatabaseIfNeeded;

-(NSString *) getDBPath;

+(BOOL)isConnectionAvailable;

@end
