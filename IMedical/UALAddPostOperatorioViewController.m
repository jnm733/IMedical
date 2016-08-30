//
//  UALAddPostOperatorioViewController.m
//  IMedical
//
//  Created by Jose Luis on 8/29/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import "UALAddPostOperatorioViewController.h"
#import "GestorBD.h"

@interface UALAddPostOperatorioViewController ()

@property (weak, nonatomic) IBOutlet UISlider *tempInt;
@property (weak, nonatomic) IBOutlet UILabel *tempIntLabel;
@property (weak, nonatomic) IBOutlet UISlider *tempExt;
@property (weak, nonatomic) IBOutlet UILabel *tempExtLabel;
@property (weak, nonatomic) IBOutlet UILabel *comfortLabel;
@property (weak, nonatomic) IBOutlet UISlider *sistolica;
@property (weak, nonatomic) IBOutlet UILabel *sistolicaLabel;
@property (weak, nonatomic) IBOutlet UISlider *diastolica;
@property (weak, nonatomic) IBOutlet UILabel *diastolicaLabel;
@property (weak, nonatomic) IBOutlet UISlider *comfort;
@property (weak, nonatomic) IBOutlet UISegmentedControl *estTemp;
@property (weak, nonatomic) IBOutlet UISegmentedControl *estPresion;


@property (nonatomic, strong) GestorBD* gestorBD;
@property (nonatomic, strong) NSArray* arrayDatos;




- (IBAction)guardarDatos:(id)sender;
- (IBAction)intChange:(id)sender;
- (IBAction)extChange:(id)sender;
- (IBAction)sistolicaChange:(id)sender;
- (IBAction)diastolicaChange:(id)sender;
- (IBAction)comfortChange:(id)sender;


@end

@implementation UALAddPostOperatorioViewController

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
    self.gestorBD = [[GestorBD alloc]
                     initWithDatabaseFilename:@"imedicalF.sqlite"];
    self.title = [NSString stringWithFormat:@"Diagn. %@", self.dniPaciente];

    
    if(self.idDiagSelected != -1){
        NSString *consulta = [NSString stringWithFormat: @"select * from diagnostico_postoperatorio where id=%d",self.idDiagSelected];
        if (self.arrayDatos != nil) self.arrayDatos = nil;
        self.arrayDatos = [[NSArray alloc] initWithArray:[self.gestorBD
                                                          selectFromDB:consulta]];
        
        double tempInt = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:2]doubleValue];
        double tempExt = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:3]doubleValue];
        int sistolica = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:4]intValue];
        int diastolica = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:5]intValue];
        int comfort = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:6]intValue];
        int estPresion = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:7]intValue];
        int estTemp = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:8]intValue];
        
        self.tempIntLabel.text = [NSString stringWithFormat:@"%iºC",(int)tempInt];
        self.tempInt.value = tempInt;
        self.tempExtLabel.text = [NSString stringWithFormat:@"%iºC",(int)tempExt];
        self.tempExt.value = tempExt;
        self.sistolicaLabel.text = [NSString stringWithFormat:@"%i",sistolica];
        self.sistolica.value = sistolica;
        self.diastolicaLabel.text = [NSString stringWithFormat:@"%i",diastolica];
        self.diastolica.value = diastolica;
        self.comfortLabel.text = [NSString stringWithFormat:@"%i",comfort];
        self.comfort.value = comfort;
        
        self.estTemp.selectedSegmentIndex = estTemp;
        self.estPresion.selectedSegmentIndex = estPresion;


    }
}

- (IBAction) guardarDatos:(id) sender{
    
    NSString *consulta;
    NSInteger decision = 1;
    
    if (self.estTemp.selectedSegmentIndex == 2) {
        if (self.estPresion.selectedSegmentIndex == 0) {
            decision = 1;
        }else{
            decision = 2;
        }
    }else{
        if(self.tempInt.value > 37){
            if(self.tempExt.value > 36.5){
                decision = 3;
            }
        }
    }
    if(self.idDiagSelected == -1){
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *fecha = (@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    
    consulta = [NSString stringWithFormat: @"insert into diagnostico_postoperatorio values (null, '%@', %f,%f, %i, %i, %i, %i, %i, %i, %i)", fecha, self.tempInt.value, self.tempExt.value, (int)self.sistolica.value, (int)self.diastolica.value, (int)self.comfort.value, self.estPresion.selectedSegmentIndex,self.estTemp.selectedSegmentIndex, decision, self.idPaciente];
    }else{
        consulta = [NSString stringWithFormat:@"update diagnostico_postoperatorio set temperaturaInterna='%f', temperaturaSuperficial='%f', presionSistolica='%i', presionDiastolica='%i', comfort='%i',decision='%i', estabilidadPresionSang='%i',estabilidadTempInterna='%i' where id=%d", self.tempInt.value, self.tempExt.value, (int)self.sistolica.value, (int)self.diastolica.value, (int)self.comfort.value, decision,self.estPresion.selectedSegmentIndex, self.estTemp.selectedSegmentIndex, self.idDiagSelected];
    }
    
    [self.gestorBD executeQuery:consulta];
    if (self.gestorBD.filasAfectadas !=0){
        NSLog(@"Consulta ejecutada con ÉXITO...%d filas",
              self.gestorBD.filasAfectadas);
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate editionDidFinished];
    }
    else{
        NSLog(@"No se ha podido ejecutar la consulta...repásala...");
    }
}




- (IBAction)intChange:(id)sender {
    self.tempIntLabel.text =[NSString stringWithFormat:@"%iºC", (int)self.tempInt.value];
}

- (IBAction)extChange:(id)sender {
    self.tempExtLabel.text =[NSString stringWithFormat:@"%iºC", (int)self.tempExt.value];
}
  
  - (IBAction)sistolicaChange:(id)sender {
      self.sistolicaLabel.text =[NSString stringWithFormat:@"%i", (int)self.sistolica.value];

  }
- (IBAction)diastolicaChange:(id)sender {
    self.diastolicaLabel.text =[NSString stringWithFormat:@"%i", (int)self.diastolica.value];
    
}

- (IBAction)comfortChange:(id)sender {
    self.comfortLabel.text =[NSString stringWithFormat:@"%i", (int)self.comfort.value];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
