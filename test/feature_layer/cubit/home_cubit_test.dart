import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:betalent_mobile_test/feature_layer/home/cubit/home_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockBetalentRepository extends Mock implements BeTalentWorkerRepository {}

void main() {
  group('HomeCubit =>', () {
    const workersList = [
      {
        "id": 1,
        "name": "João",
        "job": "Back-end",
        "admission_date": "2019-12-02T00:00:00.000Z",
        "phone": "5551234567890",
        "image":
            "https://img.favpng.com/25/7/23/computer-icons-user-profile-avatar-image-png-favpng-LFqDyLRhe3PBXM0sx2LufsGFU.jpg"
      },
      {
        "id": 2,
        "name": "Roberto",
        "job": "Front-end",
        "admission_date": "2020-03-12T00:00:00.000Z",
        "phone": "5550321654789",
        "image":
            "https://e7.pngegg.com/pngimages/550/997/png-clipart-user-icon-foreigners-avatar-child-face.png"
      },
      {
        "id": 3,
        "name": "Maria",
        "job": "Front-end",
        "admission_date": "2020-03-15T00:00:00.000Z",
        "phone": "5557894561230",
        "image":
            "https://www.clipartmax.com/png/middle/277-2772117_user-profile-avatar-woman-icon-avatar-png-profile-icon.png"
      }
    ];

    late HomeCubit homeCubit;
    late MockBetalentRepository mockRepository;
    late List<BeTalentWorkerModel> mockWorkersList;

    setUp(() {
      mockRepository = MockBetalentRepository();
      homeCubit = HomeCubit(repository: mockRepository);
      mockWorkersList = workersList.map((worker) {
        return BeTalentWorkerModel.fromJson(worker);
      }).toList();
    });

    tearDown(() {
      homeCubit.close();
      reset(mockRepository);
    });

    group('onDataloaded =>', () {
      blocTest<HomeCubit, HomeState>(
        'Tests that onDataLoaded emits [success] when worker data is successfully fetched.',
        setUp: () {
          when(() => mockRepository.getWorkers())
              .thenAnswer((_) async => mockWorkersList);
        },
        build: () => homeCubit,
        act: (cubit) => cubit.onDataLoaded(),
        expect: () => [
          const HomeState.loading().copyWith(
            apiStatus: LoadingStatus.success,
            workersList: mockWorkersList,
            originalWorkersList: mockWorkersList,
          ),
        ],
        verify: (cubit) {
          verify(() => mockRepository.getWorkers()).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'Tests that onDataLoaded emits [failure] when worker data fetching fails.',
        setUp: () {
          when(() => mockRepository.getWorkers()).thenThrow(Exception('error'));
        },
        build: () => homeCubit,
        act: (cubit) => cubit.onDataLoaded(),
        expect: () => [
          const HomeState.loading().copyWith(apiStatus: LoadingStatus.failure),
        ],
      );
    });

    group('filterWorkers =>', () {
      blocTest<HomeCubit, HomeState>(
        'Tests filtering workers by name, ensuring it returns a list with a single worker named "João"',
        build: () => homeCubit,
        seed: () => const HomeState.loading().copyWith(
          apiStatus: LoadingStatus.success,
          workersList: mockWorkersList,
          originalWorkersList: mockWorkersList,
        ),
        act: (cubit) => cubit.filterWorkers('João', 'name'),
        expect: () => [
          const HomeState.loading().copyWith(
              apiStatus: LoadingStatus.loading,
              workersList: mockWorkersList,
              originalWorkersList: mockWorkersList),
          const HomeState.loading().copyWith(
              apiStatus: LoadingStatus.success,
              workersList: [mockWorkersList[0]],
              originalWorkersList: mockWorkersList,
              searchType: 'name'),
        ],
        verify: (cubit) {
          expect(cubit.state.workersList.length, 1);
          expect(cubit.state.workersList[0].name, 'João');
        },
      );

      blocTest<HomeCubit, HomeState>(
        'Tests filtering workers by position, ensuring it returns workers with the job "Front-end".',
        build: () => homeCubit,
        seed: () => const HomeState.loading().copyWith(
          apiStatus: LoadingStatus.success,
          workersList: mockWorkersList,
          originalWorkersList: mockWorkersList,
        ),
        act: (cubit) => cubit.filterWorkers('Front-end', 'position'),
        expect: () => [
          const HomeState.loading().copyWith(
              apiStatus: LoadingStatus.loading,
              workersList: mockWorkersList,
              originalWorkersList: mockWorkersList),
          const HomeState.loading().copyWith(
              apiStatus: LoadingStatus.success,
              workersList: [mockWorkersList[1], mockWorkersList[2]],
              originalWorkersList: mockWorkersList,
              searchType: 'position'),
        ],
        verify: (cubit) {
          expect(cubit.state.workersList.length, 2);
          expect(cubit.state.workersList[0].job, 'Front-end');
          expect(cubit.state.workersList[1].job, 'Front-end');
        },
      );

      blocTest<HomeCubit, HomeState>(
        'Tests filtering workers by phone number, ensuring it returns a worker with the phone "5557894561230"',
        build: () => homeCubit,
        seed: () => const HomeState.loading().copyWith(
          apiStatus: LoadingStatus.success,
          workersList: mockWorkersList,
          originalWorkersList: mockWorkersList,
        ),
        act: (cubit) => cubit.filterWorkers('5557894561230', 'phone'),
        expect: () => [
          const HomeState.loading().copyWith(
              apiStatus: LoadingStatus.loading,
              workersList: mockWorkersList,
              originalWorkersList: mockWorkersList),
          const HomeState.loading().copyWith(
              apiStatus: LoadingStatus.success,
              workersList: [mockWorkersList[2]],
              originalWorkersList: mockWorkersList,
              searchType: 'phone'),
        ],
        verify: (cubit) {
          expect(cubit.state.workersList.length, 1);
          expect(cubit.state.workersList[0].phone, '5557894561230');
        },
      );

      blocTest<HomeCubit, HomeState>(
        'Tests filtering workers with an empty query, ensuring it returns the full workers list.',
        build: () => homeCubit,
        act: (cubit) => cubit.filterWorkers('', 'name'),
        seed: () => const HomeState.loading().copyWith(
          apiStatus: LoadingStatus.success,
          workersList: mockWorkersList,
          originalWorkersList: mockWorkersList,
        ),
        expect: () => [
          const HomeState.loading().copyWith(
              apiStatus: LoadingStatus.loading,
              workersList: mockWorkersList,
              originalWorkersList: mockWorkersList),
          const HomeState.loading().copyWith(
              apiStatus: LoadingStatus.success,
              workersList: mockWorkersList,
              originalWorkersList: mockWorkersList),
        ],
        verify: (cubit) {
          expect(cubit.state.workersList.length, 3);
        },
      );
    });

    group('updateSearchType =>', () {
      blocTest(
        'Tests the update of the search type to "email"',
        build: () => homeCubit,
        act: (cubit) => cubit.updateSearchType('email'),
        expect: () => [
          const HomeState.loading()
              .copyWith(apiStatus: LoadingStatus.success, searchType: 'email'),
        ],
        verify: (cubit) => homeCubit.state.searchType == 'email',
      );
    });
  });
}
