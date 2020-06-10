//
//  it_ariescomunicazioneAppDelegate.m
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import "it_ariescomunicazioneAppDelegate.h"
#import "ElencoCategorie.h"
#import "Reachability.h"
#import "Mappe.h"
#import "Preferiti.h"
#import "BCDShareSheet.h"
#import "CategorieSplitviewController.h"
#import "it_ariescomunicazioneDetailViewController.h"
#import "ComuneCV.h"
#import "ComuneDetailViewController.h"
#import "PushNotificationManager.h"


@implementation it_ariescomunicazioneAppDelegate

@synthesize detail,detailComune;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    
    [self copyDatabaseIfNeed];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
//  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
     self.tabBarController = [[UITabBarController alloc] init];
    UIViewController *viewController2;
   
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
          UIViewController *viewController1;
        viewController1 = [[ElencoCategorie alloc] initWithNibName:@"ElencoCategorie_iPhone" bundle:nil];
        viewController2 = [[Mappe alloc] initWithNibName:@"Mappe_iPhone" bundle:nil];
       // prefViewContrtoller=[[Preferiti alloc] initWithNibName:@"Preferiti_iPhone" bundle:nil];
         UINavigationController* nav=[[UINavigationController alloc] initWithRootViewController:viewController1];
        
        
        viewController1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Commercio" image:nil tag:0];
        [[viewController1 tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"catrossa"] withFinishedUnselectedImage:[UIImage imageNamed:@"catrossa"]];
        
        
        UIViewController *comuneiphn;
        comuneiphn=[[ComuneCV alloc] initWithNibName:@"ComuneVC_iphone" bundle:nil];
        comuneiphn.tabBarItem.image = [UIImage imageNamed:@"book.png"];
        comuneiphn.title = NSLocalizedString(@"Comune", @"Comune");
        UINavigationController* nav2=[[UINavigationController alloc] initWithRootViewController:comuneiphn];
        
