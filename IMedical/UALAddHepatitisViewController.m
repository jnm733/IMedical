//
//  UALAddHepatitisViewController.m
//  IMedical
//
//  Created by Jose Luis on 8/29/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import "UALAddHepatitisViewController.h"
#import "GestorBD.h"

@interface UALAddHepatitisViewController ()

@property (weak, nonatomic) IBOutlet UISlider *edad;
@property (weak, nonatomic) IBOutlet UISwitch *sexo;
@property (weak, nonatomic) IBOutlet UISwitch *ascitis;
@property (weak, nonatomic) IBOutlet UISlider *albumina;
@property (weak, nonatomic) IBOutlet UISwitch *spiders;
@property (weak, nonatomic) IBOutlet UISlider *sgot;
@property (weak, nonatomic) IBOutlet UISwitch *agrand;
@property (weak, nonatomic) IBOutlet UISwitch *firm;
@property (weak, nonatomic) IBOutlet UILabel *edadLabel;
@property (weak, nonatomic) IBOutlet UILabel *albuLabel;
@property (weak, nonatomic) IBOutlet UILabel *sgotLabel;

@property (nonatomic, strong) NSArray* arrayDatos;
@property (nonatomic, strong) GestorBD* gestorBD;


- (IBAction)guardarDatos:(id)sender;
- (IBAction)edadChange:(id)sender;
- (IBAction)albuChange:(id)sender;
- (IBAction)sgotChange:(id)sender;

@end

@implementation UALAddHepatitisViewController

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
                     initWithDatabaseFilename:@"imedicalFinal.sqlite"];
    self.title = [NSString stringWithFormat:@"Diagn. %@", self.dniPaciente];
    if (self.idDiagSelected != -1) {
        NSString *consulta = [NSString stringWithFormat: @"select * from diagnostico_hepatitis where id=%d",self.idDiagSelected];
        if (self.arrayDatos != nil) self.arrayDatos = nil;
        self.arrayDatos = [[NSArray alloc] initWithArray:[self.gestorBD
                                                          selectFromDB:consulta]];
        
        int edad = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:1]intValue];
        int sexo = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:2]intValue];
        int ascitis = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:4]intValue];
        int spiders = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:5]intValue];
        double albumina = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:6]doubleValue];
        int sgot = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:7]intValue];
        int agrand = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:8]intValue];
        int firm = [[[self.arrayDatos objectAtIndex:0] objectAtIndex:9]intValue];


        
        self.edadLabel.text = [NSString stringWithFormat:@"%i",(int)edad];
        self.edad.value = edad;
        self.albuLabel.text = [NSString stringWithFormat:@"%f",albumina];
        self.albumina.value = albumina;
        self.sgotLabel.text = [NSString stringWithFormat:@"%i",(int)sgot];
        self.sgot.value = sgot;
        
        if (sexo != 1) [self.sexo setOn:NO animated:YES];
        if (ascitis != 1) [self.ascitis setOn:NO animated:YES];
        if (spiders != 1) [self.spiders setOn:NO animated:YES];
        if (agrand != 1) [self.agrand setOn:NO animated:YES];
        if (firm != 1) [self.firm setOn:NO animated:YES];


    
    }
}

- (IBAction) guardarDatos:(id) sender{
    
    NSString *consulta;
    NSInteger diagnostico;
    if(![self.ascitis isOn]){
        if (![self.spiders isOn]) {
            diagnostico = 0;
        }else{
            if (![self.sexo isOn]) {
                diagnostico = 0;
            }else{
                if (![self.firm isOn]) {
                    if (self.edad.value <= 40) {
                        diagnostico = 0;
                        
                    }else{
                        diagnostico = 1;
                    }
                }else{
                    if (self.sgot.value <= 101) {
                        diagnostico = 0;
                    }else{
                        if (![self.agrand isOn]) {
                            diagnostico = 1;
                        }else{
                            diagnostico = 0;
                        }
                    }
                }
            }
        }
    }else{
        if (self.albumina.value <= 2.8) {
            diagnostico = 1;
        }else{
            if (![self.firm isOn]) {
                if (self.albumina.value <= 2.9) {
                    diagnostico = 0;
                }else {
                    diagnostico = 1;
                }
            }else{
                diagnostico = 0;
            }
        }
    }
    NSInteger sexo = 0;
    if ([self.sexo isOn]) sexo = 1;
    NSInteger ascitis = 0;
    if ([self.ascitis isOn]) ascitis = 1;
    NSInteger agrand = 0;
    if ([self.agrand isOn]) agrand = 1;
    NSInteger firm = 0;
    if ([self.firm isOn]) firm = 1;
    NSInteger spiders = 0;
    if ([self.spiders isOn]) spiders = 1;

    if(self.idDiagSelected == -1){
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *fecha = ([NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]]);

        consulta = [NSString stringWithFormat: @"insert into diagnostico_hepatitis values (null, %i, %i,'%@', %i, %i, %f, %i, %i, %i, %i, %i)", (int)self.edad.value, sexo, fecha, ascitis, spiders, self.albumina.value, (int)self.sgot.value, agrand, firm, diagnostico, self.idPaciente];
        
    }else{
        consulta = [NSString stringWithFormat:@"update diagnostico_hepatitis set edad='%i', sexo='%i', ascitis='%i', spiders='%i', albumina='%f', sgot='%i', agrandamientoHigado='%i', firmHigado='%i', diagnostico='%i' where id=%d", (int)self.edad.value, sexo, ascitis, spiders, self.albumina.value, (int)self.sgot.value, agrand, firm, diagnostico, self.idDiagSelected];
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

- (IBAction)edadChange:(id)sender {
    self.edadLabel.text = [NSString stringWithFormat:@"%i", (int)self.edad.value];
}

- (IBAction)albuChange:(id)sender {
    self.albuLabel.text = [NSString stringWithFormat:@"%f", self.albumina.value];
}

- (IBAction)sgotChange:(id)sender {
    self.sgotLabel.text = [NSString stringWithFormat:@"%i", (int)self.sgot.value];
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
