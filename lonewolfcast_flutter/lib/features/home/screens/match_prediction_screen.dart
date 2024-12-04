import 'package:flutter/material.dart';
import 'package:lonewolfcast_flutter/core/models/match.dart';

class MatchPredictionScreen extends StatelessWidget {
  final Match match;

  const MatchPredictionScreen({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prédictions ${match.teams.home.name} vs ${match.teams.away.name}'),
      ),
      body: const Center(
        child: Text('Détails des prédictions à venir'),
      ),
    );
  }
}