import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lonewolfcast_flutter/core/config/env_config.dart';
import 'base_api_service.dart';

class MatchesService extends BaseApiService {
  static final MatchesService _instance = MatchesService._internal();
  
  factory MatchesService() {
    return _instance;
  }
  
  MatchesService._internal();

  Future<List<Map<String, dynamic>>> getTodayMatches() async {
    final List<Map<String, dynamic>> allMatches = [];
    
    try {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final currentYear = DateTime.now().year.toString();

      print('Starting fetch for ${EnvConfig.leagues.length} leagues');
      
      // Pour chaque ligue, faire un appel API séparé
      for (final league in EnvConfig.leagues) {
        final uri = Uri.parse('$baseUrl/fixtures').replace(queryParameters: {
          'date': today,
          'season': currentYear,
          'timezone': 'Europe/Paris',
          'league': league.toString(),
        });
        
        print('Fetching matches for league $league');
        
        try {
          final response = await client.get(uri, headers: headers);
          
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            
            if (data['errors'] != null && data['errors'].isNotEmpty) {
              print('Warning for league $league: ${data['errors']}');
              continue;
            }

            if (data['response'] != null) {
              final matches = List<Map<String, dynamic>>.from(data['response']);
              print('Found ${matches.length} matches for league $league');
              allMatches.addAll(matches);
            }
          } else {
            print('HTTP Error ${response.statusCode} for league $league');
          }

          // Pause entre les appels
          await Future.delayed(const Duration(milliseconds: 200));
          
        } catch (e) {
          print('Error fetching league $league: $e');
          continue;
        }
      }

      // Tri des matchs par date
      allMatches.sort((a, b) {
        final dateA = DateTime.parse(a['fixture']['date']);
        final dateB = DateTime.parse(b['fixture']['date']);
        return dateA.compareTo(dateB);
      });

      print('Total matches found: ${allMatches.length}');
      return allMatches;
      
    } catch (e) {
      print('Error in getTodayMatches: $e');
      rethrow;
    }
  }
}