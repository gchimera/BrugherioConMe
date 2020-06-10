//
//  MapListViewController.m
//  GuidaBIO
//
//  Created by Silvia Pessini on 04/01/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import "MapListViewController.h"
#import "PuntoVendita.h"

@interface MapListViewController ()

@end

@implementation MapListViewController
@synthesize lista;

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
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    //return [appDelegate.EICAExpos count];
    return [lista count];
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
    
    PuntoVendita *curesp = [lista objectAtIndex:indexPath.row];
    
    if(UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
        
        cell.textLabel.font =[UIFont boldSystemFontOfSize:13];
    }
    
    cell.textLabel.text= curesp.titolo ;
    cell.detailTextLabel.text=curesp.IndirizzoCompletoUnariga;
    
    // cell.imageView.image=[UIImage imageNamed:@""];
    
    cell.accessoryType= UITableViewCellAccessoryNone;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width-50,0, 40, 20)];
    NSString *dist;
    
    if (curesp.distanza < 1){
        dist=[NSString stringWithFormat:@"%f m", curesp.distanza/100];
    }else{
        dist=[NSString stringWithFormat:@"%d Km", [NSNumber numberWithDouble:curesp.distanza].intValue];
    }

    [lab setText:dist];
    [lab setBackgroundColor:[UIColor yellowColor]];
    [lab setFont:[UIFont boldSystemFontOfSize:8]];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [cell.contentView addSubview:lab];
    
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
    cell.accessoryType= UITableViewCellAccessoryNone;
}



// Se selezioniamo una riga appare un pop-up con l'elemento in questione
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PuntoVendita *curid = (PuntoVendita *)[lista objectAtIndex:indexPath.row];
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop)];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    /*PVDetailController *EicaVC ;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        EicaVC= [[PVDetailController alloc]
                 initWithNibName:@"PVDetailController_iPad" bundle:nil];
    }else{
        EicaVC= [[PVDetailController alloc]
                 initWithNibName:@"PVDetailController_iPhone" bundle:nil];
    }
    
    
    
    EicaVC.CurPV = curid;
    
    [self.navigationController pushViewController:EicaVC animated:NO];
    
    [UIView setAnimationTransition:
     UIViewAnimationTransitionCurlDown
                           forView:self.navigationController.view cache:YES];
    
    
    
    [UIView commitAnimations];
     */
    
}


@end
