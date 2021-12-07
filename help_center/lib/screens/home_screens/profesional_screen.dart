import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';
import 'package:help_center/providers/providers.dart';
import 'package:help_center/widgets/consultorios_profesional.dart';
import 'package:provider/provider.dart';

enum _MenuValues{
  datosGenerales,
  eliminarCuenta,
  cerrarSesion,
}

class ProfesionalScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final Profesional profesional = ModalRoute.of(context)?.settings.arguments as Profesional;

    final consultoriosProvider = Provider.of<ConsultoriosProvider>(context);

    List<Consultorio> _getConsultorios(int id_profesional) {
      consultoriosProvider.mostrarConsultoriosProfesional(id_profesional);
      return consultoriosProvider.consultorios;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text('Profesional'),
        elevation: 0,
        actions: [
          Row(
            children: <Widget>[
              Icon( Icons.account_circle_outlined, size: 35.0, ),
              Text(' ${profesional.nombre}', style: TextStyle( fontWeight: FontWeight.bold ),),
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: PopupMenuButton<_MenuValues>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children:[
                          Icon(Icons.settings, color: Colors.black54),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('Datos Generales'),
                          ),
                        ],
                      ),
                      value:_MenuValues.datosGenerales,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children:[
                          Icon(Icons.offline_bolt, color: Colors.deepOrange),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('Eliminar Cuenta'),
                          ),
                        ],
                      ),
                      value:_MenuValues.eliminarCuenta,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children:[
                          Icon(Icons.logout, color: Colors.blueAccent),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text('Cerrar Sesión'),
                          ),
                        ],
                      ),
                      value:_MenuValues.cerrarSesion,
                    )
                  ],
                    onSelected: (value) {
                      switch (value) {
                        case _MenuValues.datosGenerales:
                          print('Datos');
                          //Navigator.of(context).pushNamed('datosGeneralesScreen', arguments: consultorio);
                          break;
                        case _MenuValues.eliminarCuenta:
                          print('Eliminar Cuenta');
                          break;
                        case _MenuValues.cerrarSesion:                          
                          Navigator.of(context).pop();
                          break;
                      }
                    },
                  child: Icon(Icons.more_vert),
                ),
              )
            ],
          )
          //Icon( Icons.circle_notifications_rounded )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text('Consultorios registrados'),
              padding: EdgeInsets.symmetric( vertical: 20.0 ),
            ),
            Container(
              child: Text('Seleccione el consultorio '),
              padding: EdgeInsets.symmetric( vertical: 20.0 ),
            ),
            ConsultoriosProfesional(consultorios: _getConsultorios(profesional.id_profesional))
          ],
        ),        
      ),
    );
  }
}