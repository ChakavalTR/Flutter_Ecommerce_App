import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_ecommerce_app/app.dart';
import 'package:flutter_ecommerce_app/core/services/local_storage_service.dart';

Future<void> main() async {
  //! Flutter Binding Initialization
  WidgetsFlutterBinding.ensureInitialized();

  //! Initialize Local Storage
  await LocalServiceStorage.instance.init();

  //! Load .env file
  await dotenv.load(fileName: ".env");

  //! Splash Screen
  await Future.delayed(const Duration(milliseconds: 1500));
  runApp(const App());
}
