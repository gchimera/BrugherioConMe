//
//  SottoCategoriaViewController.m
//  ConMeBrugherio
//
//  Created by Silvia Pessini on 20/09/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import "SottoCategoriaViewController.h"
#import "Categoria.h"
#import "ElencoPDV.h"
#import "CustomBadge.h"
#import "ElencoCategorie.h"

@interface SottoCategoriaViewController ()

@end

@implementation SottoCategoriaViewController
@synthesize ID_padre,filteredListContent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Categorie", @"Categorie");
        self.tabBarItem.image = [UIImage imageNamed:@"tabCategorie"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self.navigationController setNavigationBarHidden:TRUE];
    appDelegate = (it_ariescomunicazioneAppDelegate *)[[UIApplication sharedApplication] delegate];
    filteredListContent = [Categoria getSottoCategorie:appDelegate.getDBPath  idpadre:ID_padre]; //[Categoria getCategorie:appDelegate.getDBPath];
   // tb.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wllp.png"]];
    
    
}



-(void) viewWillAppear:(BOOL)animated{
 //   [self.navigationController setNavigationBarHidden:TRUE];
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
        
        cell.textLabel.textColor= [UIColor blackColor];
        cell.textLabel.font=[UIFont boldSystemFontOfSize:13];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
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
    
    // [cell setBackgroundColor:[UIColor colorWithRed:128.0 / 255  green:194.0 / 255  blue:236.0 / 255  alpha:1]];
    
    // cell.textLabel.textColor =[UIColor greenColor];
    
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
//    //if (indexPath.row==0)
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
//        return 70;
//    }else{
        return 40;
//    }
    
    
    //return tableView.rowHeight;
}



// Se selezioniamo una riga appare un pop-up con l'elemento in questione
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Categoria *selid = (Categoria *)[filteredListContent objectAtIndex:indexPath.row];
    
    
//    [UIView beginAnimations:@"View Flip" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
//    
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    
    //NSMutableArray *sottocat = [Categoria getSottoCategorie:appDelegate.getDBPath  idpadre:selid.ID];
    //se non ci sono sottocategorie visualizzo l'elenco dei negozi
   // if(sottocat.count == 0){
        
        ElencoPDV *EicaVC ;
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
//            
//            EicaVC= [[ElencoPDV alloc]
//                     initWithNibName:@"ElencoPDV_iPad" bundle:nil];
//        }else{
            EicaVC= [[ElencoPDV alloc]
                     initWithNibName:@"ElencoPDV_iPhone" bundle:nil];
    

       // }
        
        EicaVC.CurCat = selid;
        
        [self.navigationController pushViewController:EicaVC animated:YES];
        
    //}else{
        //altrimenti apro la maschera delle sottocategorie
        
        
    //}
    
//    [UIView setAnimationTransition:  UIViewAnimationTransitionCurlDown
//                           forView:self.navigationController.view cache:YES];
    
    
   // [UIView commitAnimations];
  //  [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
