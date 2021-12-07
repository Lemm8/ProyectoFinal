import 'package:flutter/material.dart';

class RegistroProfesional extends StatefulWidget {

  const RegistroProfesional({ Key? key }) : super(key: key);

  @override
  _RegistroConsultorioState createState() => _RegistroConsultorioState();
}

class _RegistroConsultorioState extends State<RegistroProfesional> {

  String _nombre = '';
  String _email = '';
  String _fecha = '';


  @override
  Widget build(BuildContext context) {
    return ListView(       
      shrinkWrap: true,          
      children: [
        Container(
          alignment: Alignment.center,
          child: Text('Crea tu cuenta llenando los siguientes campos', style: TextStyle(fontWeight: FontWeight.bold))
        ),
        Divider(),
        _crearInput(
          'Nombre',
          'Nombre',
          Icon( Icons.account_circle ),
          Icon( Icons.assignment_ind_rounded, )
        ),
        Divider(),
        _crearEmail(),
        Divider(),
        _crearPassword('Contraseña', 'Contraseña'),
        Divider(),
        _crearPassword('Confirmar Contraseña', 'Confirmar Contraseña'),
        Divider(),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, 'profesionalHomeScreen'),
          child: Text('Registrar'),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
          )     
        ), 
      ],
    );
  }

  Widget _crearInput( String hintText, String labelText, Icon suffixIcon, Icon icon ) {
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
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        icon: icon
      ),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
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
        _email = valor;
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
    ); 
  }




  
}