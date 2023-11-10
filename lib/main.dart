import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';
import 'user_data.dart';
import 'my_home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserData()),
      ],
      child: const MyApp(),
    ),
  );
}

