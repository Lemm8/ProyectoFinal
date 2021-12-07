import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';
import 'package:help_center/models/resena.dart';
import 'package:help_center/providers/providers.dart';
import 'package:help_center/screens/DatosGenerales.dart';
import 'package:help_center/widgets/widgets.dart';
import 'package:provider/provider.dart';



class ConsultorioScreen extends StatefulWidget {
  @override
  State<ConsultorioScreen> createState() => _ConsultorioScreenState();
}

enum _MenuValues{
  datosGenerales,
  eliminarCuenta,
  cerrarSesion,
}


class _ConsultorioScreenState extends State<ConsultorioScreen> {

  //List<Resena> resenas = [];

  Widget build(BuildContext context) {

   final Consultorio consultorio = ModalRoute.of(context)?.settings.arguments as Consultorio;
   final resenasProvider = Provider.of<ResenasProvider>( context );

    List<Resena> _getResenas(int consultorio_id) {
      resenasProvider.getResenasConsultorio(consultorio_id);
      //resenas = resenasProvider.resenas;
      return resenasProvider.resenas;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text('Inicio'),
        elevation: 0,
        actions: [
          Row(
            children: <Widget>[
              Icon( Icons.account_circle_outlined, size: 35.0, ),
              Text(' ${consultorio.nombre}', style: TextStyle( fontWeight: FontWeight.bold ),),
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
                          Navigator.of(context).pushNamed('datosGeneralesScreen', arguments: consultorio);
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
      body: SingleChildScrollView(
        //physics: ScrollPhysics(),
       // padding: EdgeInsets.symmetric( vertical: 20.0, horizontal: 20.0 ),
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
         // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Tipo de Consultorio: ${consultorio.tipo}',
              style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.blueGrey[300],
                  fontStyle: FontStyle.italic),),
            Container(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 5.0, 20.0),
                height: 160,
                width: 150,
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage('https://img.freepik.com/vector-gratis/gente-caminando-sentada-edificio-hospital-exterior-cristal-clinica-ciudad-ilustracion-vector-plano-ayuda-medica-emergencia-arquitectura-concepto-salud_74855-10130.jpg?size=626&ext=jpg'),
                  height: 100,
                  fit: BoxFit.cover,
                )
            ),
            Text('Consultorio',
              style: TextStyle(
                fontSize:28,
                height: 1.0,
                foreground: Paint()..style=PaintingStyle.stroke..strokeWidth=2..color=Colors.pinkAccent[700]!,),),
            Container(
               padding: EdgeInsets.only(left: 125.0),
              child:Row(
                children:[
                  Icon( Icons.check_circle, color: Colors.blue, size: 20.0,),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('${consultorio.nombre}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold),
                    ),
                  )

                ],
              )
            ),

            Center(
              child: Text('Top Reseñas',style: TextStyle( fontSize: 25.0, height: 4.0, fontWeight: FontWeight.bold)),
            ),
            ResenasConsultorio(resenas: _getResenas(consultorio.id_consultorio))
          ]
        ),
      ),
    );
  }
}

