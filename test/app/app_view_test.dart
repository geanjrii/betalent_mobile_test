 
import 'package:betalent_mobile_test/app/app_view.dart';
import 'package:betalent_mobile_test/feature_layer/fetaure_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App View =>', () {
    testWidgets('App renders HomePage', (tester) async {
      await tester.pumpWidget(const App());

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('App is a MaterialApp', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
