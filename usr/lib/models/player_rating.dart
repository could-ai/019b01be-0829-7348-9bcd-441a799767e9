class PlayerRating {
  final String playerName;
  final String teamName;
  final double oldRating;
  final double newRating;
  final DateTime date;

  PlayerRating({
    required this.playerName,
    required this.teamName,
    required this.oldRating,
    required this.newRating,
    required this.date,
  });

  double get increase => newRating - oldRating;

  factory PlayerRating.fromJson(Map<String, dynamic> json) {
    return PlayerRating(
      playerName: json['playerName'],
      teamName: json['teamName'],
      oldRating: json['oldRating'].toDouble(),
      newRating: json['newRating'].toDouble(),
      date: DateTime.parse(json['date']),
    );
  }
}
