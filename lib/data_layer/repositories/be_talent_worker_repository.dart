
import 'package:betalent_mobile_test/data_layer/data_layer.dart';

class BeTalentWorkerRepository {
  final BeTalentApiService _apiService;

  BeTalentWorkerRepository({required BeTalentApiService api}) : _apiService = api;

  Future<List<BeTalentWorkerModel>> getWorkers() async {
    return _apiService.getWorkers();
  }

}