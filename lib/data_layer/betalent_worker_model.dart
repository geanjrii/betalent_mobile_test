import 'package:equatable/equatable.dart';

class BetalentWorkerModel extends Equatable {
  final int id;
  final String name;
  final String job;
  final DateTime admissionDate;
  final String phone;
  final String image;

  const BetalentWorkerModel({
    required this.id,
    required this.name,
    required this.job,
    required this.admissionDate,
    required this.phone,
    required this.image,
  });

  factory BetalentWorkerModel.fromJson(Map<String, dynamic> json) {
    return BetalentWorkerModel(
      id: json['id'],
      name: json['name'],
      job: json['job'],
      admissionDate: DateTime.parse(json['admission_date']),
      phone: json['phone'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'job': job,
      'admission_date': admissionDate.toIso8601String(),
      'phone': phone,
      'image': image,
    };
  }

  @override
  List<Object> get props => [id, name, job, admissionDate, phone, image];
}
