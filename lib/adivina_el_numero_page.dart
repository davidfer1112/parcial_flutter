import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'user_data.dart';

class AdivinaElNumeroPage extends StatefulWidget {
  const AdivinaElNumeroPage({Key? key}) : super(key: key);

  @override
  State<AdivinaElNumeroPage> createState() => _AdivinaElNumeroPageState();
}

class _AdivinaElNumeroPageState extends State<AdivinaElNumeroPage> {
  int numeroAdivinar = 0;
  TextEditingController numeroIngresadoController = TextEditingController();

  int numeroIntentados = 0;
  int numeroIntentos = 0;
  List<int> numerosIntentadosList = [];

  String mensajeError = '';
  bool juegoTerminado = false;

  @override
  void initState() {
    super.initState();

    // Obtén el límite superior desde el Provider
    final userData = Provider.of<UserData>(context, listen: false);


    // Asegúrate de que el límite superior sea positivo y mayor que 0


    // Genera el número aleatorio con el límite superior válido
    numeroAdivinar = generarNumeroAleatorio(50);
  }

  int generarNumeroAleatorio(int limiteSuperior) {
    final Random random = Random();
    //print(limiteSuperior);
    return random.nextInt(limiteSuperior + 1);
  }

  Widget appBarTitle() {
    return Column(
      children: [
        Text('ADIVINA EL NÚMERO'),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: appBarTitle(),
      ),
      body: Container(
        margin: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ADIVINA EL NÚMERO (${numeroAdivinar})',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              mensajeError,
              style: TextStyle(
                color: Colors.black,
              ),
            ),

            SizedBox(height: 20),

            TextFormField(
              controller: numeroIngresadoController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: 'Escribe el Número',
                border: OutlineInputBorder(),
              ),
              enabled: !juegoTerminado,
            ),

            SizedBox(height: 20),

            Text(
              'Números Intentados: ${numerosIntentadosList.join(', ')}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              'Número de Intentos: $numeroIntentos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: juegoTerminado ? null : () => _adivinarNumero(),
              child: Text('Adivinar'),
            ),
          ],
        ),
      ),
    );
  }

  void _adivinarNumero() {
    final String numeroIngresado = numeroIngresadoController.text.trim();

    if (numeroIngresado.isEmpty) {
      setState(() {
        mensajeError = 'Por favor, ingresa un número.';
      });
      return;
    }

    setState(() {
      mensajeError = '';
    });

    final int numero = int.tryParse(numeroIngresado) ?? 0;
    numerosIntentadosList.add(numero);

    if (numero == numeroAdivinar) {
      setState(() {
        mensajeError = '¡Éxito! Adivinaste el número en $numeroIntentos intentos.';
        juegoTerminado = true;

        // Llama al método para incrementar los juegos ganados en el Provider
        Provider.of<UserData>(context, listen: false).incrementarJuegosGanados();
      });
    } else {
      setState(() {
        if (numero < numeroAdivinar)
          mensajeError = 'El número es mayor.';
        else
          mensajeError = 'El número es menor.';
      });
    }

    numeroIntentos++;
    numeroIngresadoController.clear();
  }
}


