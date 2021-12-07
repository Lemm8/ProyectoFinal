import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';
import 'package:help_center/providers/providers.dart';
import 'package:help_center/widgets/lista_consultorios.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PacienteScreen extends StatefulWidget {    
  @override
  State<PacienteScreen> createState() => _PacienteScreenState();
}

//enum

class _PacienteScreenState extends State<PacienteScreen> {


  String especialidad = '1';
  List<Especialidad> especialidades = [];  
  //String ip = '';


  getEspecialidades() async {
   final res = await http.get(Uri.parse('http://192.168.1.67:3000/especialidades'));
   Iterable jsonResponse = convert.jsonDecode(res.body);
   List<Especialidad> es = List<Especialidad>.from(jsonResponse.map((e) => Especialidad.fromJson(e)));
   setState(() {
     this.especialidades = es;
   });
  }

  @override
  void initState() {
    getEspecialidades();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {        
    
    final Paciente paciente = ModalRoute.of(context)?.settings.arguments as Paciente;

    final consultoriosProvider = Provider.of<ConsultoriosProvider>(context);    

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
              Text(' ${paciente.nombre}', style: TextStyle( fontWeight: FontWeight.bold ),),
              SizedBox(width: 10.0,)
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.settings, color:Colors.pink[100]),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('Ajustes'),
                      )
                    ],
                  )
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.offline_bolt, color:Colors.pink[100]),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('Eliminar Cuenta'),
                      )
                    ],
                  )
                ),
                PopupMenuItem(
                  child: Row(
                    children: [                      
                      Icon(Icons.logout, color:Colors.pink[100]),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('Cerrar Sesión'),
                      )
                    ],
                  )
                ),
              ],

              // onSelected: (value) {
              //   switch (value) {
              //     case :
                    
              //       break;
              //     default:
              //   }
              // },

              child: Icon(Icons.more_vert),
            )
          ),
        ]
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        padding: EdgeInsets.symmetric( horizontal: 20.0 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric( vertical: 30.0 ),
              child: _crearSearchBar(),
            ),
            _crearDropdown(paciente),
            Center(
              child: Text(
                'Consultorios Cerca',
                style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold ),
              )
            ),
            ListaConsultorios(consultorios: consultoriosProvider.consultorios, paciente: paciente)
          ]
        ),
      ),
    );
  }

  Widget _crearSearchBar() {
    return TextField(
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration( 
        //enabledBorder: OutlineInputBorder(border),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)          
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.pink[100]!)
        ),
        labelText: 'Buscar Consultorios',
        icon: Icon( Icons.search )
      ),
    );
  }



  List<DropdownMenuItem<String>> getOpcionesDropdown( ) {

   List<DropdownMenuItem<String>> lista = [];

    this.especialidades.forEach( ( especialidad ) { 
      lista.add( DropdownMenuItem(
        child: Text( especialidad.nombre ),
        value: especialidad.id_especialidad.toString(),
      ));
    });
    
    return lista;

  }
  

  Widget _crearDropdown( Paciente paciente ) {

    final consultoriosProvider = Provider.of<ConsultoriosProvider>(context);
    return Wrap(
      children: <Widget>[
        Row(
          children: [
            Icon(Icons.select_all),
            SizedBox(width: 5.0,),
            Text('Tipos de servicios',)
          ],
        ),        
        DropdownButton(      
          isExpanded: false,    
          items: getOpcionesDropdown(),
          value: this.especialidad,
          onChanged: (opt) {
            setState(() {
              this.especialidad = opt.toString();
              print(this.especialidad);
              if (this.especialidad == '1') {
                consultoriosProvider.mostrarConsultorios();
              } else if (this.especialidad == '2') {
                consultoriosProvider.mostrarConsultoriosInteres(paciente.id_paciente);
              } else {
                consultoriosProvider.mostrarConsultoriosServicios(int.parse(this.especialidad));
              }
            });
          },
        )
      ],
    );

  }

  

}