import 'dart:convert';

import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:http/http.dart' as http;

class BeTalentApiService {
  final http.Client _client;

  BeTalentApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<BeTalentWorkerModel>> getWorkers() async {
    const url = 'http://10.0.2.2:8080/employees';
    //const url = 'http://localhost:8080/employees';
    final uri = Uri.parse(url);
    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw BeTalentApiRequestFailure();
    }

    final json = jsonDecode(response.body);

    if (json is! List) {
      throw BeTalentApiNotFoundException();
    }

    if (json.isEmpty) {
      throw BeTalentApiNotFoundException();
    }

    final workers = json.map((e) => BeTalentWorkerModel.fromJson(e)).toList();
    return workers;
  }
}

class BeTalentApiRequestFailure implements Exception {}

class BeTalentApiNotFoundException implements Exception {}
