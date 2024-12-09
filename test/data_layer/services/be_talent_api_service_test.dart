import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockHttpResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

const rightResponse = '''[
    {
      "id": 1,
      "name": "João",
      "job": "Back-end",
      "admission_date": "2019-12-02T00:00:00.000Z",
      "phone": "5551234567890",
      "image": "https://img.favpng.com/25/7/23/computer-icons-user-profile-avatar-image-png-favpng-LFqDyLRhe3PBXM0sx2LufsGFU.jpg"
    },
    {
      "id": 2,
      "name": "Roberto",
      "job": "Front-end",
      "admission_date": "2020-03-12T00:00:00.000Z",
      "phone": "5550321654789",
      "image": "https://e7.pngegg.com/pngimages/550/997/png-clipart-user-icon-foreigners-avatar-child-face.png"
    },
    {
      "id": 3,
      "name": "Maria",
      "job": "Front-end",
      "admission_date": "2020-03-15T00:00:00.000Z",
      "phone": "5557894561230",
      "image": "https://www.clipartmax.com/png/middle/277-2772117_user-profile-avatar-woman-icon-avatar-png-profile-icon.png"
    }]''';

void main() {
  group('BtcPriceApi =>', () {
    const errorResponse = '{}';
    const emptyResponse = '[]';

    late http.Client httpClient;
    late http.Response response;
    late BeTalentApiService betalentApi;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      response = MockHttpResponse();
      betalentApi = BeTalentApiService(client: httpClient);
    });

    group('constructor =>', () {
      test('does not require an httpClient', () {
        expect(BeTalentApiService(), isNotNull);
      });
    });

    group('getWorkers =>', () {
      test('return the list of workers on valid response', () async {
        //arrange
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(rightResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        //act
        final result = await betalentApi.getWorkers();
        //assert
        expect(
          result,
          isA<List<BeTalentWorkerModel>>()
              .having((e) => e[0].id, 'id', 1)
              .having((e) => e[0].name, 'name', 'João')
              .having((e) => e[0].job, 'job', 'Back-end')
              .having((e) => e[0].admissionDate, 'admissionDate',
                  DateTime.parse('2019-12-02T00:00:00.000Z'))
              .having((e) => e[0].phone, 'phone', '5551234567890')
              .having((e) => e[0].image, 'image',
                  'https://img.favpng.com/25/7/23/computer-icons-user-profile-avatar-image-png-favpng-LFqDyLRhe3PBXM0sx2LufsGFU.jpg')
              .having((e) => e[1].id, 'id', 2)
              .having((e) => e[1].name, 'name', 'Roberto')
              .having((e) => e[1].job, 'job', 'Front-end')
              .having((e) => e[1].admissionDate, 'admissionDate',
                  DateTime.parse('2020-03-12T00:00:00.000Z'))
              .having((e) => e[1].phone, 'phone', '5550321654789')
              .having((e) => e[1].image, 'image',
                  'https://e7.pngegg.com/pngimages/550/997/png-clipart-user-icon-foreigners-avatar-child-face.png')
              .having((e) => e[2].id, 'id', 3)
              .having((e) => e[2].name, 'name', 'Maria')
              .having((e) => e[2].job, 'job', 'Front-end')
              .having((e) => e[2].admissionDate, 'admissionDate',
                  DateTime.parse('2020-03-15T00:00:00.000Z'))
              .having((e) => e[2].phone, 'phone', '5557894561230')
              .having((e) => e[2].image, 'image',
                  'https://www.clipartmax.com/png/middle/277-2772117_user-profile-avatar-woman-icon-avatar-png-profile-icon.png'),
        );
        //expectLater(btcApi.fetchBtcPrice(),completion(isA<String>().having((e) => e, 'value', '50000')));
        verify(() =>
                httpClient.get(Uri.parse('http://10.0.2.2:8080/employees')))
            .called(1);
      });

      test('throws BeTalentApiRequestFailure on non-200 response', () async {
        //arrange
        when(() => response.statusCode).thenReturn(500);
        when(() => response.body).thenReturn(errorResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        //act & assert
        expectLater(
          betalentApi.getWorkers(),
          throwsA(isA<BeTalentApiRequestFailure>()),
        );
      });

      test('throws a BeTalentApiNotFoundException on error response', () async {
        // arrange
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(errorResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        // act & assert
        expectLater(
          betalentApi.getWorkers(),
          throwsA(isA<BeTalentApiNotFoundException>()),
        );
      });

      test(
          'should throw a BeTalentApiNotFoundException exception if the list is empty',
          () async {
        //arange
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(emptyResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        //act & assert
        expectLater(
          betalentApi.getWorkers(),
          throwsA(isA<BeTalentApiNotFoundException>()),
        );
      });
    });
  });
}
