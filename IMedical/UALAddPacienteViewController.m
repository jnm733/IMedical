//
//  UALAddPacienteViewController.m
//  IMedical
//
//  Created by Jose Luis on 8/27/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import "UALAddPacienteViewController.h"
#import "GestorBD.h"

@interface UALAddPacienteViewController ()

- (IBAction)ocultarTeclado:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nombre;
@property (weak, nonatomic) IBOutlet UITextField *apellidos;
@property (weak, nonatomic) IBOutlet UITextField *dni;
@property (weak, nonatomic) IBOutlet UIDatePicker *fechaNacimiento;
@property (weak, nonatomic) IBOutlet UITextField *numSegSocial;
@property (nonatomic, strong) GestorBD* gestorBD;

@end

@implementation UALAddPacienteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) guardarDatos:(id) sender{
    
    NSDateFormatter *fecha = [[NSDateFormatter alloc] init];
    [fecha setDateFormat:@"dd-MM-yyyy"];
    NSString *theDate = [fecha stringFromDate:self.fechaNacimiento.date];
    NSString *consulta;
    if(self.idPacienteEdit == -1){
        consulta = [NSString stringWithFormat: @"insert into paciente values (null, '%@','%@','%@', '%@', '%@', '%i')", self.nombre.text, self.apellidos.text, self.dni.text, theDate, self.numSegSocial.text, self.idHospital];
    }else{
        consulta = [NSString stringWithFormat:@"update paciente set nombre='%@', apellidos='%@', dni='%@', numSegSocial='%@' where id=%d", self.nombre.text, self.apellidos.text, self.dni.text, self.numSegSocial.text, self.idPacienteEdit];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gestorBD = [[GestorBD alloc]
                     initWithDatabaseFilename:@"imedical.sqlite"];
    if(self.idPacienteEdit == -1) {
        self.title = [NSString stringWithFormat:@"Nuevo Paciente %@", self.nombreHospital];
        
        
    }else{
        self.title = [NSString stringWithFormat:@"%@, %@", self.nombrePacienteEdit, self.dniPacienteEdit];
        self.nombre.text = self.nombrePacienteEdit;
        self.apellidos.text = self.apellidosPacienteEdit;
        self.dni.text = self.dniPacienteEdit;
        self.numSegSocial.text = self.numSegSocialPacienteEdit;
        
        NSDateFormatter *fecha = [[NSDateFormatter alloc] init];
        [fecha setDateFormat:@"dd-MM-yyyy"];
        NSDate *theDate = [fecha dateFromString: self.fechaNacimientoPacienteEdit];
        [self.fechaNacimiento setDate:theDate];
    }


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

- (IBAction)ocultarTeclado:(id)sender {
}
@end
