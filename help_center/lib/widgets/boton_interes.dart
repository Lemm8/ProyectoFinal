import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';
import 'package:provider/provider.dart';
import 'package:help_center/providers/providers.dart';

class BotonInteres extends StatefulWidget {
  final Paciente paciente;
  final Consultorio consultorio;
  final bool interes;
  const BotonInteres({ 
    Key? key,
    required this.interes,
    required this.paciente,
    required this.consultorio
  }) 
  : super(key: key);

  @override
  _BotonInteresState createState() => _BotonInteresState();
}

class _BotonInteresState extends State<BotonInteres> {
  @override
  Widget build(BuildContext context) {

    final interesProvider = Provider.of<InteresProvider>(context); 

    if(widget.interes) {
      return ElevatedButton.icon(
        onPressed: () async {
          await interesProvider.deleteInteres(widget.paciente.id_paciente, widget.consultorio.id_consultorio);          
        }, 
        icon: Icon( Icons.star_border ), 
        label: Text('Ya no me interesa'),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shape: StadiumBorder(),          
        ) 
      );
    } else {
      return ElevatedButton.icon(
        onPressed: () async {
          await interesProvider.postInteres(widget.paciente.id_paciente, widget.consultorio.id_consultorio);
        },  
        icon: Icon( Icons.star_border ), 
        label: Text('Me interesa'),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
        ) 
      );
    }    
  }

}