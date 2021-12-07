import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';

class DatosGenerales extends StatefulWidget {
  @override
  State<DatosGenerales> createState() => _DatosScreenState();
}

class _DatosScreenState extends State<DatosGenerales> {
  Widget build(BuildContext context) {
    final Consultorio consultorio = ModalRoute
        .of(context)
        ?.settings
        .arguments as Consultorio;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text('Datos Generales'),
        elevation: 0,
        actions: [
          Row(
            children: <Widget>[
              Icon(Icons.account_circle_outlined, size: 35.0,),
              Text(' ${consultorio.nombre}',
                style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Correo: ${consultorio.correo}', textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),),
              Text('Telefono: ${consultorio.telefono}',
                style: TextStyle(fontWeight: FontWeight.bold),),

              Center(child: Text('Información De Usuario', style: TextStyle(
                  fontSize: 20.0, fontWeight: FontWeight.bold),)),
            ]
        ),
      ),
    );
  }
}



