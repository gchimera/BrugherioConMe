//
//  ComuneDetailViewController.m
//  BrugherioConMe
//
//  Created by Silvia Pessini on 27/09/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import "ComuneDetailViewController.h"
#import "ComuneCV.h"
@interface ComuneDetailViewController ()

@end

@implementation ComuneDetailViewController

@synthesize navigationPopoverController,tab,web1,web2,web3,web4,web5,web6,sel;

ComuneCV *_colorPicker;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction) showpopover:(id)sender{
    
    if (navigationPopoverController == nil) {
        //The color picker popover is not showing. Show it.
        navigationPopoverController = [[UIPopoverController alloc] initWithContentViewController:_colorPicker];
        [navigationPopoverController presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender
                                    permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    } else {
        //The color picker popover is showing. Hide it.
        [navigationPopoverController dismissPopoverAnimated:YES];
        navigationPopoverController = nil;
    }
    
    

}



-(void)Mostratesto : (NSString *) testo;
{
    tab.topItem.title=testo;
       [self tuttogiu];
    
    if ([testo isEqualToString:@"AMMINISTRAZIONE"]) {
        web1.hidden=FALSE;
    }
    
    if ([testo isEqualToString:@"BRUGHERIO IN CIFRE"]) {
        web2.hidden=FALSE;
    }
    
    if ([testo isEqualToString:@"CONTATTI E NUMERI UTILI"]) {
        web3.hidden=FALSE;
    }
    
    if ([testo isEqualToString:@"METEO"]) {
        web4.hidden=FALSE;
    }
    
//   if ([testo isEqualToString:@"STORIA"]) {
//        web5.hidden=FALSE;
//  }
//    
//    if ([testo isEqualToString:@"UFFICI COMUNALI"]) {
//        web6.hidden=FALSE;
//    }
    
          [self.navigationPopoverController dismissPopoverAnimated:YES];
    //navigationPopoverController = nil;


    
}


-(void) tuttogiu
{
    web1.hidden=TRUE;
    web2.hidden=TRUE;
    web3.hidden=TRUE;
    web4.hidden=TRUE;
    web4.hidden=TRUE;
    web5.hidden=TRUE;
    web6.hidden=TRUE;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:214.0/255 green:76.0/255 blue:91.0/255 alpha:1];
   
    self.title = NSLocalizedString(@"Brugherio", @"Brugherio");

    [self webUno];
    [self webDue];
    [self webTre];
    [self webQuattro];
   // [self webCinque];
    [self tuttogiu];
    
    
    if(sel != nil){
        [self Mostratesto:sel];

    }
    
    
  
    //_colorPicker= [[ComuneCV alloc]initWithNibName:@"ComuneVC_iphone" bundle:nil];
    // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Menu", @"Menu");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.navigationPopoverController = popoverController;
    
}


-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem   {
    aViewController.view.frame = CGRectMake(0, 0, 320, 320);
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    //[self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.navigationPopoverController = nil;
    
}