//        viewController1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Comune" image:nil tag:0];
//        [[viewController1 tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"catrossa"] withFinishedUnselectedImage:[UIImage imageNamed:@"catrossa"]];
        
        
        comuneiphn.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Comune" image:nil tag:0];
        [[comuneiphn tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"book"] withFinishedUnselectedImage:[UIImage imageNamed:@"book"]];
        
        
        viewController2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Mappe" image:nil tag:0];
        [[viewController2 tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"gps"] withFinishedUnselectedImage:[UIImage imageNamed:@"gps"]];
        
        
        
         self.tabBarController.viewControllers = @[ nav2, nav, viewController2];
        
        BCDShareSheet *sharedSharer = [BCDShareSheet sharedSharer];
        [sharedSharer setAppName:@"Brugherio ConMe"];
        [sharedSharer setRootViewController:viewController1];
        [sharedSharer setFacebookAppID:@"137950363078634"];

        
    } else {
        
       UISplitViewController *SPviewController1 = [[UISplitViewController alloc] init];
         SPviewController1.presentsWithGesture=NO;
        
        viewController2 = [[Mappe alloc] initWithNibName:@"Mappe_iPhone" bundle:nil];
        
        
        ElencoCategorie *cat = [[ElencoCategorie alloc] initWithNibName:@"ElencoCategorie_iPhone" bundle:nil];
        UINavigationController  *nav = [[UINavigationController alloc] initWithRootViewController:cat];
        nav.contentSizeForViewInPopover=CGSizeMake(320,500);
        
        it_ariescomunicazioneDetailViewController *det = [[it_ariescomunicazioneDetailViewController alloc] initWithNibName:@"it_ariescomunicazioneDetailViewController" bundle:nil];
        self.detail=det;
        
           UINavigationController  *navdet = [[UINavigationController alloc] initWithRootViewController:det];
        SPviewController1.delegate=det;
  //      SPviewController1.tabBarItem.image = [UIImage imageNamed:@"tabmappe"];
        
        SPviewController1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Categorie" image:nil tag:0];
        [[SPviewController1 tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"catrossa"] withFinishedUnselectedImage:[UIImage imageNamed:@"catrossa"]];
        
  
        
        
        NSMutableArray *viewControllers =[[NSMutableArray alloc] initWithObjects:nav,navdet, nil];
        SPviewController1.viewControllers=viewControllers;
        
        
        
        //FINE CATEGORIE
        //  COMUNE
        
        UIViewController *comuneipd;
        comuneipd=[[ComuneCV alloc] initWithNibName:@"ComuneVC_iphone" bundle:nil];
         UINavigationController  *navcomlista = [[UINavigationController alloc] initWithRootViewController:comuneipd];
        
        
        ComuneDetailViewController *dtc = [[ComuneDetailViewController alloc] initWithNibName:@"ComuneDetailViewController" bundle:nil];
        self.detailComune=dtc;
        
        UISplitViewController *SPComuneviewController = [[UISplitViewController alloc] init];
        SPComuneviewController.presentsWithGesture=NO;
        SPComuneviewController.delegate=dtc;
        
        SPComuneviewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Comune" image:nil tag:0];
        [[SPComuneviewController tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"book"] withFinishedUnselectedImage:[UIImage imageNamed:@"book"]];
        
        UINavigationController  *navcom = [[UINavigationController alloc] initWithRootViewController:dtc];
navcom.contentSizeForViewInPopover = CGSizeMake(320.0, 400.0);
        
        NSMutableArray *viewControllerscomune =[[NSMutableArray alloc] initWithObjects:navcomlista,navcom, nil];
        SPComuneviewController.viewControllers=viewControllerscomune;
        
        //MAPPE
        viewController2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Mappe" image:nil tag:0];
        [[viewController2 tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"gps"] withFinishedUnselectedImage:[UIImage imageNamed:@"gps"]];

         self.tabBarController.viewControllers = @[SPComuneviewController,SPviewController1,viewController2];
        
        
    }
    
    
   
    
 
        
   
   
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:255.0/255 green:255.0/255 blue:255.0/255 alpha:1];
   
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                 UITextAttributeFont : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                            UITextAttributeTextColor : [UIColor colorWithRed:214.0/255 green:76.0/255 blue:91.0/255 alpha:1]}
                                             forState:UIControlStateNormal];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
   
    
    // sfondo navbar
   // [application setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    UIImage *navBarBackgroundImage = [UIImage imageNamed:@"topb.png"];
    [[UINavigationBar appearance] setBackgroundImage:navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    
    // text color navbar
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
      UITextAttributeTextColor,
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"seguisb" size:0.0],
      UITextAttributeFont,
      nil]];
    
    
 return YES;
    
}


-(NSString *)getDBPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDir =[paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"GuidaBIO.sqlite"];
}


-(void) copyDatabaseIfNeed {
    NSFileManager *fileManger =[NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath =[self getDBPath];
    NSLog(@"il database si dovrebbe trovare %@", dbPath);
    BOOL success = [fileManger fileExistsAtPath:dbPath];
    if(!success){
        NSString *defaultDBPath =[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"GuidaBIO.sqlite"];
        success = [fileManger fileExistsAtPath:defaultDBPath];
        
        success =[fileManger copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if(!success){
            NSAssert1(0, @"Failed to create writeable database file with message %@", [error localizedDescription]);
            
        }
    }else {
        NSLog(@"database copiato correttamente");
    }
    
}

+(BOOL)isConnectionAvailable{
    BOOL ret = NO;
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    
    if ((internetStatus == ReachableViaWiFi) || (internetStatus == ReachableViaWWAN)){
        ret = YES;
    }
    
    return ret;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





- (void) onPushAccepted:(PushNotificationManager *)pushManager withNotification:(NSDictionary *)pushNotification {
    NSLog(@"Push notification received");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return YES;
    }else {
        if(interfaceOrientation== UIInterfaceOrientationPortrait || interfaceOrientation== UIInterfaceOrientationPortraitUpsideDown){
            return YES;
        }else{
            return NO;
        }
        
    }
}



@end
