import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        child: Center(          
          child: Column(            
            children: [                       
              Container(
                margin: EdgeInsets.only(top: 75.0, bottom: 50.0),
                child: Image(image: AssetImage('assets/hospital-xxl.png'))
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Bienvenido',
                  style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed( context , 'ingresar'),
                //onPressed: () => Navigator.pushNamed(context, ''),
                child: Text('Ingresar'),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),      
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed( context , 'registro'),
                //onPressed: () => Navigator.pushNamed(context, ''),
                child: Text('Registrarse'),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        child: Text('Help Center \u009a', style: TextStyle(color: Colors.black),),
        onPressed: () => null,
        elevation: 0,
      ),

    );
  }
}