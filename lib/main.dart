import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'src/modules/marvel_characters/marvel_characters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/config/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CharacterProvider(
            GetCharactersUsecase(
              CharacterRepositoryImpl(
                CharacterRemoteDataSource(Dio()),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const HomePage(), // Rota inicial (Home)
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/details') {
            final character = settings.arguments as Character;
            return MaterialPageRoute(
              builder: (context) {
                return CharacterDetailsPage(character: character);
              },
            );
          }
          return null; // Retorna null se a rota não for encontrada
        },
      ),
    );
  }
}