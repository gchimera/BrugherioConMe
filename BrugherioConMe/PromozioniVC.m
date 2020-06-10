//
//  PromozioniVC.m
//  BrugherioConMe
//
//  Created by Silvia Pessini on 02/10/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import "PromozioniVC.h"

#import "CustomBadge.h"
#import "PromoDetailVC.h"
#import "Promozioni.h"



@interface PromozioniVC ()

@end


@implementation PromozioniVC

@synthesize filteredListContent;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Promozioni", @"Promozioni");
        
        
        
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   // if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self.navigationController setNavigationBarHidden:FALSE];    //
        
    
    
    appDelegate = (it_ariescomunicazioneAppDelegate *)[[UIApplication sharedApplication] delegate];
    filteredListContent = [Promozioni getPromozioni :appDelegate.getDBPath];
    
    
    // img NavContr
    /*   UIImage *image = [UIImage imageNamed:@"header.png"];
     UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
     [self.navigationController.navigationBar.topItem setTitleView:imageView];
     */
    
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 400.0);
    }
            //}

//-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//  self.navigationController.contentSizeForViewInPopover = self.contentSizeForViewInPopover;
}


-(void) viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:FALSE];   //
}

#pragma mark TABLEVIEW


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [filteredListContent count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellCategorie";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CellTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIdentifier];
        
        if(cell==nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIdentifier];
            
        }
    }
    
    
    
    
    Promozioni *curesp = [filteredListContent objectAtIndex:indexPath.row];
    
    if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
        
        
    }
    
    cell.textLabel.text= [curesp.titoloPuntov uppercaseString];
    
    NSString *detail;
    
   if( curesp.testo.length > 20 )
   {
       detail=[NSString stringWithFormat:@"%@...", [curesp.testo substringToIndex:20]];
   }else{
       detail=curesp.testo;
   }
   
    
    cell.detailTextLabel.text=detail ;

    
       cell.imageView.frame=CGRectMake(0,0, 80, [tableView rowHeight]);
    
  UIImage *tableImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:curesp.Immagine]]];
  [cell.imageView setImage:tableImage];    
  //cell.imageView.contentMode=UIViewContentModeCenter;
    
    
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    
    //  CustomBadge *customBadge1 = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d",[curesp NumPDV: appDelegate.getDBPath ]]
	//											   withStringColor:[UIColor whiteColor]
	//												withInsetColor:[UIColor colorWithRed:20.0/255 green:106.0/255 blue:57.0/255 alpha:1]
	//												withBadgeFrame:YES
	//										   withBadgeFrameColor:[UIColor whiteColor]
	//													 withScale:1.0
	//												   withShining:YES];
    
    //	[customBadge1 setFrame:CGRectMake((cell.contentView.frame.size.width-customBadge1.frame.size.width)-5, 6, customBadge1.frame.size.width,
    //customBadge1.frame.size.height)];
    //[cell.contentView addSubview:customBadge1];
    
    return cell;
    
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

- (CGFloat) tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //if (indexPath.row==0)
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return 50;
    }else{
        return 40;
    }
    
    
    //return tableView.rowHeight;
}



// Se selezioniamo una riga appare un pop-up con l'elemento in questione
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Promozioni *selid = (Promozioni *)[filteredListContent objectAtIndex:indexPath.row];
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone){
        PromoDetailVC *aa = [[PromoDetailVC alloc] initWithNibName:@"PromoDetail_iphone" bundle:nil];
        aa.prm=selid;
        
        [self.navigationController pushViewController:aa animated:YES];
    }else{
        [appDelegate.detail mostrapromozione: selid];
        
    }
       
    //
    //    [UIView beginAnimations:@"View Flip" context:nil];
    //    [UIView setAnimationDuration:0.5];
    //    [UIView setAnimationDelegate:self];
    //    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
    //
    //    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    

    // Animation View
    
    
    //  [UIView setAnimationTransition:
    //    UIViewAnimationTransitionCurlUp
    //                           forView:self.navigationController.view cache:YES];
    
    
    
    //[UIView commitAnimations];
    //  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end



