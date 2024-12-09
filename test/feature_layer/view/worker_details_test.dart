import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:betalent_mobile_test/feature_layer/home/view/worker_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() {
  group('WorkerDetails', () {
    final worker = BeTalentWorkerModel(
      id: 1,
      name: 'João',
      image:
          'https://img.favpng.com/25/7/23/computer-icons-user-profile-avatar-image-png-favpng-LFqDyLRhe3PBXM0sx2LufsGFU.jpg',
      job: 'Back-end',
      admissionDate: DateTime(2019, 12, 2),
      phone: '5551234567890',
    );

    testWidgets('displays worker details correctly',
        (WidgetTester tester) async {
      await mockNetworkImages(
        () async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: WorkerDetails(worker: worker),
              ),
            ),
          );
        },
      );

      expect(find.text('João'), findsOneWidget);
      expect(find.byType(ImageName), findsOneWidget);
      expect(find.text('Back-end'), findsOneWidget);
      expect(find.text('02/12/2019'), findsOneWidget);
      expect(find.text('+55 (51) 23456-7890'), findsOneWidget);
    });
  });
}
