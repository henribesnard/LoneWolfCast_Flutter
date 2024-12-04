import 'package:flutter/material.dart';
import 'package:lonewolfcast_flutter/core/models/match.dart';
import 'package:lonewolfcast_flutter/core/utils/translations.dart';

class MatchHeader extends StatelessWidget {
  final Match match;

  const MatchHeader({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.network(
              match.league.logo,
              width: 24,
              height: 24,
              errorBuilder: (_, __, ___) => const Icon(Icons.sports_soccer, size: 24),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    match.league.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Translations.getCountryName(match.league.country),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (match.league.round != null) ...[
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              Translations.getRoundName(match.league.round ?? ''),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ],
    );
  }
}