import 'package:flutter/material.dart';
import 'package:lonewolfcast_flutter/core/models/match.dart';
import 'package:lonewolfcast_flutter/features/home/screens/match_details_screen.dart';
import 'package:lonewolfcast_flutter/features/home/screens/match_prediction_screen.dart';

class MatchNavigation {
  static const String matchDetails = '/match-details';
  static const String matchPredictions = '/match-predictions';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case matchDetails:
        final Match match = settings.arguments as Match;
        return MaterialPageRoute(
          builder: (_) => MatchDetailsScreen(match: match),
        );
      case matchPredictions:
        final Match match = settings.arguments as Match;
        return MaterialPageRoute(
          builder: (_) => MatchPredictionScreen(match: match),
        );
      default:
        return null;
    }
  }

  static void toMatchDetails(BuildContext context, Match match) {
    Navigator.pushNamed(
      context,
      matchDetails,
      arguments: match,
    );
  }

  static void toMatchPredictions(BuildContext context, Match match) {
    Navigator.pushNamed(
      context,
      matchPredictions,
      arguments: match,
    );
  }
}