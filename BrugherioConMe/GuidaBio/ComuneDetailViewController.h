//
//  ComuneDetailViewController.h
//  BrugherioConMe
//
//  Created by Silvia Pessini on 27/09/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComuneDetailViewController:UIViewController <UISplitViewControllerDelegate>

@property(nonatomic,retain) IBOutlet UIWebView *web1;
@property(nonatomic,retain) IBOutlet UIWebView *web2;
@property(nonatomic,retain) IBOutlet UIWebView *web3;
@property(nonatomic,retain) IBOutlet UIWebView *web4;
@property(nonatomic,retain) IBOutlet UIWebView *web5;
@property(nonatomic,retain) IBOutlet UIWebView *web6;
@property(nonatomic,retain) IBOutlet UINavigationBar *tab;
@property(nonatomic,retain) UIPopoverController *navigationPopoverController;
@property(nonatomic,retain) IBOutlet NSString *sel;

-(void)Mostratesto : (NSString *) testo;
-(IBAction) showpopover:(id)sender;

@end
