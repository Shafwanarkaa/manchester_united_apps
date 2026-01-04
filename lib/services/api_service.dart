import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv
import '../data/dummy_data.dart';
import '../models/news_article.dart'; // Import the NewsArticle model

class ApiService {
  // --- Keys & Config ---
  static final String _fdApiKey = dotenv.env['FD_API_KEY'] ?? '';
  static final String _rapidApiKey = dotenv.env['RAPID_API_KEY'] ?? '';
  static final String _newsApiKey = dotenv.env['NEWS_API_KEY'] ?? '';

  static const String _fdTeamId = '66';
  static const String _rapidTeamId = '33';
  static const String _rapidSeason = '2023';

  static const Map<String, String> _leagueToRapidId = {
    'PL': '39',
    'CL': '2',
    'FA': '43',
  };

  final Map<String, Map<String, dynamic>> _standingsCache = {};

  // --- Unified Methods ---

  // ... (other methods remain unchanged)

  Future<List<Map<String, dynamic>>> getUnifiedFixtures() async {
    try {
      final rapidData = await _fetchRapidFixtures();
      if (rapidData.isNotEmpty) return rapidData;
    } catch (e) {
      if (kDebugMode) {
        print('RapidAPI Fixtures Failed: $e');
      }
    }

    try {
      final fdData = await _fetchFdFixtures();
      if (fdData.isNotEmpty) return fdData;
    } catch (e) {
      if (kDebugMode) {
        print('FD Fixtures Failed: $e');
      }
    }

    return DummyData.fixtures;
  }

