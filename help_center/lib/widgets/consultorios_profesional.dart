import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';
import 'package:help_center/providers/providers.dart';
import 'package:help_center/screens/consultorio_detalles_screen.dart';
import 'package:help_center/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ConsultoriosProfesional extends StatelessWidget {

  final List<Consultorio> consultorios;
  //final Profesional profesional;

  const ConsultoriosProfesional({ 
    Key? key ,
    required this.consultorios,
    //required this.profesional
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

    return Card(
      margin: EdgeInsets.symmetric( vertical: 15.0, horizontal: 25.0 ),
      elevation: 5.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
      
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, 'consultorioHomeScreen', arguments: consultorio);
        },
        child: Column(        
          children: <Widget>[
            Container(
              child: ListTile(
                leading: Icon( Icons.local_hospital, size: 40.0, ),
                title: Text('${consultorio.nombre}'),
              ),
            )            
          ],
        ),
      ),
    );
    
  }  

}
