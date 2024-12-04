import 'package:flutter/material.dart';

class TeamInfo extends StatelessWidget {
  final String name;
  final String logo;
  final TextAlign? alignment;

  const TeamInfo({
    super.key,
    required this.name,
    required this.logo,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment == TextAlign.end 
          ? MainAxisAlignment.end 
          : MainAxisAlignment.start,
      children: [
        if (alignment == TextAlign.end) ...[
          Flexible(
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: alignment,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Image.network(
            logo,
            width: 36,
            height: 36,
            errorBuilder: (_, __, ___) => const Icon(Icons.sports_soccer),
          ),
        ] else ...[
          Image.network(
            logo,
            width: 36,
            height: 36,
            errorBuilder: (_, __, ___) => const Icon(Icons.sports_soccer),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: alignment,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ],
    );
  }
}