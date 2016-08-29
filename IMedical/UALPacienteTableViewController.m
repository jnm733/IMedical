//
//  UALPacienteTableViewController.m
//  IMedical
//
//  Created by Jose Luis on 8/27/16.
//  Copyright (c) 2016 Jose Luis Navarro Motos. All rights reserved.
//

#import "UALPacienteTableViewController.h"
#import "GestorBD.h"
#import "UALAddPacienteViewController.h"
#import "UALPacienteDetalleViewController.h"

@interface UALPacienteTableViewController ()

@property (nonatomic, strong) GestorBD* gestorBD;
@property (nonatomic, strong) NSArray* arrayDatos;

@property (nonatomic) int idPacienteSelected;
@property (nonatomic) NSString* nombrePacienteSelected;
@property (nonatomic) NSString* apellidosPacienteSelected;
@property (nonatomic) NSString* dniPacienteSelected;
@property (nonatomic) NSString* fechaNacimientoPacienteSelected;
@property (nonatomic) NSString* numSegSocialPacienteSelected;



@end

@implementation UALPacienteTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabla.delegate = self;
    self.tabla.dataSource = self;
    self.gestorBD = [[GestorBD alloc] initWithDatabaseFilename:@"imedical.sqlite"];
    self.title = [NSString stringWithFormat:@"Pacientes %@", self.nombreHospital];

    [self cargarDatos];


}

-(void) cargarDatos{
    NSString *consulta = [NSString stringWithFormat: @"select * from paciente where HOSPITAL_id=%d",self.idHospital];
    if (self.arrayDatos != nil) self.arrayDatos = nil;
    self.arrayDatos = [[NSArray alloc] initWithArray:[self.gestorBD
                                                      selectFromDB:consulta]];
    //actualizamos la tabla
    [self.tabla reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"addPaciente"]){
        UALAddPacienteViewController* destino = [segue destinationViewController];
        destino.idHospital = self.idHospital;
        destino.nombreHospital = self.nombreHospital;
        destino.idPacienteEdit = -1;
        destino.delegate = self;
        
    }else if ([segue.identifier isEqualToString:@"editPaciente"]){
        UALAddPacienteViewController* destino = [segue destinationViewController];
        destino.idHospital = self.idHospital;
        destino.nombreHospital = self.nombreHospital;
        destino.delegate = self;
        destino.idPacienteEdit = self.idPacienteSelected;
        destino.nombrePacienteEdit = self.nombrePacienteSelected;
        destino.apellidosPacienteEdit = self.apellidosPacienteSelected;
        destino.dniPacienteEdit = self.dniPacienteSelected;
        destino.fechaNacimientoPacienteEdit = self.fechaNacimientoPacienteSelected;
        destino.numSegSocialPacienteEdit = self.numSegSocialPacienteSelected;
        
    }else if ([segue.identifier isEqualToString:@"detallePaciente"]){
        UALPacienteDetalleViewController* destino = [segue destinationViewController];
        destino.idHospital = self.idHospital;
        destino.nombreHospital = self.nombreHospital;
        destino.idPaciente = self.idPacienteSelected;
        destino.nombrePaciente = self.nombrePacienteSelected;
        destino.apellidosPaciente = self.apellidosPacienteSelected;
        destino.dniPaciente = self.dniPacienteSelected;
        destino.fechaNacimientoPaciente = self.fechaNacimientoPacienteSelected;
        destino.numSegSocialPaciente = self.numSegSocialPacienteSelected;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indexOfId = [self.gestorBD.arrNombresCols indexOfObject:@"id"];
    NSInteger indexOfNombre = [self.gestorBD.arrNombresCols indexOfObject:@"nombre"];
    NSInteger indexOfApellidos = [self.gestorBD.arrNombresCols indexOfObject:@"apellidos"];
    NSInteger indexOfDNI = [self.gestorBD.arrNombresCols indexOfObject:@"dni"];
    NSInteger indexOffecha = [self.gestorBD.arrNombresCols indexOfObject:@"fechaNacimiento"];
    NSInteger indexOfSegSocial = [self.gestorBD.arrNombresCols indexOfObject:@"numSegSocial"];


    
    
    
    self.idPacienteSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfId]intValue];
    self.nombrePacienteSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfNombre]];
    self.apellidosPacienteSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfApellidos]];
    self.fechaNacimientoPacienteSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOffecha]];
    self.dniPacienteSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfDNI]];
    self.numSegSocialPacienteSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfSegSocial]];
    
    
    [self performSegueWithIdentifier:@"detallePaciente" sender:self];
    
}
-(void) editionDidFinished{
    [self cargarDatos];
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int idRegistro;
    NSString *consulta;
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        idRegistro = [[[self.arrayDatos objectAtIndex:indexPath.row]
                       objectAtIndex:0]intValue];
        consulta = [NSString stringWithFormat:@"delete from paciente where id=%d",idRegistro];
        
        [self.gestorBD executeQuery:consulta];
        [self cargarDatos];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arrayDatos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pacientesCell" forIndexPath:indexPath];
    
    NSInteger indexOfNombre = [self.gestorBD.arrNombresCols indexOfObject:@"nombre"];
    NSInteger indexOfApellidos = [self.gestorBD.arrNombresCols indexOfObject:@"apellidos"];
    NSInteger indexOfDni = [self.gestorBD.arrNombresCols indexOfObject:@"dni"];
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ , %@", [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfApellidos]], [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfNombre]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfDni]];
    
    return cell;
}

-(void) tableView: (UITableView *) tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *)indexPath{
    NSInteger indexOfId = [self.gestorBD.arrNombresCols indexOfObject:@"id"];
    NSInteger indexOfNombre = [self.gestorBD.arrNombresCols indexOfObject:@"nombre"];
    NSInteger indexOfApellidos = [self.gestorBD.arrNombresCols indexOfObject:@"apellidos"];
    NSInteger indexOfDNI = [self.gestorBD.arrNombresCols indexOfObject:@"dni"];
    NSInteger indexOfFecha = [self.gestorBD.arrNombresCols indexOfObject:@"fechaNacimiento"];
    NSInteger indexOfSegSocial = [self.gestorBD.arrNombresCols indexOfObject:@"numSegSocial"];


    
    
    
    self.idPacienteSelected = [[[self.arrayDatos objectAtIndex:indexPath.row] objectAtIndex:indexOfId]intValue];
    self.nombrePacienteSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfNombre]];
    self.apellidosPacienteSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfApellidos]];
    self.dniPacienteSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfDNI]];
    self.fechaNacimientoPacienteSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfFecha]];
    self.numSegSocialPacienteSelected = [NSString stringWithFormat:@"%@", [[self.arrayDatos objectAtIndex: indexPath.row] objectAtIndex:indexOfSegSocial]];
    
    [self performSegueWithIdentifier:@"editPaciente" sender:self];
    
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
