// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:betalent_mobile_test/style_guide.dart';
import 'package:flutter/material.dart';

class WorkerDetails extends StatelessWidget {
  const WorkerDetails({
    super.key,
    required this.worker,
  });

  final BetalentWorkerModel worker;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageName(
            image: worker.image,
            name: worker.name,
          ),
          Job(job: worker.job),
          AdmissionDate(admissionDate: worker.admissionDate),
          Phone(phone: worker.phone),
        ],
      ),
    );
  }
}

class ImageName extends StatelessWidget {
  const ImageName({
    super.key,
    required this.name,
    required this.image,
  });

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(name, style: h2),
      //trailing: const Icon(Icons.arrow_drop_up),
    );
  }
}

class Job extends StatelessWidget {
  const Job({
    super.key,
    required this.job,
  });

  final String job;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Text('Cargo:', style: h2),
      trailing: Text(job, style: h3),
    );
  }
}

class AdmissionDate extends StatelessWidget {
  const AdmissionDate({
    super.key,
    required this.admissionDate,
  });

  final DateTime admissionDate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Text('Data de admissão:', style: h2),
      trailing: Text(
        '${admissionDate.day < 10 ? '0' : ''}${admissionDate.day}/${admissionDate.month}/${admissionDate.year}',
        style: h3,
      ),
    );
  }
}

class Phone extends StatelessWidget {
  const Phone({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Text('Telefone:', style: h2),
      trailing: Text(
          '+${phone.substring(0, 2)} (${phone.substring(2, 4)}) ${phone.substring(4, 8)}-${phone.substring(8)}',
          style: h3),
    );
  }
}
