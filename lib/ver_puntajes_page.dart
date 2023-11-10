import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_data.dart';

class VerPuntajesPage extends StatelessWidget {
  const VerPuntajesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text('VER PUNTAJES'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Texto para mostrar el alias
              Consumer<UserData>(
                builder: (context, userData, child) {
                  return Text(
                    'Alias: ${userData.alias}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),

              // Espacio entre los Texts
              SizedBox(height: 20),

              // Texto para mostrar los juegos ganados
              Consumer<UserData>(
                builder: (context, userData, child) {
                  return Text(
                    'Juegos Ganados: ${userData.juegosGanados}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
