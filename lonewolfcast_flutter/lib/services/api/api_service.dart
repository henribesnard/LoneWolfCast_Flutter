import 'package:http/http.dart' as http;
import 'package:lonewolfcast_flutter/core/config/env_config.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class ApiFootballService {
  final String _baseUrl = EnvConfig.baseUrl;
  
  final Map<String, String> _headers = {
    'x-apisports-key': EnvConfig.apiKey,
  };

  Future<List<Map<String, dynamic>>> getTodayMatches() async {
    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final currentYear = DateTime.now().year.toString();
      final List<Map<String, dynamic>> allMatches = [];

      print('Starting fetch for ${EnvConfig.leagues.length} leagues');

      // Créer un client unique pour tous les appels
      final client = http.Client();
      
      try {
        // Pour chaque ligue, faire un appel API séparé
        for (final league in EnvConfig.leagues) {
          final uri = Uri.parse('$_baseUrl/fixtures').replace(queryParameters: {
            'date': today,
            'season': currentYear,
            'timezone': 'Europe/Paris',
            'league': league.toString(), // Une seule ligue par appel
          });
          
          print('Fetching matches for league $league');
          
          final response = await client.get(uri, headers: _headers);
          
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            
            if (data['errors'] != null && data['errors'].isNotEmpty) {
              print('Warning for league $league: ${data['errors']}');
              continue; // Passer à la ligue suivante en cas d'erreur
            }

            if (data['response'] != null) {
              final matches = List<Map<String, dynamic>>.from(data['response']);
              print('Found ${matches.length} matches for league $league');
              allMatches.addAll(matches);
            }
          } else {
            print('HTTP Error ${response.statusCode} for league $league: ${response.body}');
          }

          // Petite pause entre les appels pour respecter la limite de l'API
          await Future.delayed(const Duration(milliseconds: 200));
        }
      } finally {
        client.close();
      }

      print('Total matches found: ${allMatches.length}');
      
      // Trier les matchs par date
      allMatches.sort((a, b) {
        final dateA = DateTime.parse(a['fixture']['date']);
        final dateB = DateTime.parse(b['fixture']['date']);
        return dateA.compareTo(dateB);
      });

      return allMatches;
      
    } catch (e) {
      print('Error in getTodayMatches: $e');
      rethrow;
    }
  }
}