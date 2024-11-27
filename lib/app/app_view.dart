
import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:betalent_mobile_test/domain_layer/domain_layer.dart';
import 'package:betalent_mobile_test/feature_layer/fetaure_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => BetalentRepository(api: BetalentApi()),
        child: const HomePage(),
      ),
    );
  }
}