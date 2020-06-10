//
//  Preferiti.m
//  GuidaBIO
//
//  Created by Silvia Pessini on 29/12/12.
//  Copyright (c) 2012 Aries Comunicazione srl. All rights reserved.
//

#import "Preferiti.h"
#import "PuntoVendita.h"
#import "PVDetailController.h"
#import "it_ariescomunicazioneDetailViewController.h"


@interface Preferiti ()

@end

@implementation Preferiti
@synthesize filteredListContent,mtview;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = NSLocalizedString(@"Preferiti", @"Preferiti");
         self.tabBarItem.image = [UIImage imageNamed:@"tabpreferiti"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle: @"Preferiti"];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    appDelegate = (it_ariescomunicazioneAppDelegate *)[[UIApplication sharedApplication] delegate];
    filteredListContent = [PuntoVendita Getpreferiti: [appDelegate getDBPath]];
    
    //[self.navigationController setNavigationBarHidden:TRUE];
    
 //   tb.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wllp.png"]];
    
    if(filteredListContent.count==0){
        
        
        UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(30,50, 250,250)];
        lbl.font = [UIFont boldSystemFontOfSize:13];
        lbl.backgroundColor=[UIColor clearColor];
        lbl.numberOfLines=3;
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.textColor= [UIColor blackColor];
        [lbl setText:@"Per aggiungere i preferiti clicca sul pulsante nel dettaglio del Commerciante"];
        [self.view addSubview:lbl];
        
    }
  
}

-(void) viewWillAppear:(BOOL)animated{
    
    //[self.navigationController setNavigationBarHidden:NO];
}

-(void) viewDidUnload
{
    filteredListContent=nil;
    [mtview setEditing:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TABLEVIEW

-(void) setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [mtview setEditing:editing animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    //return [appDelegate.EICAExpos count];
    return [filteredListContent count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"CellPreferiti";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CellTableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIdentifier];
        
        if(cell==nil){
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIdentifier];
            
        }
    }
    
    
    
    
    PuntoVendita *curesp = [filteredListContent objectAtIndex:indexPath.row];
    
    cell.textLabel.font =[UIFont boldSystemFontOfSize:11];
    cell.detailTextLabel.font =[UIFont boldSystemFontOfSize:10];
    
    cell.textLabel.text= curesp.titolo ;
    //cell.detailTextLabel.text=curesp.Stand;
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    [cell setBackgroundColor:[UIColor blackColor]];
//    cell.textLabel.textColor =[UIColor whiteColor];
//    cell.detailTextLabel.textColor =[UIColor whiteColor];
    
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
    return 40;
    
    
    
    //return tableView.rowHeight;
}



// Se selezioniamo una riga appare un pop-up con l'elemento in questione
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PuntoVendita *selid = (PuntoVendita *)[filteredListContent objectAtIndex:indexPath.row];
    PuntoVendita *curid =[[PuntoVendita alloc] initWithPrimaryKey:selid.ID];
    
    [curid LoadByID:selid.ID dbPath:appDelegate.getDBPath];
    
//    [UIView beginAnimations:@"View Flip" context:nil];
//    [UIView setAnimationDuration:0.5];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
//    
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    PVDetailController *EicaVC ;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        appDelegate.detail.CurPV=curid;
        [appDelegate.detail mostrapdv ];
        
        return;
        
    }else{
    
       
        EicaVC= [[PVDetailController alloc]
                 initWithNibName:@"PVDetailController_iPhone" bundle:nil];
        
    }
    
    EicaVC.CurPV = curid;
    
    [self.navigationController pushViewController:EicaVC animated:YES];
    
//    [UIView setAnimationTransition:
//     UIViewAnimationOptionTransitionFlipFromBottom
//                           forView:self.navigationController.view cache:YES];
    
    
    
//    [UIView commitAnimations];
//    [mtview deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [tableView beginUpdates];
        PuntoVendita *curid = (PuntoVendita *)[filteredListContent objectAtIndex:indexPath.row];
        
        [PuntoVendita DeleteFavourite:curid.ID dbPath:appDelegate.getDBPath];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
        filteredListContent = [PuntoVendita Getpreferiti: appDelegate.getDBPath];
        
        [tableView endUpdates];
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}




-(void)tableView:(UITableView *)tableView setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [tableView setEditing:editing animated:animated];
}




@end
