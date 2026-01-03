import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';

class FixturesScreen extends StatefulWidget {
  const FixturesScreen({super.key});

  @override
  State<FixturesScreen> createState() => _FixturesScreenState();
}

class _FixturesScreenState extends State<FixturesScreen> {
  late Future<List<Map<String, dynamic>>> _fixturesFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fixturesFuture = _apiService.getUnifiedFixtures();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fixturesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Error fetching fixtures: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No fixtures found.'));
        }

        final fixtures = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: fixtures.length,
          itemBuilder: (context, index) {
            final match = fixtures[index];

            // Check if this is a Manchester United match
            final homeTeam = match['homeTeam']?.toString() ?? '';
            final awayTeam = match['awayTeam']?.toString() ?? '';
            final isMUMatch =
                homeTeam.contains('Man United') ||
                homeTeam.contains('Manchester United') ||
                awayTeam.contains('Man United') ||
                awayTeam.contains('Manchester United');

            String formattedDate = 'Date TBC';
            if (match['date'] != null) {
              try {
                final parsedDateTime = DateTime.parse(match['date'].toString());
                formattedDate = DateFormat('EEE, d MMM').format(parsedDateTime);
              } catch (e) {
                formattedDate = match['date'].toString();
              }
            }

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              elevation: isMUMatch ? 4 : 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side:
                    isMUMatch
                        ? const BorderSide(color: Color(0xFFDA291C), width: 2)
                        : BorderSide.none,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient:
                      isMUMatch
                          ? LinearGradient(
                            colors: [
                              const Color(0xFFDA291C).withOpacity(0.05),
                              Colors.white,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                          : null,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildLeagueInfo(match['league'] ?? 'N/A'),
                      const SizedBox(height: 16),
                      _buildMatchRow(match),
                      const SizedBox(height: 12),
                      _buildMatchStatus(match, formattedDate),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLeagueInfo(String league) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF000000),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.shield, color: Color(0xFFFDB913), size: 14),
          const SizedBox(width: 6),
          Text(
            league,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchRow(Map<String, dynamic> match) {
    final homeScore = match['homeScore'] ?? 0;
    final awayScore = match['awayScore'] ?? 0;
    final status = match['status']?.toString().toUpperCase() ?? '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTeam(name: match['homeTeam'] ?? 'TBA', logo: match['logoHome']),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child:
              (status == 'FT' || status == 'PLAYED')
                  ? Text(
                    '$homeScore - $awayScore',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  )
                  : Text(
                    match['time'] ?? '--:--',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF666666),
                    ),
                  ),
        ),
        _buildTeam(name: match['awayTeam'] ?? 'TBA', logo: match['logoAway']),
      ],
    );
  }

  Widget _buildTeam({required String name, String? logo}) {
    return Expanded(
      child: Column(
        children: [
          if (logo != null && logo.isNotEmpty)
            Image.network(
              logo,
              width: 48,
              height: 48,
              errorBuilder:
                  (context, error, stackTrace) => const Icon(
                    Icons.sports_soccer,
                    size: 48,
                    color: Colors.grey,
                  ),
            )
          else
            const Icon(Icons.sports_soccer, size: 48, color: Colors.grey),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMatchStatus(Map<String, dynamic> match, String formattedDate) {
    final status = match['status']?.toString().toUpperCase() ?? '';
    String statusText = formattedDate;
    Color statusColor = const Color(0xFF666666);
    Color bgColor = const Color(0xFFF5F5F5);

    if (status == 'FT' || status == 'PLAYED') {
      statusText = 'FULL TIME';
      statusColor = Colors.white;
      bgColor = const Color(0xFF666666);
    } else if (status == 'LIVE') {
      statusText = 'LIVE';
      statusColor = Colors.white;
      bgColor = const Color(0xFFDA291C);
    } else {
      statusText = formattedDate.toUpperCase();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: statusColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
