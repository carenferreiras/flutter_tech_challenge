import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tech_challenge/src/modules/marvel_characters/marvel_characters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio{}


void main(){
  late CharacterRemoteDataSource dataSource;
  late MockDio mockDio;

  setUpAll(()async{
     TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: 'assets/config/.env');
  });

  setUp((){
    mockDio = MockDio();
    dataSource = CharacterRemoteDataSource(mockDio);
  });

  final mockResponseData = {
    'data': {
      'results': [
        {
          'id': 1,
          'name': 'Spider-Man',
          'description': 'Friendly neighborhood Spider-Man.',
          'thumbnail': {
            'path': 'http://example.com/spiderman',
            'extension': 'jpg',
          },
        },
        {
          'id': 2,
          'name': 'Iron Man',
          'description': 'Genius billionaire Tony Stark.',
          'thumbnail': {
            'path': 'http://example.com/ironman',
            'extension': 'jpg',
          },
        },
      ],
    },
  };

  test('Should return a list of CharacterModel when the response is successful ', ()async{
      when(()=> mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
      .thenAnswer((_) async => Response(
        data: mockResponseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ));

      final result = await dataSource.getCharacters();

      expect(result, isA<List<CharacterModel>>());
      expect(result.length, 2);
      expect(result.first.name, 'Spider-Man');
      verify(() => mockDio.get(any(), queryParameters: any(named: 'queryParameters'))).called(1);
  });

  test('Should throw an excepetion when the responsa fails', ()async {
      when(()=> mockDio.get(any(), queryParameters: any(named: 'queryParameters')))
      .thenThrow( DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: ''),
          ),
          type: DioExceptionType.badResponse,));

      expect(()=> dataSource.getCharacters(), throwsA(isA<Exception>()));
      verify(() => mockDio.get(any(),queryParameters: any(named: 'queryParameters'))).called(1);
  });
}