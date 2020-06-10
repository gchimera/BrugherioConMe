//
//  ElencoCategorie.m
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import "ElencoCategorie.h"
#import "Categoria.h"
#import "ElencoPDV.h"
#import "CustomBadge.h"
#import "SottoCategoriaViewController.h"
#import "Preferiti.h"
#import "PromozioniVC.h"

@interface ElencoCategorie ()

@end

@implementation ElencoCategorie
@synthesize filteredListContent;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Categorie", @"Categorie");

    
      
 
    
        
    }
    return self;
}

- (void)viewDidLoad
{
 
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    [self.navigationController setNavigationBarHidden:FALSE];    //

    }
    
    appDelegate = (it_ariescomunicazioneAppDelegate *)[[UIApplication sharedApplication] delegate];
    filteredListContent = [Categoria getCategorie:appDelegate.getDBPath];
   
    
    // img NavContr
 /*   UIImage *image = [UIImage imageNamed:@"header.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.navigationController.navigationBar.topItem setTitleView:imageView];
*/
    


    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 400.0);
    }
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.navigationController.contentSizeForViewInPopover = self.contentSizeForViewInPopover;
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
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
        
        if(cell==nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTableIdentifier];
            
        }
    }
    
    
    
    
    Categoria *curesp = [filteredListContent objectAtIndex:indexPath.row];
    
    if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
        
       
    }
    cell.textLabel.text= [curesp.Desc uppercaseString];
    
    
    
    UIImage *tableImage = [UIImage imageNamed:curesp.Icona];
    [cell.imageView setImage:tableImage];
    
    cell.imageView.contentMode=UIViewContentModeCenter;

 
    
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
        return 32;
   }
    
    
    //return tableView.rowHeight;
}



// Se selezioniamo una riga appare un pop-up con l'elemento in questione
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Categoria *selid = (Categoria *)[filteredListContent objectAtIndex:indexPath.row];
    
    
    if(selid.ID == 1){
       
        PromozioniVC *pr = [[PromozioniVC alloc] initWithNibName:@"PromozioniVC_iphone" bundle:nil];
        [self.navigationController pushViewController:pr animated:YES];
        
        return;
    }else if (selid.ID==2){
        //PREFERITI
        
        Preferiti *pf = [[Preferiti alloc] initWithNibName:@"Preferiti_iPhone" bundle:nil];
       [self.navigationController pushViewController:pf animated:YES];
        
        


        
    return;
        
    }
    
//    
//    [UIView beginAnimations:@"View Flip" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
//    
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    
    NSMutableArray *sottocat = [Categoria getSottoCategorie:appDelegate.getDBPath  idpadre:selid.ID];
    //se non ci sono sottocategorie visualizzo l'elenco dei negozi
    if(sottocat.count == 0){
    
    ElencoPDV *EicaVC ;
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
//       
//            EicaVC= [[ElencoPDV alloc]
//                     initWithNibName:@"ElencoPDV_iPad" bundle:nil];
//    }else{
        EicaVC= [[ElencoPDV alloc]
                 initWithNibName:@"ElencoPDV_iPhone" bundle:nil];
   // }
    
    EicaVC.CurCat = selid;
    
    [self.navigationController pushViewController:EicaVC animated:YES];
    
    }else{
        
        SottoCategoriaViewController *sottocg;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        sottocg= [[SottoCategoriaViewController alloc] initWithNibName:@"SottoCategoriaViewController" bundle:nil];
            
        }else{
            
        sottocg= [[SottoCategoriaViewController alloc] initWithNibName:@"SottoCategoriaViewController" bundle:nil];
            
        }
        
        sottocg.ID_padre=selid.ID;
        

        [self.navigationController pushViewController:sottocg animated:YES];
    
    }
    
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
