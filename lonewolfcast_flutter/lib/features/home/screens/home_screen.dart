import 'package:flutter/material.dart';
import 'package:lonewolfcast_flutter/core/models/match.dart';
import 'package:lonewolfcast_flutter/features/home/navigation/match_navigation.dart';
import 'package:lonewolfcast_flutter/features/home/widgets/match_card.dart';
import 'package:lonewolfcast_flutter/services/api/matches_service.dart';
import 'package:lonewolfcast_flutter/services/api/predictions_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _matchesService = MatchesService();
  final _predictionsService = PredictionsService();
  
  List<Match> _liveMatches = [];
  List<Match> _upcomingMatches = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  @override
  void dispose() {
    _matchesService.dispose();
    _predictionsService.dispose();
    super.dispose();
  }

Future<void> _loadMatches() async {
  try {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    // Récupération des matchs
    final matches = await _matchesService.getTodayMatches();
    print('Récupération réussie de ${matches.length} matchs');

    // Traitement sécurisé des matchs
    final processedMatches = <Match>[];
    
    for (var matchData in matches) {
      try {
        // Vérification et traitement de chaque match individuellement
        final match = Match.fromJson(matchData);
        print('Traitement réussi du match: ${match.teams.home.name} vs ${match.teams.away.name}');
        processedMatches.add(match);
      } catch (e) {
        print('Erreur lors du traitement d\'un match: $e');
        // Continue avec le prochain match au lieu d'arrêter le processus
        continue;
      }
    }

    print('Matches traités avec succès: ${processedMatches.length}');

    // Mise à jour de l'état
    setState(() {
      _liveMatches = processedMatches.where((m) => m.isLive).toList();
      _upcomingMatches = processedMatches.where((m) => m.isUpcoming).toList();
      _isLoading = false;
    });

    print('État mis à jour - Matchs en direct: ${_liveMatches.length}, Matchs à venir: ${_upcomingMatches.length}');

  } catch (e, stackTrace) {
    print('Erreur lors du chargement des matchs:');
    print('Error: $e');
    print('Stack trace: $stackTrace');
    
    setState(() {
      _error = 'Erreur lors du chargement des matchs';
      _isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Matchs du jour',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMatches,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Chargement des matchs...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Erreur: $_error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadMatches,
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    if (_liveMatches.isEmpty && _upcomingMatches.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sports_soccer,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Aucun match aujourd\'hui',  // Modifié pour refléter l'absence de matchs en général
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadMatches,
              icon: const Icon(Icons.refresh),
              label: const Text('Actualiser'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadMatches,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          if (_liveMatches.isNotEmpty) ...[
            _buildSectionHeader('En Direct', Colors.red),
            ..._liveMatches.map(_buildMatchCard),
            const SizedBox(height: 16),
          ],
          if (_upcomingMatches.isNotEmpty) ...[
            _buildSectionHeader('À Venir', Colors.blue),
            ..._upcomingMatches.map(_buildMatchCard),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(Match match) {
    return MatchCard(
      match: match,
      onStatsTap: () => MatchNavigation.toMatchDetails(context, match),
      onPredictionTap: () => MatchNavigation.toMatchPredictions(context, match),
    );
  }
}