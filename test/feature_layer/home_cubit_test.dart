import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:betalent_mobile_test/domain_layer/domain_layer.dart';
import 'package:betalent_mobile_test/feature_layer/home/cubit/home_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockBetalentRepository extends Mock implements BetalentRepository {}

class FakeBetalentWorkerModel extends Fake implements BetalentWorkerModel {}

void main() {
  late HomeCubit homeCubit;
  late MockBetalentRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeBetalentWorkerModel());
  });

  setUp(() {
    mockRepository = MockBetalentRepository();
    homeCubit = HomeCubit(repository: mockRepository);
  });

  tearDown(() {
    homeCubit.close();
  });

  group('HomeCubit', () {
    final workersList = [FakeBetalentWorkerModel()];

    blocTest<HomeCubit, HomeState>(
      'emits [loading, success] when onDataLoaded is called and succeeds',
      build: () {
        when(() => mockRepository.getWorkers()).thenAnswer((_) async => workersList);
        return homeCubit;
      },
      act: (cubit) => cubit.onDataLoaded(),
      expect: () => [
        const HomeState.loading().copyWith(apiStatus: LoadingStatus.loading),
        const HomeState.loading().copyWith(
          apiStatus: LoadingStatus.success,
          workersList: workersList,
          originalWorkersList: workersList,
        ),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [loading, failure] when onDataLoaded is called and fails',
      build: () {
        when(() => mockRepository.getWorkers()).thenThrow(Exception('error'));
        return homeCubit;
      },
      act: (cubit) => cubit.onDataLoaded(),
      expect: () => [
        const HomeState.loading().copyWith(apiStatus: LoadingStatus.loading),
        const HomeState.loading().copyWith(apiStatus: LoadingStatus.failure),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [loading, success] with filtered workers when filterWorkers is called',
      build: () {
        homeCubit.emit(const HomeState.loading().copyWith(
          apiStatus: LoadingStatus.success,
          workersList: workersList,
          originalWorkersList: workersList,
        ));
        return homeCubit;
      },
      act: (cubit) => cubit.filterWorkers('query', 'name'),
      expect: () => [
        const HomeState.loading().copyWith(apiStatus: LoadingStatus.loading),
        const HomeState.loading().copyWith(
          apiStatus: LoadingStatus.success,
          workersList: workersList,
          searchType: 'name',
        ),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [loading, success] when updateSearchType is called',
      build: () => homeCubit,
      act: (cubit) => cubit.updateSearchType('email'),
      expect: () => [
        const HomeState.loading().copyWith(apiStatus: LoadingStatus.loading),
        const HomeState.loading().copyWith(
          apiStatus: LoadingStatus.success,
          searchType: 'email',
        ),
      ],
    );
  });
}