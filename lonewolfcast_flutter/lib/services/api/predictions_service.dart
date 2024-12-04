import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:lonewolfcast_flutter/core/models/prediction.dart';
import 'base_api_service.dart';

class PredictionsService extends BaseApiService {
  static final PredictionsService _instance = PredictionsService._internal();
  factory PredictionsService() => _instance;
  PredictionsService._internal();

  Future<MatchPrediction?> getPrediction(int? fixtureId) async {
    if (fixtureId == null) return null;

    try {
      if (kIsWeb) {
        return _getWebPrediction(fixtureId);
      }
      return _getNativePrediction(fixtureId);
    } catch (e) {
      print('❌ Prediction error: $e');
      return null;
    }
  }

  Future<MatchPrediction?> _getWebPrediction(int fixtureId) async {
    // Ici, nous utiliserions un proxy backend ou un service cloud
    // Pour l'instant, nous pouvons simuler avec une URL alternative
    final proxyUrl = 'YOUR_PROXY_URL/predictions/$fixtureId';
    final response = await http.get(Uri.parse(proxyUrl));
    
    if (response.statusCode == 200) {
      return MatchPrediction.fromJson(json.decode(response.body));
    }
    return null;
  }

  Future<MatchPrediction?> _getNativePrediction(int fixtureId) async {
    final uri = Uri.parse('$baseUrl/predictions').replace(
      queryParameters: {'fixture': fixtureId.toString()}
    );
    final response = await client.get(uri, headers: headers);
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['response']?.isNotEmpty) {
        return MatchPrediction.fromJson(data['response'][0]);
      }
    }
    return null;
  }
}