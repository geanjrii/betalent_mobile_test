
import 'package:betalent_mobile_test/data_layer/data_layer.dart';

class BetalentRepository {
  final BetalentApi _api;

  BetalentRepository({required BetalentApi api}) : _api = api;

  Future<List<BetalentWorkerModel>> getWorkers() async {
    return _api.getWorkers();
  }

}