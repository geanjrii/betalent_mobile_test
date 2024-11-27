import 'package:betalent_mobile_test/app/app.dart';
import 'package:betalent_mobile_test/style_guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const App()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: bluePrimary,
        padding: const EdgeInsets.all(60),
        child: Center(
          child: ColorFiltered(
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
            child: Image.asset("images/logo.png"),
          ),
        ),
      ),
    );
  }
}

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(const MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

/* 

Bibliotecas externas utilizadas:

flutter pub add flutter_bloc  # Gerenciamento de estado com BLoC no Flutter

flutter pub add bloc          # Lógica de negócios em Dart

flutter pub add bloc_test     # Testes para o bloc

flutter pub add equatable     # Comparação de objetos

flutter pub add http          # Requisições HTTP

flutter pub add mocktail      # Mock para testes


 */