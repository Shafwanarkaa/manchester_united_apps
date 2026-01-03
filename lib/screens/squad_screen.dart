import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Import the ApiService

// Convert to a StatefulWidget to manage the state for the API call.
class SquadScreen extends StatefulWidget {
  const SquadScreen({super.key});

  @override
  State<SquadScreen> createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
  // A Future to hold the result of the enriched squad data.
  late Future<List<Map<String, dynamic>>> _squadFuture;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // Fetch the enriched squad data when the widget is initialized.
    _squadFuture = _apiService.getUnifiedSquad();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _squadFuture,
      builder: (context, snapshot) {
        // While waiting for data, show a loading spinner.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // If an error occurs, display it.
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Error fetching squad data: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // If there's no data, show a message.
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No player data found.'));
        }

        // When data is available, process and display it.
        final players = snapshot.data!;

        // The existing logic for separating players by position.
        final goalkeepers =
            players.where((p) => p['position'] == 'Goalkeeper').toList();
        final defenders =
            players.where((p) => p['position'] == 'Defender').toList();
        final midfielders =
            players.where((p) => p['position'] == 'Midfielder').toList();
        final forwards =
            players.where((p) => p['position'] == 'Forward').toList();

        // The existing ListView layout.
        return ListView(
          children: [
            _buildSectionHeader('Goalkeepers', context),
            ...goalkeepers.map((player) => _buildPlayerTile(player)),
            _buildSectionHeader('Defenders', context),
            ...defenders.map((player) => _buildPlayerTile(player)),
            _buildSectionHeader('Midfielders', context),
            ...midfielders.map((player) => _buildPlayerTile(player)),
            _buildSectionHeader('Forwards', context),
            ...forwards.map((player) => _buildPlayerTile(player)),
          ],
        );
      },
    );
  }

  // --- Helper Widgets (retained and improved from the previous version) ---

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12.0, 16.0, 12.0, 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFDA291C),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.sports_soccer, color: Color(0xFFFDB913), size: 20),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerTile(Map<String, dynamic> player) {
    // Use a placeholder for the image if it's missing or invalid.
    final imageUrl = player['image'] ?? player['photo'] ?? '';
    final playerNumber = player['number']?.toString() ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Player Photo
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFDA291C).withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child:
                      (imageUrl.isNotEmpty && imageUrl.startsWith('http'))
                          ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.person,
                                  size: 32,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          )
                          : Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.person,
                              size: 32,
                              color: Colors.grey,
                            ),
                          ),
                ),
              ),
              const SizedBox(width: 16),
              // Player Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player['name'] ?? 'Unknown Player',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF000000),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      player['position'] ?? 'N/A',
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              // Jersey Number
              if (playerNumber.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDB913).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '#$playerNumber',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFDB913),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
