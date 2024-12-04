import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lonewolfcast_flutter/core/models/match.dart';
import 'package:lonewolfcast_flutter/services/api/api_service.dart';
import 'package:lonewolfcast_flutter/core/utils/translations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiFootballService _apiService = ApiFootballService();
  List<Match> _liveMatches = [];
  List<Match> _upcomingMatches = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  Future<void> _loadMatches() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final matches = await _apiService.getTodayMatches();
      final allMatches = matches.map((m) => Match.fromJson(m)).toList();

      setState(() {
        _liveMatches = allMatches.where((m) => m.isLive).toList();
        _upcomingMatches = allMatches.where((m) => m.isUpcoming).toList();
        _isLoading = false;
      });
      
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      print('Error loading matches: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Matchs du jour',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadMatches,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Erreur: $_error',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadMatches,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    if (_liveMatches.isEmpty && _upcomingMatches.isEmpty) {
      return const Center(
        child: Text(
          'Aucun match aujourd\'hui',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadMatches,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          if (_liveMatches.isNotEmpty) ...[
            _buildSectionHeader('En Direct', Colors.red),
            ..._liveMatches.map((match) => _buildMatchCard(match, true)),
            const SizedBox(height: 16),
          ],
          if (_upcomingMatches.isNotEmpty) ...[
            _buildSectionHeader('À Venir', Colors.blue),
            ..._upcomingMatches.map((match) => _buildMatchCard(match, false)),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(Match match, bool isLive) {
    final matchTime = match.fixture.date != null 
        ? DateFormat('HH:mm').format(DateTime.parse(match.fixture.date!).toLocal())
        : '--:--';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          // TODO: Navigation vers les stats du match
          print('Match tapped: ${match.teams.home.name} vs ${match.teams.away.name}');
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMatchHeader(match),
              const Divider(height: 16),
              _buildMatchContent(match, matchTime),
              if (match.league.round != null) ...[
                const SizedBox(height: 8),
                _buildRoundInfo(match),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchHeader(Match match) {
    return Row(
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
    );
  }

  Widget _buildRoundInfo(Match match) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMatchContent(Match match, String matchTime) {
    return Row(
      children: [
        Expanded(
          child: _buildTeamInfo(
            match.teams.home.name,
            match.teams.home.logo,
            alignment: TextAlign.end,
          ),
        ),
        const SizedBox(width: 8),
        _buildScoreSection(match, matchTime),
        const SizedBox(width: 8),
        Expanded(
          child: _buildTeamInfo(
            match.teams.away.name,
            match.teams.away.logo,
            alignment: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Widget _buildTeamInfo(String name, String logo, {TextAlign? alignment}) {
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

  Widget _buildScoreSection(Match match, String matchTime) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: match.isLive ? Colors.red.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            match.isLive
                ? '${match.goals?.home ?? 0} - ${match.goals?.away ?? 0}'
                : matchTime,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: match.isLive ? Colors.red : Colors.black87,
            ),
          ),
          if (match.isLive) ...[
            const SizedBox(height: 4),
            Text(
              '${match.fixture.status.elapsed ?? 0}\'',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}