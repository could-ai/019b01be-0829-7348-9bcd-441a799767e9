import 'dart:async';
import '../models/team_rating.dart';

class SoccerDataService {
  // In a real app, this would be an API endpoint or a backend function 
  // that scrapes soccerrating.org.
  // Since direct browser/mobile scraping of HTTP sites often has CORS/Security issues,
  // we simulate the data structure here.
  
  Future<List<TeamRating>> getDailyIncreases() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock data representing "Daily Ratings Increase"
    // This data mimics what we would parse from the website
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
}
