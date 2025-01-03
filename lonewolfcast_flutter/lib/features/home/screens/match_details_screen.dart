import 'package:flutter/material.dart';
import 'package:lonewolfcast_flutter/core/models/match.dart';

class MatchDetailsScreen extends StatelessWidget {
  final Match match;

  const MatchDetailsScreen({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats ${match.teams.home.name} vs ${match.teams.away.name}'),
      ),
      body: const Center(
        child: Text('Statistiques du match à venir'),
      ),
    );
  }
}