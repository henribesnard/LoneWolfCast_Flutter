import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lonewolfcast_flutter/core/models/match.dart';
import 'package:lonewolfcast_flutter/features/home/widgets/match_header.dart';
import 'package:lonewolfcast_flutter/features/home/widgets/team_info.dart';
import 'package:lonewolfcast_flutter/features/home/widgets/score_section.dart';

class MatchCard extends StatelessWidget {
  final Match match;
  final VoidCallback? onStatsTap;
  final VoidCallback? onPredictionTap;

  const MatchCard({
    super.key,
    required this.match,
    this.onStatsTap,
    this.onPredictionTap,
  });

  @override
  Widget build(BuildContext context) {
    final matchTime = match.fixture.date != null 
        ? DateFormat('HH:mm').format(DateTime.parse(match.fixture.date!).toLocal())
        : '--:--';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                MatchHeader(match: match),
                const Divider(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TeamInfo(
                        name: match.teams.home.name,
                        logo: match.teams.home.logo,
                        alignment: TextAlign.end,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ScoreSection(
                      match: match,
                      matchTime: matchTime,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TeamInfo(
                        name: match.teams.away.name,
                        logo: match.teams.away.logo,
                        alignment: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                _buildPredictionSection(),
              ],
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildPredictionSection() {
    if (match.prediction?.advice == null) return const SizedBox.shrink();

    return Column(
      children: [
        const Divider(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              const Text(
                'Prédiction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                match.prediction!.advice!,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.blue,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: onStatsTap,
              icon: const Icon(Icons.analytics, size: 20),
              label: const Text('Stats'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[800],
              ),
            ),
          ),
          Container(
            width: 1,
            height: 24,
            color: Colors.grey[300],
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: onPredictionTap,
              icon: const Icon(Icons.trending_up, size: 20),
              label: const Text('Prédictions'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}