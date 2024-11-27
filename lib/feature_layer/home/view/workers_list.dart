// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:betalent_mobile_test/feature_layer/home/home.dart';
import 'package:betalent_mobile_test/style_guide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkersList extends StatelessWidget {
  const WorkersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: context.read<HomeCubit>().state.workersList.length,
          itemBuilder: (context, index) {
            final worker = context.read<HomeCubit>().state.workersList[index];
            return WorkerTile(worker: worker);
          },
        );
      },
    );
  }
}

class WorkerTile extends StatelessWidget {
  const WorkerTile({super.key, required this.worker});

  final BetalentWorkerModel worker;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Row(
        children: [
          WorkerImage(img: worker.image),
          Expanded(child: WorkerName(name: worker.name)),
          InfoButton(worker: worker),
        ],
      ),
    );
  }
}

class InfoButton extends StatelessWidget {
  const InfoButton({
    super.key,
    required this.worker,
  });

  final BetalentWorkerModel worker;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_drop_down),
      onPressed: () {
        showDialog(
            context: context,
            builder: (_) {
              return BlocProvider.value(
                value: context.read<HomeCubit>(),
                child: WorkerDetails(worker: worker),
              );
            });
      },
    );
  }
}

class WorkerImage extends StatelessWidget {
  const WorkerImage({
    super.key,
    required this.img,
  });

  final String img;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class WorkerName extends StatelessWidget {
  const WorkerName({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name, style: h3);
  }
}

class WorkerTile1 extends StatelessWidget {
  const WorkerTile1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(0),
      ),
      child: const ListTile(
        leading: Text('Foto'),
        title: Text('Nome'),
        trailing: Icon(Icons.info),
      ),
    );
  }
}
