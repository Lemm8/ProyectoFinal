import 'package:flutter/material.dart';
import 'package:help_center/providers/providers.dart';
//import 'package:help_center/screens/ajustes_paciente.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: ( _ ) => AuthProvider(), lazy: false, ),
        ChangeNotifierProvider( create: ( _ ) => ConsultoriosProvider(), lazy: false),
        ChangeNotifierProvider( create: ( _ ) => EspecialidadesProvider(), lazy: false),
        ChangeNotifierProvider( create: ( _ ) => InteresProvider(), lazy: false),
        ChangeNotifierProvider( create: ( _ ) => ResenasProvider(), lazy: false,),
      ],
      child: MyApp(),
    );
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: Colors.pink[100],
          secondary: Colors.pink[100]
        ),
        appBarTheme: AppBarTheme(
          color: Colors.pink[100],
        ),        
      ),
      debugShowCheckedModeBanner: false,
      title: 'Help Center',
      initialRoute: 'inicio',
      routes: {
        'inicio': ( _ ) => InicioScreen(),
        'ingresar': ( _ ) => IngresarScreen(),
        'registro': ( _ ) => RegistroScreen(),
        'pacienteHomeScreen': ( _ ) => PacienteScreen(),
        'consultorioHomeScreen': ( _ ) => ConsultorioScreen(),
        'profesionalHomeScreen': ( _ ) => ProfesionalScreen(),
        'consultorioDetallesScreen': ( _ ) => ConsultorioDetallesScreen(),
        'datosGeneralesScreen': ( _ ) => DatosGenerales(),
      },
    );
  }
}