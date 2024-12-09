import 'package:betalent_mobile_test/feature_layer/fetaure_layer.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

extension on WidgetTester {
  Future<void> pumpTimerView(HomeCubit homeCubit) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(value: homeCubit, child: const HomeView()),
      ),
    );
  }
}

void main() {
  late HomeCubit homeCubit;

  setUp(() {
    homeCubit = MockHomeCubit();
  });

  tearDown(() {
    reset(homeCubit);
  });

  group('HomeView', () {
    testWidgets('renders HomeView', (tester) async {
      when(() => homeCubit.state).thenReturn(const HomeState.loading());
      await tester.pumpTimerView(homeCubit);
      expect(find.byType(HomeView), findsOneWidget);
    });

    testWidgets('displays loading indicator when state is loading',
        (tester) async {
      when(() => homeCubit.state).thenReturn(const HomeState.loading());
      await tester.pumpTimerView(homeCubit);
      expect(find.byType(Loading), findsOneWidget);
    });

    testWidgets('displays error message when state is failure', (tester) async {
      when(() => homeCubit.state).thenReturn(const HomeState.failure());
      await tester.pumpTimerView(homeCubit);
      expect(find.byType(Error), findsOneWidget);
    });

    testWidgets('displays workers list when state is success', (tester) async {
      when(() => homeCubit.state).thenReturn(const HomeState.success(list: []));
      await tester.pumpTimerView(homeCubit);
      expect(find.byType(WorkersList), findsOneWidget);
    });

    testWidgets('updates search type when dropdown value changes',
        (tester) async {
      when(() => homeCubit.state).thenReturn(const HomeState.success(list: []));
      when(() => homeCubit.updateSearchType(any())).thenReturn(null);

      await tester.pumpTimerView(homeCubit);

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cargo').last);
      await tester.pump();

      verify(() => homeCubit.updateSearchType('position')).called(1);
    });

    testWidgets('displays search text field', (tester) async {
      when(() => homeCubit.state).thenReturn(const HomeState.success(list: []));
      await tester.pumpTimerView(homeCubit);
      expect(find.byType(SearchTextField), findsOneWidget);
    });

    testWidgets('filters workers when text is entered in search field',
        (tester) async {
      when(() => homeCubit.state).thenReturn(const HomeState.success(list: []));
      when(() => homeCubit.filterWorkers(any(), any())).thenReturn(null);

      await tester.pumpTimerView(homeCubit);

      await tester.enterText(find.byType(TextField), 'John');
      await tester.pump();

      verify(() => homeCubit.filterWorkers('John', 'name')).called(1);
    });
  });
}
