import 'package:flutter/material.dart';
import 'package:help_center/providers/providers.dart';
import 'package:provider/provider.dart';


class IngresarScreen extends StatefulWidget {
  static final pageName = 'inputs';

  @override
  _InputPageStateState createState() => _InputPageStateState();
}

class _InputPageStateState extends State<IngresarScreen> {

  String _correo = '';
  String _contrasena = '';

  String _opcion = 'paciente';

  List _tipoUsuarios = ['paciente', 'profesional', 'consultorio'];

  //TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>( context );

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          padding: EdgeInsets.symmetric( horizontal: 10.0, vertical: 20.0 ),
          shrinkWrap: true,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text('Ingresa tus datos en los campos correspondientes', style: TextStyle(fontWeight: FontWeight.bold))
            ),            
            Divider(),
            _crearDropdown(),
            Divider(),
            _crearEmail(),
            Divider(),
            _crearPassword('Contraseña', 'Contraseña'),
            Divider(),
            ElevatedButton(
              //onPressed: () => Navigator.pushNamed( context, ruta ), 
              onPressed: () async {
                var response = await authProvider.loginUsuario( _opcion , _correo, _contrasena);
                print(response);
                if(response != false) {
                  if(_opcion == 'paciente'){
                    Navigator.pushNamed(context, 'pacienteHomeScreen', arguments: authProvider.paciente);
                  } else if(_opcion == 'profesional'){
                    Navigator.pushNamed(context, 'profesionalHomeScreen', arguments: authProvider.profesional);
                  } else if(_opcion == 'consultorio'){
                    Navigator.pushNamed(context, 'consultorioHomeScreen', arguments: authProvider.consultorio);
                  }
                } else {
                  mostrarAlert();
                }              
              },
              child: Text('Ingresar'),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              )     
            ),        
          ],
        ),
      ),
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
        icon: Icon( Icons.lock, )
      ),
      onChanged: (valor) => setState(() {
        _contrasena = valor;
      }),
    ); 
  }




  List<DropdownMenuItem<String>> getOpcionesDropdown() {

    List<DropdownMenuItem<String>> lista = [];

    _tipoUsuarios.forEach( ( tipo ) { 

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
          value: _opcion,
          items: getOpcionesDropdown(),
          onChanged: (opt) {
            setState(() {
              _opcion = opt.toString();
            });
          },
        )
      ],
    );
    
    
  }


}
