import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parcial_flutter/user_data.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController aliasController = TextEditingController();
  TextEditingController limiteSuperiorController = TextEditingController();

  // Estado para manejar si se puede avanzar a la siguiente pantalla
  bool canNavigate = false;

  // Estado para almacenar el mensaje de error
  String errorMessage = '';

  // Obtener la instancia de UserData del Provider
  late UserData userData;

  @override
  void initState() {
    super.initState();
    // Obtener la instancia de UserData del Provider al inicio
    userData = Provider.of<UserData>(context, listen: false);
  }

  // Función para navegar a la pantalla "Adivina el Número"
  void _navigateToAdivinaElNumero() {
    // Validar si se puede avanzar
    if (_validateInputs()) {
      // Actualizar los valores en el Provider después de validar
      userData.updateUserData(aliasController.text, int.parse(limiteSuperiorController.text));
      Navigator.pushNamed(context, '/adivina_el_numero'); // Descomentar para activar la navegación
    } else {
      // Mostrar mensaje de error
      setState(() {
        errorMessage = 'Error: $errorMessage';
      });
    }
  }

  // Función para navegar a la pantalla "Ver Puntajes"
  void _navigateToVerPuntajes() {
    Navigator.pushNamed(context, '/ver_puntajes');
  }

  // Función para validar los inputs
  bool _validateInputs() {
    final String alias = aliasController.text;
    final String limiteSuperiorText = limiteSuperiorController.text;

    // Validar si el alias está ingresado
    if (alias.isEmpty) {
      errorMessage = 'Alias no ingresado';
      return false;
    }

    // Validar si el límite superior es un número válido entre 1 y 100
    try {
      final int limiteSuperior = int.parse(limiteSuperiorText);
      if (limiteSuperior < 0 || limiteSuperior >= 100) {
        errorMessage = 'Número fuera de rango (1-100)';
        return false;
      }
    } catch (e) {
      errorMessage = 'Número no válido';
      return false;
    }

    // Si pasa ambas validaciones, se puede avanzar
    errorMessage = '';
    canNavigate = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ADIVINA EL NÚMERO',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            SizedBox(height: 20),
            // TextFormField para ingresar el alias (solo mayúsculas)
            TextFormField(
              controller: aliasController,
              textCapitalization: TextCapitalization.characters,
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: InputDecoration(
                labelText: 'Alias',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // TextFormField para ingresar el límite superior (solo números)
            TextFormField(
              controller: limiteSuperiorController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: 'Límite Superior',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Validar y navegar
                    _navigateToAdivinaElNumero();
                  },
                  child: Text('Jugar'),
                ),
                ElevatedButton(
                  onPressed: _navigateToVerPuntajes,
                  child: Text('Ver Puntajes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// TextInputFormatter para convertir automáticamente el texto a mayúsculas
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase() ?? '',
      selection: newValue.selection,
    );
  }
}
