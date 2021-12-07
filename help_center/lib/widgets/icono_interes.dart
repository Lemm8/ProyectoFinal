import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';
import 'package:help_center/providers/providers.dart';
import 'package:provider/provider.dart';

// TODO: REDIBUJAR ESTADO AL DAR CLICK

class IconoInteres extends StatefulWidget {
  final Paciente paciente;
  final Consultorio consultorio;
  final bool interes;
  const IconoInteres({ 
    Key? key,
    required this.interes,
    required this.paciente,
    required this.consultorio
  }) 
  : super(key: key);

  @override
  _IconoInteresState createState() => _IconoInteresState();
}

class _IconoInteresState extends State<IconoInteres> {
  @override
  Widget build(BuildContext context) {

    bool _interes = widget.interes;

    final interesProvider = Provider.of<InteresProvider>(context);

    // return ElevatedButton(      
    //   child: _interes ? Text('True') : Text('False'),
    //   onPressed: (){
    //     setState(() {
    //       _interes = !_interes;
    //       print(_interes);
    //     });
    //   }, 
    // );

    return Container(
      child: IconButton(
        icon: Icon( Icons.star_border, size: 30.0, color: _interes ? Colors.yellow[700] : Colors.black), 
        onPressed: () async {              
          _interes ? 
            await interesProvider.deleteInteres(widget.paciente.id_paciente, widget.consultorio.id_consultorio)
            : await interesProvider.postInteres(widget.paciente.id_paciente, widget.consultorio.id_consultorio);
            this.setState(() {              
              _interes = !_interes;
              print('${_interes}');
            });
        },      
      ),
    );    
  }
}