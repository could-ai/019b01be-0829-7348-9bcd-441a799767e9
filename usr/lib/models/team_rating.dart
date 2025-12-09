class TeamRating {
  final String teamName;
  final String league;
  final double oldRating;
  final double newRating;
  final DateTime date;

  TeamRating({
    required this.teamName,
    required this.league,
    required this.oldRating,
    required this.newRating,
    required this.date,
  });

  double get increase => newRating - oldRating;

  factory TeamRating.fromJson(Map<String, dynamic> json) {
    return TeamRating(
      teamName: json['teamName'],
      league: json['league'],
      oldRating: json['oldRating'].toDouble(),
      newRating: json['newRating'].toDouble(),
      date: DateTime.parse(json['date']),
    );
  }
}
