import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help_center/providers/providers.dart';
import 'package:provider/provider.dart';

class RegistroConsultorio extends StatefulWidget {

  const RegistroConsultorio({ Key? key }) : super(key: key);

  @override
  _RegistroConsultorioState createState() => _RegistroConsultorioState();
}

class _RegistroConsultorioState extends State<RegistroConsultorio> {

  String _nombre = '';
  String _correo = '';
  String _telefono = '';
  String _contrasena = '';
  String _direccion = '';


  List _tipoOpciones = ['Tipo I', 'Tipo II', 'Tipo III'];
  String _opcionDefault = 'Tipo I';


  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>( context );

    return ListView(       
      shrinkWrap: true,          
      children: [
        Container(
          alignment: Alignment.center,
          child: Text('Crea tu cuenta llenando los siguientes campos', style: TextStyle(fontWeight: FontWeight.bold))
        ),
        Divider(),
        _crearNombre(),
        Divider(),
        _crearTelefono(),
        Divider(),
        _crearDireccion(),
        Divider(),
        _crearEmail(),
        Divider(),
        _crearPassword('Contraseña', 'Contraseña'),
        Divider(),
        // _crearPassword('Confirmar Contraseña', 'Confirmar Contraseña'),
        // Divider(),
        _crearDropdown(),
        Divider(),
        ElevatedButton(
          onPressed: () async {
            var response = await authProvider.registroConsultorio(_nombre, _correo, _telefono, _contrasena, _direccion, _opcionDefault);
            if(response != false) {
              Navigator.pushNamed(context, 'consultorioHomeScreen', arguments: authProvider.consultorio);
            } else {
              mostrarAlert();
            }
          },
          child: Text('Registrar'),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
          )     
        ), 
      ],
    );
  }  

  Widget _crearNombre() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration( 
        //enabledBorder: OutlineInputBorder(border),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)          
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.pink[100]!)
        ),
        hintText: 'Nombre del consultorio',
        labelText: 'Consultorio',
        suffixIcon: Icon( Icons.local_hospital ),
        icon: Icon( Icons.health_and_safety_rounded )
      ),
      onChanged: (valor) {
        setState(() {          
          _nombre = valor;
        });
      },
    );
  }


  Widget _crearTelefono() {
    return TextField(
      //autofocus: true,
      textCapitalization: TextCapitalization.characters,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      decoration: InputDecoration( 
        //enabledBorder: OutlineInputBorder(border),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)          
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.pink[100]!)
        ),
        hintText: 'Teléfono del consultorio',
        labelText: 'Teléfono',
        suffixIcon: Icon( Icons.phone ),
        icon: Icon( Icons.phone_callback )
      ),
      onChanged: (valor) {
        setState(() {          
          _telefono = valor;
        });
      },
    );
  }


    Widget _crearDireccion() {
    return TextField(
      //autofocus: true,
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
        hintText: 'Dirección del consultorio',
        labelText: 'Dirección',
        suffixIcon: Icon( Icons.location_on ),
        icon: Icon( Icons.location_city )
      ),
      onChanged: (valor) {
        setState(() {          
          _direccion = valor;
        });
      },
    );
  }


  Widget _crearEmail() {

    return TextField(
      keyboardType: TextInputType.emailAddress,      
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.pink[100]!)
        ),     
        hintText: 'Email',
        labelText: 'Email',
        suffixIcon: Icon( Icons.alternate_email ),        
        icon: Icon( Icons.email,  )
      ),
      onChanged: (valor) => setState(() {
        _correo = valor;
      }),
    ); 

  }


  

  Widget _crearPassword(String hintText, String labelText) {
    return TextField(
      obscureText: true,      
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.pink[100]!)
        ),  
        hintText: '$hintText',
        labelText: '$labelText',
        suffixIcon: Icon( Icons.lock_open, ),        
        icon: Icon( Icons.lock, ),        
      ),
      onChanged: (valor) => setState(() {
        _contrasena = valor;
      }),
    ); 
  }




  List<DropdownMenuItem<String>> getOpcionesDropdown() {

    List<DropdownMenuItem<String>> lista = [];

    _tipoOpciones.forEach( ( tipo ) { 

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
          value: _opcionDefault,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _opcionDefault = opt.toString();
            });
          },
        )
      ],
    );
    
    
  }

  void mostrarAlert() {
    showDialog(
      context: context, 
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
          title: Text('Error al ingresar'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('El correo o contraseña son incorrectos'),
              Icon( Icons.error_outline_rounded )
            ],
          ),
          actions: [
            TextButton(
              child: Text('Volver a intentar'),
              onPressed: () => Navigator.of(context).pop(),               
            )
          ],
        );
      }
    );
  }
  
}