  Future<List<Map<String, dynamic>>> getUnifiedSquad() async {
    Map<String, String> apiPhotos = {};
    try {
      final response = await http.get(
        Uri.parse(
          'https://v3.football.api-sports.io/players/squads?team=$_rapidTeamId',
        ),
        headers: {
          'x-rapidapi-key': _rapidApiKey,
          'x-rapidapi-host': 'v3.football.api-sports.io',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['response'] != null && (data['response'] as List).isNotEmpty) {
          final List<dynamic> apiPlayers = data['response'][0]['players'];
          for (var p in apiPlayers) {
            final name = p['name'].toString();
            final photo = p['photo']?.toString() ?? '';
            if (photo.isNotEmpty) {
              final normalized = name
                  .toLowerCase()
                  .replaceAll('á', 'a')
                  .replaceAll('é', 'e')
                  .replaceAll('í', 'i')
                  .replaceAll('ó', 'o')
                  .replaceAll('ú', 'u')
                  .replaceAll('ı', 'i')
                  .replaceAll('ñ', 'n')
                  .replaceAll('ç', 'c')
                  .replaceAll('š', 's')
                  .replaceAll('ž', 'z');
              apiPhotos[normalized] = photo;
              final parts = normalized.split(' ');
              if (parts.length > 1) apiPhotos[parts.last] = photo;
              if (parts.isNotEmpty) apiPhotos[parts.first] = photo;
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('API Photo fetch failed: $e');
      }
    }

    final enrichedSquad =
        DummyData.squad.map((player) {
          final playerCopy = Map<String, dynamic>.from(player);
          final playerName = player['name'].toString().toLowerCase();
          final photoWhitelist = ['ruben amorim', 'amad', 'chido obi'];
          if (photoWhitelist.contains(playerName)) return playerCopy;
          if (player['name'] != null) {
            final dummyName = player['name']!
                .toLowerCase()
                .replaceAll('á', 'a')
                .replaceAll('é', 'e')
                .replaceAll('í', 'i')
                .replaceAll('ó', 'o')
                .replaceAll('ú', 'u')
                .replaceAll('ı', 'i')
                .replaceAll('ñ', 'n')
                .replaceAll('ç', 'c')
                .replaceAll('š', 's')
                .replaceAll('ž', 'z');
            String? matchedPhoto;
            if (apiPhotos.containsKey(dummyName)) {
              matchedPhoto = apiPhotos[dummyName];
            } else {
              final parts = dummyName.split(' ');
              if (parts.length > 1 && apiPhotos.containsKey(parts.last)) {
                matchedPhoto = apiPhotos[parts.last];
              } else if (parts.isNotEmpty &&
                  apiPhotos.containsKey(parts.first)) {
                matchedPhoto = apiPhotos[parts.first];
              }
            }
            if (matchedPhoto != null && matchedPhoto.isNotEmpty) {
              playerCopy['image'] = matchedPhoto;
            }
          }
          return playerCopy;
        }).toList();
    return enrichedSquad;
  }

  Future<List<Map<String, dynamic>>> fetchStandings({
    String league = 'PL',
    String? season,
    bool forceRefresh = false,
  }) async {
    final useSeason = season ?? _rapidSeason;

    // FORCE DUMMY DATA FOR PL to match user request
    if (league == 'PL') {
      return _getDummyStandings();
    }

    final cacheKey = '$league|$useSeason';
    if (!forceRefresh && _standingsCache.containsKey(cacheKey)) {
      final entry = _standingsCache[cacheKey]!;
      final DateTime ts = entry['timestamp'] as DateTime;
      if (DateTime.now().difference(ts).inMinutes < 5) {
        return List<Map<String, dynamic>>.from(entry['data'] as List);
      }
    }
    try {
      final leagueId = _leagueToRapidId[league] ?? league;
      final uri = Uri.parse(
        'https://v3.football.api-sports.io/standings?league=$leagueId&season=$useSeason',
      );
      final response = await http.get(
        uri,
        headers: {
          'x-rapidapi-key': _rapidApiKey,
          'x-rapidapi-host': 'v3.football.api-sports.io',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['response'] != null && data['response'].isNotEmpty) {
          final standings = data['response'][0]['league']['standings'][0];
          return List<Map<String, dynamic>>.from(
            standings.map(
              (s) => {
                'strTeam': s['team']['name'],
                'strBadge': s['team']['logo'],
                'intRank': s['rank'].toString(),
                'intPlayed': s['all']['played'].toString(),
                'intWin': s['all']['win'].toString(),
                'intDraw': s['all']['draw'].toString(),
                'intLoss': s['all']['lose'].toString(),
                'intGoalDifference': s['goalsDiff'].toString(),
                'intPoints': s['points'].toString(),
                'strForm': s['form'],
                'intGoalsFor': s['all']['goals']['for'].toString(),
                'intGoalsAgainst': s['all']['goals']['against'].toString(),
              },
            ),
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('RapidAPI Standings Failed: $e');
      }
    }
    try {
      String url =
          'https://api.football-data.org/v4/competitions/$league/standings';
      if (kIsWeb) url = 'https://corsproxy.io/?' + Uri.encodeComponent(url);
      final response = await http.get(
        Uri.parse(url),
        headers: {'X-Auth-Token': _fdApiKey},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final standings = data['standings'][0]['table'];
        return List<Map<String, dynamic>>.from(
          standings.map(
            (s) => {
              'strTeam': s['team']['name'],
              'strBadge': s['team']['crest'],
              'intRank': s['position'].toString(),
              'intPlayed': s['playedGames'].toString(),
              'intWin': s['won'].toString(),
              'intDraw': s['draw'].toString(),
              'intLoss': s['lost'].toString(),
              'intGoalDifference': s['goalDifference'].toString(),
              'intPoints': s['points'].toString(),
              'strForm': s['form'] ?? '',
              'intGoalsFor': s['goalsFor'].toString(),
              'intGoalsAgainst': s['goalsAgainst'].toString(),
            },
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('FD Standings Failed: $e');
      }
    }
    final fallback = _getDummyStandings();
    _standingsCache[cacheKey] = {'timestamp': DateTime.now(), 'data': fallback};
    return fallback;
  }

  // --- News API ---
  // MODIFIED: Returns a Future<List<NewsArticle>>
  Future<List<NewsArticle>> fetchNews() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://newsapi.org/v2/everything?q=manchester+united&language=en&sortBy=publishedAt&pageSize=50',
        ),
        headers: {'X-Api-Key': _newsApiKey},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['articles'] as List;

        final filteredArticles =
            articles.where((article) {
              final imageUrl = article['urlToImage']?.toString() ?? '';
              final hasValidImage =
                  imageUrl.isNotEmpty &&
                  !imageUrl.contains('null') &&
                  (imageUrl.startsWith('http://') ||
                      imageUrl.startsWith('https://'));
              final title = article['title']?.toString() ?? '';

              if (!hasValidImage ||
                  title.isEmpty ||
                  title.toLowerCase() == '[removed]') {
                return false;
              }

              final description =
                  article['description']?.toString().toLowerCase() ?? '';
              final isManchesterUnited =
                  title.toLowerCase().contains('manchester united') ||
                  title.toLowerCase().contains('man utd') ||
                  (title.toLowerCase().contains('manchester') &&
                      title.toLowerCase().contains('utd')) ||
                  description.contains('manchester united');

              return isManchesterUnited;
            }).toList();

        // MODIFIED: Map directly to NewsArticle objects using the fromJson factory
        return filteredArticles
            .map((articleJson) => NewsArticle.fromJson(articleJson))
            .toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print('NewsAPI Failed: $e');
      }
    }

    // MODIFIED: Fallback to DummyData.news, which is already List<NewsArticle>
    return DummyData.news;
  }

  // ... (rest of the file remains largely the same, private methods are kept)

  Future<List<Map<String, dynamic>>> _fetchRapidFixtures() async {
    final response = await http.get(
      Uri.parse(
        'https://v3.football.api-sports.io/fixtures?team=$_rapidTeamId&season=$_rapidSeason&next=10',
      ),
      headers: {
        'x-rapidapi-key': _rapidApiKey,
        'x-rapidapi-host': 'v3.football.api-sports.io',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> fixtures = List.from(data['response'] ?? []);

      try {
        final lastResponse = await http.get(
          Uri.parse(
            'https://v3.football.api-sports.io/fixtures?team=$_rapidTeamId&season=$_rapidSeason&last=5',
          ),
          headers: {
            'x-rapidapi-key': _rapidApiKey,
            'x-rapidapi-host': 'v3.football.api-sports.io',
          },
        );

        if (lastResponse.statusCode == 200) {
          final lastData = json.decode(lastResponse.body);
          fixtures.addAll(List.from(lastData['response'] ?? []));
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching last results RapidAPI: $e');
        }
      }

      fixtures.sort(
        (a, b) => a['fixture']['date'].compareTo(b['fixture']['date']),
      );

      return fixtures.map((match) {
        final fixture = match['fixture'];
        final league = match['league'];
        final teams = match['teams'];
        final goals = match['goals'];

        final isHome = teams['home']['id'].toString() == _rapidTeamId;

        return {
          'date': _formatDate(fixture['date']),
          'homeTeam': teams['home']['name'],
          'awayTeam': teams['away']['name'],
          'homeScore': goals['home'] ?? 0,
          'awayScore': goals['away'] ?? 0,
          'time':
              fixture['status']['short'] == 'FT'
                  ? 'FT'
                  : _formatTime(fixture['date']),
          'league': league['name'],
          'isHome': isHome,
          'status': fixture['status']['short'] == 'FT' ? 'played' : 'upcoming',
          'logoHome': teams['home']['logo'],
          'logoAway': teams['away']['logo'],
        };
      }).toList();
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> _fetchFdFixtures() async {
    final response = await http.get(
      Uri.parse(
        'https://api.football-data.org/v4/teams/$_fdTeamId/matches?status=SCHEDULED,FINISHED&limit=20',
      ),
      headers: {'X-Auth-Token': _fdApiKey},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final matches = List<dynamic>.from(data['matches'] ?? []);

      return matches.map((match) {
        final isHome = match['homeTeam']['name'] == 'Manchester United FC';
        return {
          'date': _formatDate(match['utcDate']),
          'homeTeam':
              match['homeTeam']['shortName'] ?? match['homeTeam']['name'],
          'awayTeam':
              match['awayTeam']['shortName'] ?? match['awayTeam']['name'],
          'homeScore': match['score']['fullTime']['home'] ?? 0,
          'awayScore': match['score']['fullTime']['away'] ?? 0,
          'time':
              match['status'] == 'FINISHED'
                  ? 'FT'
                  : _formatTime(match['utcDate']),
          'league': match['competition']['name'] ?? 'Premier League',
          'isHome': isHome,
          'status': match['status'] == 'FINISHED' ? 'played' : 'upcoming',
          'logoHome': match['homeTeam']['crest'],
          'logoAway': match['awayTeam']['crest'],
        };
      }).toList();
    }
    return [];
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}';
    } catch (e) {
      return dateStr;
    }
  }

  String _formatTime(String? timeStr) {
    if (timeStr == null) return '';
    try {
      if (timeStr.contains('T')) {
        final date = DateTime.parse(timeStr);
        return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
      }
      return timeStr;
    } catch (e) {
      return timeStr;
    }
  }

  Future<List<Map<String, dynamic>>> fetchNextFixtures() async {
    final allFixtures = await getUnifiedFixtures();
    final upcoming =
        allFixtures
            .where(
              (m) =>
                  m['status'] == 'upcoming' ||
                  m['status'] == 'TIMED' ||
                  m['status'] == 'SCHEDULED',
            )
            .toList();

    return upcoming;
  }

  Future<List<Map<String, dynamic>>> fetchLastResults() async {
    return getUnifiedFixtures();
  }

  List<Map<String, dynamic>> _getDummyStandings() {
    return List<Map<String, dynamic>>.from(DummyData.standingsPL);
  }
}
