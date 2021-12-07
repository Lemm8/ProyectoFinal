import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';
import 'package:help_center/providers/providers.dart';
import 'package:help_center/screens/consultorio_detalles_screen.dart';
import 'package:help_center/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ListaConsultorios extends StatelessWidget {

  final List<Consultorio> consultorios;
  final Paciente paciente;

  const ListaConsultorios({ 
    Key? key ,
    required this.consultorios,
    required this.paciente
  }) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {    
    
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,              
      itemCount: this.consultorios.length,      
      itemBuilder: ( _, int index ) => _listaConsultorios( context, this.consultorios[index] )
    );
  }


  Widget _listaConsultorios(BuildContext context, Consultorio consultorio) { 

    Future<bool> _getInteresPacienteConsultorio( int id_paciente, int id_consultorio ) async {
      final res = await http.get(
        Uri.parse('http://192.168.1.67:3000/interes_paciente_consultorio/${id_paciente}/${id_consultorio}')
      );
      bool jsonResponse = await convert.jsonDecode(res.body);
      return jsonResponse;
    }

    return Card(
      margin: EdgeInsets.symmetric( vertical: 15.0 ),
      elevation: 5.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
      
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'consultorioDetallesScreen', arguments: ScreenArguments(consultorio, paciente));
        },
        child: Column(        
          children: <Widget>[
            ListTile(
              leading: Icon( Icons.photo_album, size: 40.0, ),
              title: Text('${consultorio.nombre}'),
              subtitle: Text('${consultorio.correo} \n${consultorio.telefono}'),
              isThreeLine: true,
              trailing: Column(
                children: [
                  Wrap(
                    children: [
                      IconButton(icon: Icon( Icons.location_on, size: 30.0, ), onPressed: (){},),
                      FutureBuilder(
                        future: _getInteresPacienteConsultorio(paciente.id_paciente, consultorio.id_consultorio),
                        builder: ( _, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.data == true) {
                            return IconoInteres(interes: true, paciente: paciente, consultorio: consultorio);
                          } else {
                            return IconoInteres(interes: false, paciente: paciente, consultorio: consultorio);
                          }                          
                        }
                      ),
                    ]
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    
  }  

}
