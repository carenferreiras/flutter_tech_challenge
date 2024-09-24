import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tech_challenge/src/modules/marvel_characters/marvel_characters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

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

  group('HomePage', () {
    final testCharacter = Character(
      id: 1,
      name: 'Spider-Man',
      description: 'Friendly neighborhood Spider-Man.',
      imageUrl: 'http://example.com/spiderman.jpg',
    );

    testWidgets('Should display loading spinner when loading', (WidgetTester tester) async {
      // Mocking CharacterProvider to simulate loading state
      final mockProvider = MockCharacterProvider();
      when(() => mockProvider.isLoading).thenReturn(true);
      when(() => mockProvider.characters).thenReturn([]);
      when(() => mockProvider.filteredCharacters).thenReturn([]);
      when(() => mockProvider.getLastClickedCharacters()).thenReturn([]);
      when(() => mockProvider.fetchCharacters()).thenAnswer((_) async => Future<void>.value());

      await tester.pumpWidget(
        ChangeNotifierProvider<CharacterProvider>.value(
          value: mockProvider,
          child: const MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      expect(find.byType(SpinKitThreeBounce), findsOneWidget);
    });

    testWidgets('Should display characters when loaded', (WidgetTester tester) async {
      final mockProvider = MockCharacterProvider();
      when(() => mockProvider.isLoading).thenReturn(false);
      when(() => mockProvider.characters).thenReturn([testCharacter]);
      when(() => mockProvider.filteredCharacters).thenReturn([testCharacter]);
      when(() => mockProvider.getLastClickedCharacters()).thenReturn([testCharacter]);
      when(() => mockProvider.fetchCharacters()).thenAnswer((_) async => Future<void>.value());

      await tester.pumpWidget(
        ChangeNotifierProvider<CharacterProvider>.value(
          value: mockProvider,
          child: const MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      expect(find.text('Spider-Man').at(0), findsOneWidget);
      expect(find.byType(CharacterCardWidget), findsWidgets);
    });

    testWidgets('Should display the AppBar logo', (WidgetTester tester) async {
      final mockProvider = MockCharacterProvider();
      when(() => mockProvider.isLoading).thenReturn(false);
      when(() => mockProvider.characters).thenReturn([testCharacter]);
      when(() => mockProvider.filteredCharacters).thenReturn([testCharacter]);
      when(() => mockProvider.getLastClickedCharacters()).thenReturn([testCharacter]);
      when(() => mockProvider.fetchCharacters()).thenAnswer((_) async => Future<void>.value());

      await tester.pumpWidget(
        ChangeNotifierProvider<CharacterProvider>.value(
          value: mockProvider,
          child: const MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byKey(const Key('logo')), findsOneWidget);
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

class MockCharacterProvider extends Mock implements CharacterProvider {}