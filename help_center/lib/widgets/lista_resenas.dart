import 'package:flutter/material.dart';
import 'package:help_center/models/resena.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:help_center/providers/providers.dart';
import 'package:provider/provider.dart';

class ListaResenas extends StatefulWidget {

  final List<Resena> resenas;
  final int id_consultorio;
  final int id_paciente;

  const ListaResenas({ 
    Key? key ,
    required this.resenas, 
    required this.id_consultorio,
    required this.id_paciente
  }) 
  : super(key: key);

  @override
  State<ListaResenas> createState() => _ListaResenasState();
}

class _ListaResenasState extends State<ListaResenas> {

  double calificacion = 0.0;
  String comentario = '';

  @override
  Widget build(BuildContext context) {

    final resenasProvider = Provider.of<ResenasProvider>( context );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Reseñas", style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold )),
                ElevatedButton.icon(
                  onPressed: (){
                    showDialog(
                      context: context, 
                      builder: (_) {
                        return AlertDialog(
                          title: Text('Reseña'),
                          content: ListView(
                            shrinkWrap: true,
                            children: [
                              RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemSize: 35.0,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  this.calificacion = rating;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(hintText: 'Comentario'),
                                onChanged: (valor) {
                                  this.comentario = valor;
                                },
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                bool response = await resenasProvider.registroResena(
                                  widget.id_paciente, 
                                  widget.id_consultorio,
                                  this.calificacion,
                                  this.comentario 
                                );
                                if(response) {
                                  Navigator.pop(context);
                                } 
                              },
                              child: Text('Enviar'),
                            ),
                          ],
                        );
                      }
                    );
                  }, 
                  icon: Icon( Icons.comment ), 
                  label: Text('Enviar reseña'),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                  ) 
                ),
              ],
            ),
          ),          
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

