import 'package:http/http.dart' as http;
import 'package:lonewolfcast_flutter/core/config/env_config.dart';

abstract class BaseApiService {
  final String baseUrl = EnvConfig.baseUrl;
  
  final Map<String, String> headers = {
    'x-apisports-key': EnvConfig.apiKey,
  };

  // Client HTTP réutilisable
  final http.Client client = http.Client();

  void dispose() {
    client.close();
  }
}