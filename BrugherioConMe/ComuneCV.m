//
//  ComuneCV.m
//  ConMeBrugherio
//
//  Created by Silvia Pessini on 25/09/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import "ComuneCV.h"
#import <QuartzCore/QuartzCore.h>
#import "ComuneDetailViewController.h"

@interface ComuneCV ()

@end


@implementation ComuneCV

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Menu", @"Menu");

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
	// Do any additional setup after loading the view, typically from a nib.
    // self.navigationItem.leftBarButtonItem = self.editButtonItem;

      appDelegate = (it_ariescomunicazioneAppDelegate *)[[UIApplication sharedApplication] delegate];
    

    menulist= [[NSMutableArray alloc] init];
    
    [menulist removeAllObjects];
    [menulist addObject:@"AMMINISTRAZIONE"];
    [menulist addObject:@"BRUGHERIO IN CIFRE"];
    [menulist addObject:@"CONTATTI E NUMERI UTILI"];
    [menulist addObject:@"METEO"];
    [menulist addObject:@"STORIA"];
    [menulist addObject:@"UFFICI COMUNALI"];

    
  //  [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){

//   UINavigationBar *navBar = [ [UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    [self.view addSubview:navBar];
        
    }
 //[self.navigationController setNavigationBarHidden:FALSE];
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    //menulist//return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return menulist.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * sel =[menulist objectAtIndex:indexPath.row];
   
    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        [appDelegate.detailComune Mostratesto:sel];
        
    }else{
    
        
        ComuneDetailViewController *cv = [[ComuneDetailViewController alloc] initWithNibName:@"ComuneDetailVC_iphone" bundle:nil];
        
       
          cv.sel=sel;
    CATransition *animation =[CATransition animation];
    [animation setDuration:0.2];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    [self.navigationController.view.layer removeAllAnimations];
    [self.navigationController.view.layer addAnimation:animation forKey:kCATransition];
    
    [self.navigationController pushViewController:cv animated:NO];
       
    [tb deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}





- (CGFloat) tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return 40;
    }else{
        return 40;
        
    }
    
    //return tableView.rowHeight;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    cell.textLabel.text = [menulist objectAtIndex:indexPath.row];
    cell.textLabel.textColor= [UIColor blackColor];
  
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
       cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //  [cell setBackgroundColor:[UIColor colorWithRed:128.0 / 255  green:194.0 / 255  blue:236.0 / 255  alpha:1]];
    
    //   cell.textLabel.textColor =[UIColor greenColor];
    
    //cell.detailTextLabel.textColor =[UIColor whiteColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell.textLabel.font=[UIFont boldSystemFontOfSize:18];
    }else{
        cell.textLabel.font=[UIFont boldSystemFontOfSize:15];
    }
    
    
    
}

-(void) viewWillAppear:(BOOL)animated
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 400.0);
}

@end