- (void)webUno
{
    NSString *myHTML = @"<html><body><div><h3>AMMINISTRAZIONE</h3><h5>Giunta</h5><p><strong>Sindaco</strong>: Antonio Marco Troiano</p><p><font color=\"#FF0000\">Deleghe:</font> <i>Sicurezza, Urbanistica,Comunicazione, Giovani e Sport</i></p><p><font color=\"#FF0000\"> Ricevimento: </font> Su appuntamento</p><p><font color=\"#FF0000\">Contatti:</font> <font color=\"#0000FF\">troiano@comune.brugherio.mb.it</font></p><p>Tel. 039.2893255336 </p><p><strong>Vicesindaco:</strong> Giovanna Borsotti</p><p><font color=\"#FF0000\">Deleghe:</font> <i>Politiche educative edIstituzionali</i></p><p><font color=\"#FF0000\">Ricevimento:</font> Martedì 15.00/17.00</p><p><font color=\"#FF0000\">Contatti:</font><font color=\"#0000FF\">borsotti@comune.brugherio.mb.it</font></p><p>Tel. 039.2893.255/336</p><p><strong>Assessore: Laura Giovanna Angela Valli</strong></p><p><font color=\"#FF0000\">Deleghe:</font> <i>Politiche culturali e partecipazione</i> </p><p><font color=\"#FF0000\">Ricevimento:</font> Mercoledì 14.00/16.00</p><p><font color=\"#FF0000\">Contatti:</font><font color=\"#0000FF\">valli@comune.brugherio.mb.it</font></p><p> Tel. 0392893361 </p><p><strong>Assessore:</strong> Graziano Maino</p><p><font color=\"#FF0000\">Deleghe:</font> <i>Politiche Finanziarie,Organizzazione e Personale</i> </p><p><font color=\"#FF0000\">Ricevimento:</font> Mercoledì 17.00/19.00    maino@comune.brugherio.mb.it</font></p><p>Tel. 039.2893.255/336 </p><p><font color=\"#FF0000\">Deleghe:</font> <i>Gestione del territorio</i></p><p><font color=\"#FF0000\">Ricevimento:</font>Ricevimento: Mercoledì17.30/19.00</p><p><font color=\"#FF0000\">Contatti:</font> <font color=\"#0000FF\">bertoni@comune.brugherio.mb.it</font></p><p>Tel. 039.2893239</p><p><strong> Assessore: Miriam Perego</strong></p><p><font color=\"#FF0000\"> Deleghe:</font> <i> Politiche Sociali</i><p><font color=\"#FF0000\"> Ricevimento:</font> Mercoledì 16.00/18.00 </p><p><font color=\"#FF0000\">Contatti:</font> <font color=\"#0000FF\">perego@comune.brugherio.mb.it</font></p><p>Tel. 039.2893306 </p></p><strong>Assessore: Marco Magni</strong></p><p><font color=\"#FF0000\">Deleghe:</font> <i>Sviluppo del territorio</i> </p><p><font color=\"#FF0000\">Ricevimento:</font> Mercoledì 10.00/12.00</p><p><font color=\"#FF0000\">Contatti:</font> <font color=\"#0000FF\">magni@comune.brugherio.mb.it</font></p><p>Tel. 039.2893286 </p></div><div><h3>CONSIGLIO COMUNALE</h3><h5>Maggioranza consiliare</h5><p><i>Partito Democratico:</i> Chirico Ambra,  Coduti Alessandra,  ColomboManuela Emilia, Lazzarini Valentina,  Livorno Carlo,  Minelli AnnaRita,  Pianezzi Germano,  Sacramento Paling Hans Peter, TeruzziAmbrogio, Virtuani Pietro Lorenzo</p><p><i>Brugherioè tua!:</i>Chirico Angelo, Recalcati Andreina</p><p><i>Sinistra Ecologia e Libertà:</i>Feraudi Francesca Barbara,Piserchia Antonio</p><p><h5>Minoranza consiliare</h5></p><p><i>Lega Nord:</i> Maurizio Ronchi</p><p><i>Ronchi Sindaco:</i> Bulzomì Michele, Pietropaolo Francesca</p><p><i>Progetto Brugherio Vincenzo Panza:</i> Annese Andrea Domenico, PanzaVincenzo</p><p><i>Movimento 5 Stelle:</i> Monachino Andrea</p><p><i>Uno Sguardo Oltre:</i> Nava Carlo Stefano Maria</p><p><i>Brugherio Popolare Europea - Unione di Centro, Fratelli d’Italia inalleanza con Resistenza Popolare: Assi Roberto</i>Assi Roberto</p><p><i>X Brugherio Max Balconi: </i>Balconi Massimiliano</p></div></body></html>";
    
    [web1 loadHTMLString:myHTML baseURL:nil];
    
}

- (void)webDue
{
    NSString *myHTML = @"<html><body><div><h3>INFO E CIFRE DI BRUGHERIO</h3><p><strong>Provincia:</strong>Monza e Brianza</p><p><strong>Comuni confinanti:</strong> Agrate Brianza, Carugate, Cernusco Sul Naviglio, Cologno Monzese, Monza,Sesto San Giovanni</p><p><strong>Festa patronale:</strong>Seconda Domenica di Ottobre</p><p><strong>Codice postale:</strong>20861</p><p><strong>Prefisso telefonico:</strong>039</p><p><strong> Altitudine:</strong>144 m s.l.m.</p><p><strong>Superficie: </strong>10.34 Km2</p><p><strong>Abitanti: </strong>33232</p><p><strong>Densità di popolazione: </strong>3214 ab/km2</p><p><strong> Codice ISTAT:</strong>108012</p><p><strong>Codice Catastale: </strong>B212</p><p><strong>Coordinate: </strong>45°33’3’’N 9°18’4’’E</p></div></body></html>";
    
    [web2 loadHTMLString:myHTML baseURL:nil];
    
}

