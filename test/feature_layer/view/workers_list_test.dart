import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:betalent_mobile_test/feature_layer/fetaure_layer.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

extension on WidgetTester {
  Future<void> pumpWorkersList(HomeCubit homeCubit) async {
    return await mockNetworkImages(() async {
      await pumpWidget(
        MaterialApp(
          home:
              BlocProvider.value(value: homeCubit, child: const WorkersList()),
        ),
      );
    });
  }
}

void main() {
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
  late List<BeTalentWorkerModel> mockWorkersList;

  setUp(() {
    homeCubit = MockHomeCubit();
    mockWorkersList = workersList.map((worker) {
      return BeTalentWorkerModel.fromJson(worker);
    }).toList();
  });

  tearDown(() {
    reset(homeCubit);
  });

  group('WorkersList', () {
    testWidgets('renders WorkersList', (tester) async {
      when(() => homeCubit.state).thenReturn(const HomeState.success(list: []));
      await tester.pumpWorkersList(homeCubit);

      expect(find.byType(WorkersList), findsOneWidget);
    });

    testWidgets('displays WorkerTile for each worker', (tester) async {
      when(() => homeCubit.state)
          .thenReturn(HomeState.success(list: mockWorkersList));
      await tester.pumpWorkersList(homeCubit);
      expect(find.byType(WorkerTile), findsNWidgets(mockWorkersList.length));
    });

    testWidgets('displays worker name and image in WorkerTile', (tester) async {
      when(() => homeCubit.state)
          .thenReturn(HomeState.success(list: mockWorkersList));
      await tester.pumpWorkersList(homeCubit);

      expect(find.text('João'), findsOneWidget);
      expect(find.byType(WorkerImage), findsNWidgets(mockWorkersList.length));
    });

    testWidgets('displays WorkerDetails dialog when InfoButton is pressed',
        (tester) async {
      when(() => homeCubit.state)
          .thenReturn(HomeState.success(list: mockWorkersList));
      await tester.pumpWorkersList(homeCubit);

      await tester.tap(find.byKey(const Key('1')));  
      await tester.pumpAndSettle();
      expect(find.byType(WorkerDetails),  findsOneWidget);
    });
  });
}
