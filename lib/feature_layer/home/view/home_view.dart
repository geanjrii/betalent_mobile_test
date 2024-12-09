import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:betalent_mobile_test/feature_layer/home/home.dart';
import 'package:betalent_mobile_test/style_guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HomeCubit(repository: context.read<BeTalentWorkerRepository>())
            ..onDataLoaded(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionários', style: h1,),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const SearchTextField(),
            const SizedBox(height: 20),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Expanded(
                    child: switch (context.read<HomeCubit>().state.apiStatus) {
                  LoadingStatus.loading => const Loading(),
                  LoadingStatus.failure => const Error(),
                  LoadingStatus.success => const WorkersList(),
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Pesquisar',
                    labelStyle: h3,
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: DropdownButtonHideUnderline(
                        child: BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return DropdownButton<String>(
                              value: state.searchType,
                              items: const [
                                DropdownMenuItem(
                                    value: 'name',
                                    child: Text('Nome', style: h3)),
                                DropdownMenuItem(
                                    value: 'position',
                                    child: Text('Cargo', style: h3)),
                                DropdownMenuItem(
                                    value: 'phone',
                                    child: Text('Telefone', style: h3)),
                              ],
                              onChanged: (value) {
                                context
                                    .read<HomeCubit>()
                                    .updateSearchType(value!);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                  onChanged: (text) => context.read<HomeCubit>().filterWorkers(
                      text, context.read<HomeCubit>().state.searchType),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 5,
      ),
    );
  }
}

class Error extends StatelessWidget {
  const Error({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      alignment: Alignment.center,
      child: const Text(
        'Erro ao receber os dados da api',
        style: TextStyle(color: Colors.red, fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
