import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/team_rating.dart';
import '../models/player_rating.dart';
import '../services/soccer_data_service.dart';

class RatingsScreen extends StatefulWidget {
  const RatingsScreen({super.key});

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> with SingleTickerProviderStateMixin {
  final SoccerDataService _service = SoccerDataService();
  late TabController _tabController;
  
  late Future<List<TeamRating>> _teamRatingsFuture;
  late Future<List<PlayerRating>> _playerRatingsFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void _loadData() {
    _teamRatingsFuture = _service.getDailyIncreases();
    _playerRatingsFuture = _service.getDailyPlayerIncreases();
  }

  Future<void> _refreshData() async {
    setState(() {
      _loadData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Rating Increases'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Teams', icon: Icon(Icons.shield)),
            Tab(text: 'Players', icon: Icon(Icons.person)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Source Info'),
                  content: const Text('Data source: soccerrating.org\n(Currently using mock data for demonstration)'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Teams Tab
          _buildTeamsList(),
          // Players Tab
          _buildPlayersList(),
        ],
      ),
    );
  }

  Widget _buildTeamsList() {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: FutureBuilder<List<TeamRating>>(
        future: _teamRatingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return _buildErrorView(snapshot.error);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No team rating increases found today.'));
          }

          final ratings = snapshot.data!;
          // Sort by highest increase first
          ratings.sort((a, b) => b.increase.compareTo(a.increase));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ratings.length,
            itemBuilder: (context, index) {
              final item = ratings[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      _buildRankBadge(index + 1),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.teamName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item.league,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildRatingChange(item.increase, item.oldRating, item.newRating),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPlayersList() {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: FutureBuilder<List<PlayerRating>>(
        future: _playerRatingsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return _buildErrorView(snapshot.error);
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No player rating increases found today.'));
          }

          final ratings = snapshot.data!;
          // Sort by highest increase first
          ratings.sort((a, b) => b.increase.compareTo(a.increase));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ratings.length,
            itemBuilder: (context, index) {
              final item = ratings[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      _buildRankBadge(index + 1),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.playerName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              item.teamName,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildRatingChange(item.increase, item.oldRating, item.newRating, isPlayer: true),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRankBadge(int rank) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.green[50],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '#$rank',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingChange(double increase, double oldRating, double newRating, {bool isPlayer = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Icon(Icons.arrow_upward, size: 16, color: Colors.green[700]),
            Text(
              '+${increase.toStringAsFixed(1)}',
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Text(
          isPlayer 
            ? '${oldRating.toStringAsFixed(1)} ➔ ${newRating.toStringAsFixed(1)}'
            : '${oldRating.toStringAsFixed(0)} ➔ ${newRating.toStringAsFixed(0)}',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView(Object? error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text('Error: $error'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _refreshData,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
