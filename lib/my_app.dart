import 'package:flutter/material.dart';
import 'my_home_page.dart';
import 'adivina_el_numero_page.dart';
import 'ver_puntajes_page.dart';
import 'package:provider/provider.dart';
import 'user_data.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcial flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => const MyHomePage(title: 'Parcial flutter'),
        '/adivina_el_numero': (context) => const AdivinaElNumeroPage(),
        '/ver_puntajes': (context) => const VerPuntajesPage(),
      },
    );
  }
}


