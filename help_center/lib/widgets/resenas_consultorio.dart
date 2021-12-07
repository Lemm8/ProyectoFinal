import 'package:flutter/material.dart';
import 'package:help_center/models/resena.dart';

class ResenasConsultorio extends StatefulWidget {

  final List<Resena> resenas;

  const ResenasConsultorio({ 
    Key? key ,
    required this.resenas, 
  }) 
  : super(key: key);

  @override
  State<ResenasConsultorio> createState() => _ListaResenasState();
}

class _ListaResenasState extends State<ResenasConsultorio> {

  double calificacion = 0.0;
  String comentario = '';

  @override
  Widget build(BuildContext context) {

    //final resenasProvider = Provider.of<ResenasProvider>( context );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [                  
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,              
            itemCount: this.widget.resenas.length,      
            itemBuilder: ( _, int index ) => _listaResenas( context, this.widget.resenas[index] )
          ),
        ],
      ),
    );
  }

  Widget _listaResenas( BuildContext context, Resena resena ) {
    return Card(
      margin: EdgeInsets.symmetric( vertical: 10.0, horizontal: 10.0 ),
      elevation: 5.0,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),      
      child: InkWell(
        child: Column(        
          children: <Widget>[
            ListTile(
              title: Text('${resena.paciente}'),
              subtitle: Text('${resena.calificacion} \n${resena.comentario}'),
              isThreeLine: true,            
            ),
          ],
        ),
      ),
    );
  }

}

