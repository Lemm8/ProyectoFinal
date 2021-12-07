import 'package:flutter/material.dart';
import 'package:help_center/widgets/widgets.dart';


class RegistroScreen extends StatefulWidget {
  static final pageName = 'inputs';

  @override
  _InputPageStateState createState() => _InputPageStateState();
}

class _InputPageStateState extends State<RegistroScreen> {

  String _opcionSeleccionada = 'Paciente';

  List _tiposUsuario = ['Paciente', 'Consultorio', 'Profesional'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(        
              margin: EdgeInsets.only( bottom: 20 ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tipo de usuario'),
                    _crearDropdown()
                  ],
                ),
              )
            ),            
            if (_opcionSeleccionada == 'Paciente')
            Flexible(
              child: RegistroPaciente(),
            )
            else if (_opcionSeleccionada == 'Consultorio')
            Flexible(
              child: RegistroConsultorio(),
            )
            else if (_opcionSeleccionada == 'Profesional')
            Flexible(
              child: RegistroProfesional(),
            )
            else
            Flexible(
              child: RegistroPaciente(),
            )
          ],
        )

            
            //if (_opcionSeleccionada == 'Paciente') RegistroPaciente()            
            //else Text('Otra opción')            
            // _crearFecha(context),
            // Divider(),
            // _crearDropdown(),
            // Divider(),
            // _crearPersona(),                    
      ),
    );
  }  

  List<DropdownMenuItem<String>> getOpcionesDropdown() {

    List<DropdownMenuItem<String>> lista = [];

    _tiposUsuario.forEach( ( tipo ) { 

      lista.add( DropdownMenuItem(
        child: Text(tipo),
        value: tipo,
      ));

    });
    
    return lista;

  }

  Widget _crearDropdown() {

    return Row(
      children: <Widget>[
        Icon(Icons.select_all),
        SizedBox(width: 30.0),        
        DropdownButton(
          value: _opcionSeleccionada,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _opcionSeleccionada = opt.toString();
            });
          },
        )
      ],
    );
    
    
  }
}
