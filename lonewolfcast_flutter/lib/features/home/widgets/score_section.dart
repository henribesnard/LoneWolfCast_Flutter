import 'package:flutter/material.dart';
import 'package:lonewolfcast_flutter/core/models/match.dart';

class ScoreSection extends StatelessWidget {
  final Match match;
  final String matchTime;

  const ScoreSection({
    super.key,
    required this.match,
    required this.matchTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: match.isLive ? Colors.red.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            match.isLive
                ? '${match.goals?.home ?? 0} - ${match.goals?.away ?? 0}'
                : matchTime,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: match.isLive ? Colors.red : Colors.black87,
            ),
          ),
          if (match.isLive) ...[
            const SizedBox(height: 4),
            Text(
              '${match.fixture.status.elapsed ?? 0}\'',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}