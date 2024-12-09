import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockBetalentApiService extends Mock implements BeTalentApiService {}

void main() {
  group('BeTalentWorkerRepository =>', () {
    const workersList = <BeTalentWorkerModel>[];
    late BeTalentWorkerRepository repository;
    late MockBetalentApiService mockService;

    setUp(() {
      mockService = MockBetalentApiService();
      repository = BeTalentWorkerRepository(api: mockService);
    });

    test('getWorkers return a list of BeTalentWorker', () async {
      // Arrange
      when(() => mockService.getWorkers()).thenAnswer((_) async => workersList);
      // Act
      final result = await repository.getWorkers();
      // Assert
      expect(result, workersList);
    });
  });
}
