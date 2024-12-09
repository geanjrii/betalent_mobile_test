// ignore_for_file: public_member_api_docs

import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:betalent_mobile_test/feature_layer/fetaure_layer.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class FakeBetalentWorkerModel extends Fake implements BeTalentWorkerModel {}

class MockBetalentRepository extends Mock implements BeTalentWorkerRepository {}

void main() {
  group('HomeState =>', () {
    late HomeCubit homeCubit;
    final FakeBetalentWorkerModel mockWorker = FakeBetalentWorkerModel();
    final workersList = [mockWorker];
    final MockBetalentRepository mockRepository = MockBetalentRepository();

    setUpAll(() {
      registerFallbackValue(FakeBetalentWorkerModel());
    });

    setUp(() {
      homeCubit = HomeCubit(repository: mockRepository);
    });

    tearDown(() {
      homeCubit.close();
    });

    test('initial state is correct', () {
      expect(homeCubit.state, const HomeState.loading());
    });

    test('emits correct state when state change', () async {
      expect(homeCubit.state, const HomeState.loading());
      homeCubit.emit(const HomeState.failure());
      expect(homeCubit.state, const HomeState.failure());
      homeCubit.emit(HomeState.success(list: workersList));
      expect(homeCubit.state, HomeState.success(list: workersList));      
    });

    test('copyWith returns a new instance with updated values', () {
      final state = HomeState.success(list: workersList);
      final newState = state.copyWith(searchType: 'email');
      expect(newState.searchType, 'email');
      expect(newState.apiStatus, state.apiStatus);
      expect(newState.workersList, state.workersList);
      expect(newState.originalWorkersList, state.originalWorkersList);
    });

    test('copyWith retains the same values if no parameters are passed', () {
      final state = HomeState.success(list: workersList);
      final newState = state.copyWith();
      expect(newState.searchType, state.searchType);
      expect(newState.apiStatus, state.apiStatus);
      expect(newState.workersList, state.workersList);
      expect(newState.originalWorkersList, state.originalWorkersList);
    });
  });
}
