//
//  it_ariescomunicazioneFirstViewController.m
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import "ElencoPDV.h"
#import "PuntoVendita.h"
#import "PVDetailController.h"
#import "it_ariescomunicazioneDetailViewController.h"

@interface ElencoPDV ()

@end

@implementation ElencoPDV
@synthesize CurCat,filteredListContent,sbar,ListContent,detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
       // self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated  {
    sbar.showsScopeBar=NO;
    [sbar sizeToFit];
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
   // tb.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wllp.png"]];
    self.title = [CurCat.Desc uppercaseString];
   // self.navigationController.navigationBar.tintColor=[UIColor colorWithRed:20.0/255 green:106.0/255 blue:57.0/255 alpha:1];
       [self.navigationController setNavigationBarHidden:FALSE];
  	// Do any additional setup after loading the view, typically from a nib.
   
    
    appDelegate = (it_ariescomunicazioneAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    filteredListContent= [PuntoVendita getPVCategoria:CurCat.ID dbPath:[appDelegate getDBPath]];
    ListContent =  [PuntoVendita getPVCategoria:CurCat.ID dbPath:[appDelegate getDBPath]];

    
}




#pragma mark TABLEVIEW


- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    //return [appDelegate.EICAExpos count];
    return [filteredListContent count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellTableIdentifier ";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CellTableIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIdentifier];
        
        if(cell==nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIdentifier];
            
        }
    }
    
    PuntoVendita *curesp = [filteredListContent objectAtIndex:indexPath.row];
    
    if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
        

    }
    
    cell.textLabel.text= [curesp.titolo uppercaseString];
 
    cell.detailTextLabel.text=curesp.IndirizzoCompletoUnariga;

   // cell.imageView.image=[UIImage imageNamed:@""];
    
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
}

- (CGFloat) tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //if (indexPath.row==0)
 
        return 60;
    
    //return tableView.rowHeight;
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
   /* if (indexPath.row % 2)
    {
        [cell setBackgroundColor:[UIColor colorWithRed:127.0 / 255 green:195.0 / 255  blue:226.0 / 255  alpha:1]];
    }
    else
    {
        [cell setBackgroundColor:[UIColor colorWithRed:128.0 / 255  green:194.0 / 255  blue:236.0 / 255  alpha:1]];
    }
    
    cell.textLabel.textColor =[UIColor whiteColor];
    cell.detailTextLabel.textColor =[UIColor whiteColor];
    */
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        cell.textLabel.font=[UIFont boldSystemFontOfSize:18];
    }else{
        cell.textLabel.font=[UIFont boldSystemFontOfSize:15];
    }
    
}


// Se selezioniamo una riga appare un pop-up con l'elemento in questione
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PuntoVendita *curid = (PuntoVendita *)[filteredListContent objectAtIndex:indexPath.row];
    
//    [UIView beginAnimations:@"View Flip" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
//    
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    PVDetailController *EicaVC ;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        
        appDelegate.detail.CurPV=curid;
        [appDelegate.detail mostrapdv];
            
        
        
    }else{
        EicaVC= [[PVDetailController alloc]
                 initWithNibName:@"PVDetailController_iPhone" bundle:nil];
        
        
        EicaVC.CurPV = curid;
        
        [self.navigationController pushViewController:EicaVC animated:YES];
        
        
        // Animation View
        
         [UIView setAnimationTransition:  UIViewAnimationTransitionCurlDown
         forView:self.navigationController.view cache:YES];
        
        
        
        
        [UIView commitAnimations];
        
    }
    
    
    
   
    
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope{
    [self.filteredListContent removeAllObjects];
    PuntoVendita *cellTitle;
	for (cellTitle in ListContent){
        NSRange result;
        if(sbar.selectedScopeButtonIndex==0){
            result = [cellTitle.titolo  rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];//compare:searchText options:NSCaseInsensitiveSearch range:NSMakeRange(0, [searchText length])];
        }else if (sbar.selectedScopeButtonIndex==1){
             result = [cellTitle.Regione rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        }else{
            result = [cellTitle.comune rangeOfString:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
        }
		if (result.length >0){
			[filteredListContent addObject:cellTitle];
		}
	}
    
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)saearchBar {
    [self.filteredListContent removeAllObjects];
    self.filteredListContent=[PuntoVendita getPVCategoria:CurCat.ID dbPath:[appDelegate getDBPath]];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsScopeBar=YES;

    [searchBar sizeToFit];
     [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

-(BOOL) searchBarShouldEndEditing:(UISearchBar *)searchBar{
    searchBar.showsScopeBar=NO;
    [searchBar sizeToFit];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    
    return YES;
}

@end
