import 'package:flutter/material.dart';
import 'package:help_center/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class RegistroPaciente extends StatefulWidget {

  const RegistroPaciente({ Key? key }) : super(key: key);

  @override
  _RegistroPacienteState createState() => _RegistroPacienteState();
}

class _RegistroPacienteState extends State<RegistroPaciente> {

  String _nombre = '';
  String _apellidos = '';
  String _correo = '';
  String _contrasena = '';    

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
        _crearApellido(),
        Divider(),
        _crearEmail(),
        Divider(),
        _crearPassword('Contraseña', 'Contraseña'),
        Divider(),
        _crearPassword('Confirmar Contraseña', 'Confirmar Contraseña'),
        Divider(),
        ElevatedButton(
          onPressed: () async {
            var response = await authProvider.registroPaciente(_nombre, _apellidos, _correo, _contrasena);
            if(response != false) {
              Navigator.pushNamed(context, 'pacienteHomeScreen', arguments: authProvider.paciente);
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
        hintText: 'Nombre de la persona',
        labelText: 'Nombre',
        suffixIcon: Icon( Icons.accessibility ),
        icon: Icon( Icons.account_circle, )
      ),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }


  Widget _crearApellido() {
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
        hintText: 'Apellidos del paciente',
        labelText: 'Apellidos',
        suffixIcon: Icon( Icons.accessibility ),
        icon: Icon( Icons.account_circle, )
      ),
      onChanged: (valor) {
        setState(() {
          _apellidos = valor;
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
        hintText: 'Correo',
        labelText: 'Correo Electrónico',
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
        icon: Icon( Icons.lock, )
      ),
      onChanged: (valor) => setState(() {
        _contrasena = valor;
      }),
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