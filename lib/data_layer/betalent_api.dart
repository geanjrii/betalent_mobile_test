import 'dart:convert';

import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:http/http.dart' as http;

class BetalentApi {
  final http.Client client;

  BetalentApi({http.Client? client}) : client = client ?? http.Client();

  Future<List<BetalentWorkerModel>> getWorkers() async {
    const url = 'http://10.0.2.2:8080/employees'; 
    //const url = 'http://localhost:8080/employees';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw BetalentApiExeption();
    }

    final responseBody = response.body;

    dynamic jsonData;
    try {
      jsonData = jsonDecode(responseBody);
    } catch (_) {
      throw BetalentApiExeption();
    }

    if (jsonData is List) {
      if (jsonData.isEmpty) {
        throw BetalentApiNotFoundException();
      }

      final workers =
          jsonData.map((json) => BetalentWorkerModel.fromJson(json)).toList();
      return workers;
    }

    
    if (jsonData is Map && jsonData.containsKey('employees')) {
      final List workersList = jsonData['employees'];

      if (workersList.isEmpty) {
        throw BetalentApiNotFoundException();
      }

      final List<BetalentWorkerModel> workers = workersList
          .map((json) => BetalentWorkerModel.fromJson(json))
          .toList();
      return workers;
    }

    // If the data doesn't match either structure, throw a NotFoundException
    throw BetalentApiNotFoundException();
  }
}

class BetalentApiExeption implements Exception {}

class BetalentApiNotFoundException implements Exception {}

 