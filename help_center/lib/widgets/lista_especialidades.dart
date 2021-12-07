import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';

class ListaEspecialidadesConsultorio extends StatefulWidget {

  final List<Especialidad> especialidades;

  const ListaEspecialidadesConsultorio({ 
    Key? key,
    required this.especialidades,
  }) 
  : super(key: key);

  @override
  _ListaEspecialidadesConsultorioState createState() => _ListaEspecialidadesConsultorioState();
}

class _ListaEspecialidadesConsultorioState extends State<ListaEspecialidadesConsultorio> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,      
      height: 70.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Especialidades', style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold )),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.especialidades.length,
              itemBuilder: ( _, int index) => EspecialidadItem(especialidad: widget.especialidades[index],)
            )
          )
        ],
      ),
    );
  }
}

class EspecialidadItem extends StatelessWidget {
  final Especialidad especialidad;
  const EspecialidadItem({ 
    Key? key,
    required this.especialidad
  }) 
  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0,),  
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black12 )
      ),
      child: Center(child: Text('${especialidad.nombre}'))
    );
  }
}