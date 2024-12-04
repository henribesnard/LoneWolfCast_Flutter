class MatchPrediction {
  final PredictionDetails predictions;
  
  MatchPrediction({required this.predictions});

  factory MatchPrediction.fromJson(Map<String, dynamic> json) {
    return MatchPrediction(
      predictions: PredictionDetails.fromJson(json['predictions'] ?? {}),
    );
  }
}

class PredictionDetails {
  final String? advice;
  final WinnerPrediction? winner;
  final PredictionPercent? percent;
  final bool? winOrDraw;
  final String? underOver;
  final PredictionGoals? goals;

  PredictionDetails({
    this.advice,
    this.winner,
    this.percent,
    this.winOrDraw,
    this.underOver,
    this.goals,
  });

  factory PredictionDetails.fromJson(Map<String, dynamic> json) {
    return PredictionDetails(
      advice: json['advice'],
      winner: json['winner'] != null ? WinnerPrediction.fromJson(json['winner']) : null,
      percent: json['percent'] != null ? PredictionPercent.fromJson(json['percent']) : null,
      winOrDraw: json['win_or_draw'],
      underOver: json['under_over'],
      goals: json['goals'] != null ? PredictionGoals.fromJson(json['goals']) : null,
    );
  }
}

// Classes auxiliaires
class WinnerPrediction {
  final int? id;
  final String? name;
  final String? comment;

  WinnerPrediction({this.id, this.name, this.comment});

  factory WinnerPrediction.fromJson(Map<String, dynamic> json) {
    return WinnerPrediction(
      id: json['id'],
      name: json['name'],
      comment: json['comment'],
    );
  }
}

class PredictionGoals {
  final String? home;
  final String? away;

  PredictionGoals({this.home, this.away});

  factory PredictionGoals.fromJson(Map<String, dynamic> json) {
    return PredictionGoals(
      home: json['home']?.toString(),
      away: json['away']?.toString(),
    );
  }
}

class PredictionPercent {
  final String? home;
  final String? draw;
  final String? away;

  PredictionPercent({this.home, this.draw, this.away});

  factory PredictionPercent.fromJson(Map<String, dynamic> json) {
    return PredictionPercent(
      home: json['home'],
      draw: json['draw'],
      away: json['away'],
    );
  }
}