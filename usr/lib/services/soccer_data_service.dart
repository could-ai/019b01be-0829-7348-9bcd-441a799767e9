import 'dart:async';
import '../models/team_rating.dart';
import '../models/player_rating.dart';

class SoccerDataService {
  // In a real app, this would be an API endpoint or a backend function 
  // that scrapes soccerrating.org.
  
  Future<List<TeamRating>> getDailyIncreases() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock data representing "Daily Ratings Increase" for Teams
    return [
      TeamRating(
        teamName: "Manchester City",
        league: "Premier League",
        oldRating: 2010.5,
        newRating: 2015.2,
        date: DateTime.now(),
      ),
      TeamRating(
        teamName: "Real Madrid",
        league: "La Liga",
        oldRating: 1980.0,
        newRating: 1988.5,
        date: DateTime.now(),
      ),
      TeamRating(
        teamName: "Bayer Leverkusen",
        league: "Bundesliga",
        oldRating: 1850.2,
        newRating: 1865.8,
        date: DateTime.now(),
      ),
      TeamRating(
        teamName: "Inter Milan",
        league: "Serie A",
        oldRating: 1920.1,
        newRating: 1925.4,
        date: DateTime.now(),
      ),
      TeamRating(
        teamName: "Arsenal",
        league: "Premier League",
        oldRating: 1950.0,
        newRating: 1954.2,
        date: DateTime.now(),
      ),
      TeamRating(
        teamName: "Girona",
        league: "La Liga",
        oldRating: 1780.5,
        newRating: 1795.0,
        date: DateTime.now(),
      ),
      TeamRating(
        teamName: "Sporting CP",
        league: "Primeira Liga",
        oldRating: 1720.0,
        newRating: 1732.1,
        date: DateTime.now(),
      ),
    ];
  }

  Future<List<PlayerRating>> getDailyPlayerIncreases() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock data representing "Daily Ratings Increase" for Players
    return [
      PlayerRating(
        playerName: "Erling Haaland",
        teamName: "Manchester City",
        oldRating: 8.5,
        newRating: 8.9,
        date: DateTime.now(),
      ),
      PlayerRating(
        playerName: "Jude Bellingham",
        teamName: "Real Madrid",
        oldRating: 8.2,
        newRating: 8.7,
        date: DateTime.now(),
      ),
      PlayerRating(
        playerName: "Harry Kane",
        teamName: "Bayern Munich",
        oldRating: 8.1,
        newRating: 8.4,
        date: DateTime.now(),
      ),
      PlayerRating(
        playerName: "Kylian Mbappé",
        teamName: "PSG",
        oldRating: 8.6,
        newRating: 8.8,
        date: DateTime.now(),
      ),
      PlayerRating(
        playerName: "Bukayo Saka",
        teamName: "Arsenal",
        oldRating: 7.9,
        newRating: 8.3,
        date: DateTime.now(),
      ),
      PlayerRating(
        playerName: "Mohamed Salah",
        teamName: "Liverpool",
        oldRating: 8.0,
        newRating: 8.2,
        date: DateTime.now(),
      ),
      PlayerRating(
        playerName: "Vinícius Júnior",
        teamName: "Real Madrid",
        oldRating: 8.3,
        newRating: 8.6,
        date: DateTime.now(),
      ),
    ];
  }
}
