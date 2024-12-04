import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  
  static List<int> get leagues {
    final leaguesString = dotenv.env['LEAGUES'] ?? '';
    return leaguesString
        .split(',')
        .map((e) => int.tryParse(e.trim()))
        .where((e) => e != null)
        .map((e) => e!)
        .toList();
  }

  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }
}