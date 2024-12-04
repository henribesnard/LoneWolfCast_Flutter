import 'package:intl/intl.dart';

class Match {
  final Fixture fixture;
  final League league;
  final Teams teams;
  final Goals? goals;
  final Score? score;

  Match({
    required this.fixture,
    required this.league,
    required this.teams,
    this.goals,
    this.score,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    try {
      return Match(
        fixture: Fixture.fromJson(json['fixture'] ?? {}),
        league: League.fromJson(json['league'] ?? {}),
        teams: Teams.fromJson(json['teams'] ?? {}),
        goals: json['goals'] != null ? Goals.fromJson(json['goals']) : Goals(),
        score: json['score'] != null ? Score.fromJson(json['score']) : Score(),
      );
    } catch (e) {
      print('Error parsing Match: $e');
      rethrow;
    }
  }

  bool get isLive => 
    fixture.status.short == '1H' || 
    fixture.status.short == 'HT' || 
    fixture.status.short == '2H';

  bool get isUpcoming => fixture.status.short == 'NS';
  
  int get homeGoals => goals?.home ?? 0;
  int get awayGoals => goals?.away ?? 0;
}

class Fixture {
  final int? id;
  final String? date;
  final Status status;
  final Venue? venue;

  Fixture({
    this.id,
    this.date,
    required this.status,
    this.venue,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['id'],
      date: json['date'],
      status: Status.fromJson(json['status'] ?? {}),
      venue: json['venue'] != null ? Venue.fromJson(json['venue']) : null,
    );
  }
}

class Status {
  final String long;
  final String short;
  final int? elapsed;

  Status({
    required this.long,
    required this.short,
    this.elapsed,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      long: json['long'] ?? '',
      short: json['short'] ?? '',
      elapsed: json['elapsed'],
    );
  }
}

class League {
  final int? id;
  final String name;
  final String country;
  final String logo;
  final String? flag;
  final int? season;
  final String? round;

  League({
    this.id,
    required this.name,
    required this.country,
    required this.logo,
    this.flag,
    this.season,
    this.round,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      logo: json['logo'] ?? '',
      flag: json['flag'],
      season: json['season'],
      round: json['round'],
    );
  }
}

class Teams {
  final Team home;
  final Team away;

  Teams({
    required this.home,
    required this.away,
  });

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      home: Team.fromJson(json['home'] ?? {}),
      away: Team.fromJson(json['away'] ?? {}),
    );
  }
}

class Team {
  final int? id;
  final String name;
  final String logo;
  final bool? winner;

  Team({
    this.id,
    required this.name,
    required this.logo,
    this.winner,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      winner: json['winner'],
    );
  }
}

class Goals {
  final int? home;
  final int? away;

  Goals({
    this.home = 0,
    this.away = 0,
  });

  factory Goals.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Goals();
    return Goals(
      home: json['home'] ?? 0,
      away: json['away'] ?? 0,
    );
  }
}

class Score {
  final Goals? halftime;
  final Goals? fulltime;
  final Goals? extratime;
  final Goals? penalty;

  Score({
    this.halftime,
    this.fulltime,
    this.extratime,
    this.penalty,
  });

  factory Score.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Score();
    return Score(
      halftime: Goals.fromJson(json['halftime']),
      fulltime: Goals.fromJson(json['fulltime']),
      extratime: json['extratime'] != null ? Goals.fromJson(json['extratime']) : null,
      penalty: json['penalty'] != null ? Goals.fromJson(json['penalty']) : null,
    );
  }
}

class Venue {
  final int? id;
  final String name;
  final String city;

  Venue({
    this.id,
    required this.name,
    required this.city,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'],
      name: json['name'] ?? '',
      city: json['city'] ?? '',
    );
  }
}