- (void)webTre
{
    NSString *myHTML = @"<html><body>    <div><h3>CONTATTI E NUMERI UTILI</h3><h5>EMERGENZE</h5><p><strong>Ambulanza</strong></p><p><font color=\"#FF0000\">Telefono:</font>118</p><p><strong>Carabinieri</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Via Dante 34</p><p><font color=\"#FF0000\">Telefono:</font>112 - 039.870005</p><p><strong>Guardia di Finanza</strong></p><p><font color=\"#FF0000\">Telefono:</font>117</p><p><strong>Polizia di Stato</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Via Fiume 2 Sesto San Giovanni</p><p><font color=\"#FF0000\">Telefono:</font>113 - 02.2488211</p><p><strong>Soccorso Stradale</strong></p><p><font color=\"#FF0000\">Telefono:</font>116</p><p><strong>Vigili del Fuoco</strong></p><p><font color=\"#FF0000\">Telefono:</font>115</p><h5>SALUTE</h5><p><strong>ASL</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Viale Lombardia 270</p><p><font color=\"#FF0000\">Telefono:</font>039.2897418</p><p><strong>Croce Bianca</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Viale Brianza 8</p><p><font color=\"#FF0000\">Telefono:</font>039.2873606</p><p><strong>Croce Rossa Italiana</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Via Oberdan 83</p><p><font color=\"#FF0000\">Telefono:</font>039.884155</p><p><strong>Farmacia Comunale 1</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Piazza Giovanni XXIII</p><p><font color=\"#FF0000\">Telefono:</font>039.2873058</p><p><strong>Farmacia Comunale 2</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Piazza Togliatti 14/16</p><p><font color=\"#FF0000\">Telefono:</font>039.2873058</p><p><strong>Guardia Medica</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Via Oberdan 83</p><p><font color=\"#FF0000\">Telefono:</font>840500092</p><p><font color=\"#FF0000\">Orari:</font>Dal lunedì al venerdì 20.00/8.00</p><p><strong>Pronto Farmaco C.R.I.</strong></p><p><font color=\"#FF0000\">Telefono:</font>334.6962790</p><h3>SERVIZI AL CITTADINO</h3><p><strong>Amiacque</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Via Milano 3 - Cologno Monzese</p>    <p><font color=\"#FF0000\">Telefono:</font>02.895201</p><p><font color=\"#FF0000\">Orari:</font>Martedì 9.00/12.00</p><p><strong>Biblioteca Civica</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Via Italia 27</p><p><font color=\"#FF0000\">Telefono:</font>039.2893401</p><p><font color=\"#FF0000\">Orari:</font>Lunedì 9.00/12.30</p><p>Martedì, mercoledì, venerdì 9.00/12.30 + 14.00/19.00 </p><p>Giovedì 14.00/19.00</p><p>Sabato 9.00/12.30 + 14.00/18.00</p><p><strong>Centro Sportivo comunale</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Via San Giovanni Bosco</p><p><font color=\"#FF0000\">Telefono:</font>039.2873517</p><p><strong>ENEL Pronto Intervento</strong></p><p><font color=\"#FF0000\">Telefono:</font>numero verde 800900806</p><p><strong>Parrocchia di San Bartolomeo</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Piazza Roma 28</p><p><font color=\"#FF0000\">Telefono:</font>039.870002</p><p><strong>Parrocchia di San Carlo</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Via Pier Giorgio Frassati</p><p><font color=\"#FF0000\">Telefono:</font>039.883201</p><p><strong>Parrocchia di San Paolo Apostolo</strong></p><p><font color=\"#FF0000\">Indirizzo:</font> Piazza Don Camagni 1</p><p><font color=\"#FF0000\">Telefono:</font>039.2873463</p><p><strong>Piattaforma ecologica</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Via San Francesco d’Assisi</p><p><font color=\"#FF0000\">Telefono:</font>039.2871004</p><p><font color=\"#FF0000\">Orari:</font>Lunedì, martedì e giovedì 7.30/13.00</p><p>Mercoledì 14.30/18.00</p><p>Venerdì 7.30/13.00 + 14.00/17.00</p><p>Sabato 8.00/13.00 + 14.00/17.00</p><p><strong>Polizia locale</strong></p><p><font color=\"#FF0000\">Telefono:</font>039.870168</p><p><font color=\"#FF0000\">Orari:</font>Dal lunedì al sabato 7.30/19.00</p><p>Domenica e Festivi 9.30/12.30 + 14.30/17.30</p><p><strong>Poste Italiane</strong></p><p><font color=\"#FF0000\">Indirizzo:</font>Piazza Giovanni XXIII</p><p><font color=\"#FF0000\">Telefono:</font>039.289751</p><p><font color=\"#FF0000\">Indirizzo 2:</font>Via Della Vittoria 90</p><p><font color=\"#FF0000\">Telefono 2:</font>039.830329</p><p><strong>Protezione Civile</strong></p><p><font color=\"#FF0000\">Telefono:</font>334.8882734</p><p><strong>Taxi</strong></p><p><font color=\"#FF0000\">Telefono:</font>039.881081</p></div></body></html>";
    
    [web3 loadHTMLString:myHTML baseURL:nil];
    
}




- (void)webQuattro
{
    NSString *myHTML = @"<html><body><div><h3>Meteo</h3><p>Vuoi sapere che tempo ci sarà a Brugherio nei prossimi giorni? <a href=\"http://www.ilmeteo.it/meteo/Brugherio\" target=\"top\">Clicca qui:</a></p></div></body></html>";
    
    [web4 loadHTMLString:myHTML baseURL:nil];
    
}



- (void)webCinque
{
    NSString *myHTML = @"<html><body></body></html>";
    
    [web5 loadHTMLString:myHTML baseURL:nil];
    
}

//-(void)willRotateToInterfaceOrientation: (UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
//    
//    if ((orientation == UIInterfaceOrientationLandscapeLeft) || (orientation == UIInterfaceOrientationLandscapeRight)) {
//        [self.navigationPopoverController dismissPopoverAnimated:YES];
//        navigationPopoverController = nil;
//        
//
//    }
//}


-(void) viewDidAppear:(BOOL)animated
{
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {

    [self.navigationPopoverController presentPopoverFromRect:CGRectMake(0,0,1,1)inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

@end
