//
//  it_ariescomunicazioneDetailViewController.m
//  ConMeBrugherio
//
//  Created by Silvia Pessini on 24/09/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import "it_ariescomunicazioneDetailViewController.h"
#import "PVDetailController.h"
#import "PromoDetailVC.h"

@interface it_ariescomunicazioneDetailViewController ()
@property (nonatomic,retain) UIBarButtonItem *navigationPaneBarButtonItem;
- (void)configureView;
@property (nonatomic,retain) UIView *currentview;

@end


@implementation it_ariescomunicazioneDetailViewController

@synthesize navigationPopoverController, imgvw,currentview,CurPV,prm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:214.0/255 green:76.0/255 blue:91.0/255 alpha:1];
    self.title = NSLocalizedString(@"Vivi al meglio la tua città", @"Commercio");
 
    

//    UIImage *image = [UIImage imageNamed: @"112.png"];   //////
//    
//    
//        {
//               [imgvw setImage:image];// change frames
//        }
//                  




}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setDetailViewcontroller:(UIViewController<SubstitutableDetailViewController> *)detailViewcontroller
{
//    self.detailViewcontroller.navigationPaneBarButtonItem=nil;
//    _detailViewcontroller=detailViewcontroller;
//
//    _detailViewcontroller.navigationPaneBarButtonItem=self.navigationPaneBarButtonItem;
//
//
//    if(self.navigationPopoverController)
//        [self.navigationPopoverController dismissPopoverAnimated:YES];

}


//
//-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
//{
//    return UIDeviceOrientationIsPortrait(orientation);
//}

UIBarButtonItem *barButtonForMaster;

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Menu", @"Menu");
   // barButtonForMaster=barButtonItem;
  [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
   self.navigationPopoverController = popoverController;
    
}


-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem   {
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
 //[self.navigationItem setLeftBarButtonItem:nil animated:YES];
    
   self.navigationPopoverController = nil;
    
}


-(void)mostrapdv;

{
    
//    @try {
//       
//        [currentview removeFromSuperview];
//        
//    }
//    @catch (NSException* exception) {
//        
//    }
    
    
        PVDetailController *EicaVC ;
    
    EicaVC= [[PVDetailController alloc] initWithNibName:@"PVDetail_ipad" bundle:nil];
    EicaVC.CurPV=self.CurPV;
    
   // currentview=EicaVC.view;
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController pushViewController:EicaVC animated:YES];
     [self.navigationPopoverController dismissPopoverAnimated:YES];
    //[self.view addSubview:currentview];
    
}


-(void)mostrapromozione:(Promozioni*) promo{
    
    PromoDetailVC *EicaVC = [[PromoDetailVC alloc] initWithNibName:@"PromoDetailVC_ipad" bundle:nil];

    // EicaVC.prm = prm;
    
    // currentview=EicaVC.view;
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController pushViewController:EicaVC animated:YES];
    [self.navigationPopoverController dismissPopoverAnimated:YES];
    
    
    
}


- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.navigationPopoverController != nil) {
        [self.navigationPopoverController dismissPopoverAnimated:YES];
    }
}



-(void)animazione{
    
    
    
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
}
-(void) viewDidAppear:(BOOL)animated{
   // barButtonForMaster=self.navigationItem.leftBarButtonItem;
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
    [self.navigationPopoverController presentPopoverFromRect:CGRectMake(0,0,1,1)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}



@end
