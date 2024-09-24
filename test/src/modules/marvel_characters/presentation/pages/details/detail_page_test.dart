import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_tech_challenge/src/core/core.dart';
import 'package:flutter_tech_challenge/src/modules/marvel_characters/marvel_characters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


class MockHttpClient extends Mock implements HttpClient {}
class MockHttpClientRequest extends Mock implements HttpClientRequest {}
class MockHttpClientResponse extends Mock implements HttpClientResponse {}
class MockHttpHeaders extends Mock implements HttpHeaders {}
class MockStreamSubscription<T> extends Mock implements StreamSubscription<T> {}

void main() {
  late MockHttpClient mockHttpClient;
  late MockHttpClientRequest mockHttpClientRequest;
  late MockHttpClientResponse mockHttpClientResponse;
  late MockHttpHeaders mockHttpHeaders;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));

    mockHttpClient = MockHttpClient();
    mockHttpClientRequest = MockHttpClientRequest();
    mockHttpClientResponse = MockHttpClientResponse();
    mockHttpHeaders = MockHttpHeaders();

    HttpOverrides.global = MyHttpOverrides(mockHttpClient);

    when(() => mockHttpClient.getUrl(any())).thenAnswer((_) async => mockHttpClientRequest);

    when(() => mockHttpClientRequest.close()).thenAnswer((_) async => mockHttpClientResponse);

    when(() => mockHttpClientResponse.statusCode).thenReturn(200);
    when(() => mockHttpClientResponse.contentLength).thenReturn(10);
    when(() => mockHttpClientResponse.compressionState).thenReturn(HttpClientResponseCompressionState.decompressed);
    when(() => mockHttpClientResponse.headers).thenReturn(mockHttpHeaders);

    when(() => mockHttpClientResponse.listen(
        any(),
        onError: any(named: 'onError'),
        onDone: any(named: 'onDone'),
        cancelOnError: any(named: 'cancelOnError'),
      )).thenAnswer((invocation) {
        final onData = invocation.positionalArguments[0] as void Function(Uint8List);
        return Stream<Uint8List>.fromIterable([Uint8List(10)]).listen(onData);
    });
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  group('CharacterDetailsPage', () {
    final testCharacter = Character(
      id: 1,
      name: 'Spider-Man',
      description: 'Friendly neighborhood Spider-Man.',
      imageUrl: 'http://example.com/spiderman.jpg',
    );

    testWidgets('Should display character details correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CharacterDetailsPage(character: testCharacter),
        ),
      );

      expect(find.text(testCharacter.name), findsOneWidget);
      expect(find.text(AppStrings.biography), findsOneWidget);
      expect(find.text(testCharacter.description), findsOneWidget);
    });

    testWidgets('Should display the logo in the AppBar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CharacterDetailsPage(character: testCharacter),
        ),
      );
    });
  });
}

class MyHttpOverrides extends HttpOverrides {
  final HttpClient mockHttpClient;

  MyHttpOverrides(this.mockHttpClient);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return mockHttpClient;
  }
}