import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';
import 'package:help_center/models/resena.dart';
import 'package:help_center/providers/providers.dart';
import 'package:help_center/widgets/boton_interes.dart';
import 'package:help_center/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

// import 'dart:convert' as convert;

// import 'package:http/http.dart' as http;

class ScreenArguments {
  final Consultorio consultorio;
  final Paciente paciente;

  ScreenArguments(this.consultorio, this.paciente);
}

class ConsultorioDetallesScreen extends StatefulWidget {
  const ConsultorioDetallesScreen({Key? key}) : super(key: key);

  @override
  State<ConsultorioDetallesScreen> createState() => _ConsultorioDetallesScreenState();
}

class _ConsultorioDetallesScreenState extends State<ConsultorioDetallesScreen> {  

  @override
  Widget build(BuildContext context) {         

    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;  

    final especialidadesProvider = Provider.of<EspecialidadesProvider>(context);
    final resenasProvider = Provider.of<ResenasProvider>(context);

    List<Especialidad> _getEspecialidadesConsultorio(int consultorio_id) {
      especialidadesProvider.getEspecialidadesConsultorio(consultorio_id);
      return especialidadesProvider.consultorio_especialidades;
    } 

    List<Resena> _getResenas(int consultorio_id) {
      resenasProvider.getResenasConsultorio(consultorio_id);
      return resenasProvider.resenas;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Detalles'),
        elevation: 0,
        actions: [
          Row(
            children: <Widget>[
              Icon( Icons.account_circle_outlined, size: 35.0, ),
              Text(' ${args.paciente.nombre}', style: TextStyle( fontWeight: FontWeight.bold ),),                           
              SizedBox(width: 10.0,)
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(        
          children: [
            _InfoPrincipal(args.consultorio),
            ListaEspecialidadesConsultorio(especialidades:  _getEspecialidadesConsultorio(args.consultorio.id_consultorio)),
            Center(child: _InfoSecundaria(args.consultorio, args.paciente)),
            ListaResenas(
              resenas: _getResenas(args.consultorio.id_consultorio), 
              id_consultorio: args.consultorio.id_consultorio, 
              id_paciente: args.paciente.id_paciente
            )
          ],
        ),
      ),
    );    

  }
}


// IMAGEN E INFO PRINCIPAL
class _InfoPrincipal extends StatelessWidget {

  final Consultorio consultorio;

  const _InfoPrincipal( this.consultorio );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 20.0),
          height: 250,
          width: 200,
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage('https://img.freepik.com/vector-gratis/gente-caminando-sentada-edificio-hospital-exterior-cristal-clinica-ciudad-ilustracion-vector-plano-ayuda-medica-emergencia-arquitectura-concepto-salud_74855-10130.jpg?size=626&ext=jpg'),
            height: 150,
            fit: BoxFit.cover,
          )
        ),
        Flexible(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric( vertical: 20.0, horizontal: 20.0 ),
                child: Text(
                  '${ consultorio.nombre }',
                  style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold ),
                  overflow: TextOverflow.ellipsis, maxLines: 3,
                )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                child: Text(
                  '${ consultorio.correo }',
                  style: TextStyle( fontSize: 15.0, color: Colors.pink[100] ),
                  overflow: TextOverflow.ellipsis, maxLines: 3,
                )
              )
            ],
          ),
        )
      ]
    );
  }
}




// INFO SECUNDARIA
class _InfoSecundaria extends StatelessWidget {

  final Consultorio consultorio;
  final Paciente paciente;

  const _InfoSecundaria( this.consultorio, this.paciente );

  @override
  Widget build(BuildContext context) {    

    final interesProvider = Provider.of<InteresProvider>(context);  
    final resenasProvider = Provider.of<ResenasProvider>(context);

    bool getInteres() {
      interesProvider.getInteresPacienteConsultorio(paciente.id_paciente, consultorio.id_consultorio);
      return interesProvider.interes_consultorio_paciente;
    }

    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(height: 30.0,),
          Text('Contacto', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20.0 ),),
          SizedBox(height: 15.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon( Icons.phone, size: 30.0 ),
              GestureDetector(
                onTap: (){
                  urlLauncher.launch("tel://${consultorio.telefono}");
                },
                child: Text('${consultorio.telefono}', style: TextStyle( fontSize: 20.0, decoration: TextDecoration.underline )),                
              )
            ]
          ), 
          SizedBox(height: 30.0,),
          Text('Dirección', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20.0 ),),
          SizedBox(height: 15.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon( Icons.location_on, size: 30.0, ),
              Text('${consultorio.direccion}', style: TextStyle( fontSize: 20.0 ))
            ]
          ),          
          SizedBox(height: 35.0,), 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BotonInteres(
                interes: getInteres(),
                paciente: paciente,
                consultorio: consultorio,
              ),
              SizedBox(width: 15.0,),
              ElevatedButton.icon(
                onPressed: (){
                  _launchEmail(consultorio.correo);
                }, 
                icon: Icon( Icons.email_outlined ), 
                label: Text('Enviar correo'),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ) 
              ),
            ],
          ),          
        ]
      ),
    );
  }

  _launchEmail(String consultorio_correo) async {

    final url = 'mailto:${consultorio_correo}?';

    if( await urlLauncher.canLaunch(url)) {
      await urlLauncher.launch(url);
    }
  }

}