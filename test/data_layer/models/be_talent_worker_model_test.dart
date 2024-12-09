import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BeTalentWorkerModel =>', () {
    final mockWorkerModel = BeTalentWorkerModel(
      id: 1,
      name: 'John Doe',
      job: 'Software Engineer',
      admissionDate: DateTime.parse('2023-01-01'),
      phone: '1234567890',
      image: 'image_url',
    );

    const mockWorkerModelJson = {
      'id': 1,
      'name': 'John Doe',
      'job': 'Software Engineer',
      'admission_date': '2023-01-01T00:00:00.000',
      'phone': '1234567890',
      'image': 'image_url',
    };

    test('props are correct', () {
      //arrange act assert
      expect(
        mockWorkerModel.props,
        [
          1,
          'John Doe',
          'Software Engineer',
          DateTime.parse('2023-01-01'),
          '1234567890',
          'image_url'
        ],
      );
    });

    test('fromJson creates correct model', () {
      //arrange
      final model = BeTalentWorkerModel.fromJson(mockWorkerModelJson);
      //act & assert
      expect(model, mockWorkerModel);
    });

    test('toJson returns correct map', () {
      //arrange
      final json = mockWorkerModel.toJson();
      //act & assert
      expect(json, mockWorkerModelJson);
    });
  });
}
