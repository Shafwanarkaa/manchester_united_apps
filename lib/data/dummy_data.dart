
import '../models/news_article.dart';

class DummyData {
  // --- NEWS ---
  static final List<NewsArticle> news = [
    NewsArticle(
      title: 'Man Utd Legends Return for Charity Match',
      author: 'John Doe',
      url: 'https://www.manutd.com/en/news/detail/man-utd-legends-return-for-charity-match',
      urlToImage:
          'https://img.chelseafc.com/image/upload/f_auto,h_720,q_auto/embed/editorial/match-reports/2023-24/newcastle-v-chelsea-pl/Mount_celebrates_v_Newcastle_2324.jpg',
      publishedAt: DateTime.parse('2024-05-18T12:00:00Z'),
      content:
          'A host of club legends returned to Old Trafford on Saturday to participate in a special charity match, raising funds for the Manchester United Foundation. The likes of Wayne Rooney, Ryan Giggs, and Paul Scholes graced the pitch once more, delighting fans and contributing to a noble cause.',
    ),
    NewsArticle(
      title: 'Transfer Talk: United Eyeing New Midfielder',
      author: 'Jane Smith',
      url: 'https://www.manutd.com/en/news/detail/transfer-talk-united-eyeing-new-midfielder',
      urlToImage:
          'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt4644a563f665cd4b/6280b33842c5a71025537613/GettyImages-1240417978.jpg',
      publishedAt: DateTime.parse('2024-05-17T09:30:00Z'),
      content:
          'Sources close to the club suggest that Manchester United are actively scouting for a new central midfielder to bolster their squad for the upcoming season. Several high-profile names have been linked with a potential move to Old Trafford as the summer transfer window approaches.',
    ),
    NewsArticle(
      title: 'Academy Stars Shine in FA Youth Cup Final',
      author: 'Emily White',
      url: 'https://www.manutd.com/en/news/detail/academy-stars-shine-in-fa-youth-cup-final',
      urlToImage:
          'https://icdn.football-espana.net/wp-content/uploads/2024/05/Xavi-Simons-Barcelona.jpg',
      publishedAt: DateTime.parse('2024-05-16T20:00:00Z'),
      content:
          'Manchester United\'s U18s have lifted the FA Youth Cup after a thrilling victory at Old Trafford. The young Red Devils showcased immense talent and determination, with several players delivering standout performances that have fans excited for the future of the club.',
    ),
  ];

  // --- SQUAD (Updated with photos) ---
  static final List<Map<String, dynamic>> squad = [
    // Goalkeepers
    {'name': 'Altay Bayindir', 'position': 'Goalkeeper', 'number': '1', 'image': 'https://tmssl.akamaized.net/images/portrait/header/335619-1693832933.jpg'},
    {'name': 'Tom Heaton', 'position': 'Goalkeeper', 'number': '22', 'image': 'https://tmssl.akamaized.net/images/portrait/header/41250-1685021422.jpg'},
    {'name': 'Steven Lammens', 'position': 'Goalkeeper', 'number': '31', 'image': 'https://tmssl.akamaized.net/images/portrait/header/541203-1685023933.jpg'},

    // Defenders
    {'name': 'Matthijs de Ligt', 'position': 'Defender', 'number': '4', 'image': 'https://tmssl.akamaized.net/images/portrait/header/326031-1685022288.jpg'},
    {'name': 'Harry Maguire', 'position': 'Defender', 'number': '5', 'image': 'https://tmssl.akamaized.net/images/portrait/header/17761-1685021503.jpg'},
    {'name': 'Lisandro Martínez', 'position': 'Defender', 'number': '6', 'image': 'https://tmssl.akamaized.net/images/portrait/header/487615-1685021960.jpg'},
    {'name': 'Leny Yoro', 'position': 'Defender', 'number': '15', 'image': 'https://tmssl.akamaized.net/images/portrait/header/1012379-1699971037.jpg'},
    {'name': 'Luke Shaw', 'position': 'Defender', 'number': '23', 'image': 'https://tmssl.akamaized.net/images/portrait/header/183288-1685021647.jpg'},
    {'name': 'Ayden Heaven', 'position': 'Defender', 'number': '26', 'image': 'https://ballerupdates.com/wp-content/uploads/2024/02/Ayden-Heaven.jpg'},
    {'name': 'Tyler Fredricson', 'position': 'Defender', 'number': '33', 'image': 'https://thepeoplesperson.com/wp-content/uploads/2024/02/tyler-fredricson-man-utd-academy-1024x683.jpg'},
    {'name': 'Tyrell Malacia', 'position': 'Defender', 'number': '12', 'image': 'https://tmssl.akamaized.net/images/portrait/header/267615-1685021873.jpg'},
    {'name': 'Diego Leon', 'position': 'Defender', 'number': '35', 'image': 'https://www.fifacm.com/content/media/players/24/281639.png'},
    {'name': 'Noussair Mazraoui', 'position': 'Defender', 'number': '3', 'image': 'https://tmssl.akamaized.net/images/portrait/header/257373-1685022212.jpg'},
    {'name': 'Diogo Dalot', 'position': 'Defender', 'number': '2', 'image': 'https://tmssl.akamaized.net/images/portrait/header/357155-1685021743.jpg'},
    {'name': 'Patrick Dorgu', 'position': 'Defender', 'number': '13', 'image': 'https://tmssl.akamaized.net/images/portrait/header/921536-1688632616.jpg'},

    // Midfielders
    {'name': 'Bruno Fernandes', 'position': 'Midfielder', 'number': '8', 'image': 'https://tmssl.akamaized.net/images/portrait/header/240306-1685021798.jpg'},
    {'name': 'Casemiro', 'position': 'Midfielder', 'number': '18', 'image': 'https://tmssl.akamaized.net/images/portrait/header/10256-1685021571.jpg'},
    {'name': 'Manuel Ugarte', 'position': 'Midfielder', 'number': '25', 'image': 'https://tmssl.akamaized.net/images/portrait/header/489980-1685350849.jpg'},
    {'name': 'Kobbie Mainoo', 'position': 'Midfielder', 'number': '37', 'image': 'https://tmssl.akamaized.net/images/portrait/header/798263-1708684742.jpg'},
    {'name': 'Mason Mount', 'position': 'Midfielder', 'number': '7', 'image': 'https://tmssl.akamaized.net/images/portrait/header/344111-1688632190.jpg'},

    // Forwards
    {'name': 'Amad', 'position': 'Forward', 'number': '16', 'image': 'https://tmssl.akamaized.net/images/portrait/header/536835-1685022135.jpg'},
    {'name': 'Matheus Cunha', 'position': 'Forward', 'number': '10', 'image': 'https://tmssl.akamaized.net/images/portrait/header/517892-1692886497.jpg'},
    {'name': 'Bryan Mbeumo', 'position': 'Forward', 'number': '19', 'image': 'https://tmssl.akamaized.net/images/portrait/header/399461-1692886733.jpg'},
    {'name': 'Shola Lacey', 'position': 'Forward', 'number': '61', 'image': 'https://thepeoplesperson.com/wp-content/uploads/2023/10/shea-lacey-man-utd-academy-1-e1697211116824.jpg'},
    {'name': 'Joshua Zirkzee', 'position': 'Forward', 'number': '11', 'image': 'https://tmssl.akamaized.net/images/portrait/header/435648-1709720333.jpg'},
    {'name': 'Benjamin Sesko', 'position': 'Forward', 'number': '30', 'image': 'https://tmssl.akamaized.net/images/portrait/header/628522-1688632408.jpg'},
    {'name': 'Chido Obi', 'position': 'Forward', 'number': '32', 'image': 'https://tmssl.akamaized.net/images/portrait/header/1004882-1715091726.jpg'},
  ];

  // --- SHOP (UPDATED) ---
  static final List<Map<String, dynamic>> shopItems = [
    {
      'id': 'item_001',
      'name': 'Home Kit 2023/24',
      'price': 75.00,
      'image': 'https://store.manutd.com/content/ws/all/92053423-747f-4447-9896-107577239c4a-800.png',
      'sizes': ['S', 'M', 'L', 'XL'],
    },
    {
      'id': 'item_002',
      'name': 'Away Kit 2023/24',
      'price': 75.00,
      'image': 'https://images.footballfanatics.com/manchester-united/manchester-united-away-shirt-2023-24_ss5_p-13374826+pv-1+u-whikzoplnj8ohqjhgkbk+v-nodxom2ylz2rslueuyj7.jpg?_s=bm-pi-276639-2165',
      'sizes': ['S', 'M', 'L'],
    },
    {
      'id': 'item_003',
      'name': 'Garnacho \'Fearless\' Poster',
      'price': 15.50,
      'image': 'https://i.ebayimg.com/images/g/q1cAAOSwserk4~a1/s-l1600.jpg',
      'sizes': [],
    },
    {
      'id': 'item_004',
      'name': 'Old Trafford Scarf',
      'price': 20.00,
      'image': 'https://store.manutd.com/content/ws/all/0f2a781d-1577-4cfb-810a-289524f0c766-800.png',
      'sizes': [],
    },
    {
      'id': 'item_005',
      'name': 'Team Crest Mug',
      'price': 12.00,
      'image': 'https://store.manutd.com/content/ws/all/a71c26b5-e6a3-4a16-95f7-f58c738e4125-800.png',
      'sizes': [],
    },
    {
      'id': 'item_006',
      'name': 'Third Kit 2023/24',
      'price': 75.00,
      'image': 'https://i1.adis.ws/i/jpl/jd_DX8921-101_a?w=700&resmode=sharp&qlt=70',
      'sizes': ['M', 'L', 'XL'],
    }
  ];

  // --- FIXTURES ---
  static final List<Map<String, dynamic>> fixtures = [
    {
      'homeTeam': 'Man Utd',
      'awayTeam': 'Arsenal',
      'date': '2024-08-24T15:00:00Z',
      'time': '15:00',
      'league': 'Premier League',
      'logoHome': 'https://upload.wikimedia.org/wikipedia/en/thumb/7/7a/Manchester_United_FC_crest.svg/1200px-Manchester_United_FC_crest.svg.png',
      'logoAway': 'https://upload.wikimedia.org/wikipedia/en/thumb/5/53/Arsenal_FC.svg/1200px-Arsenal_FC.svg.png',
      'status': 'NS' // Not Started
    },
    {
      'homeTeam': 'Brighton',
      'awayTeam': 'Man Utd',
      'date': '2024-08-31T15:00:00Z',
      'time': '15:00',
      'league': 'Premier League',
      'logoHome': 'https://upload.wikimedia.org/wikipedia/en/thumb/f/fd/Brighton_%26_Hove_Albion_logo.svg/1200px-Brighton_%26_Hove_Albion_logo.svg.png',
      'logoAway': 'https://upload.wikimedia.org/wikipedia/en/thumb/7/7a/Manchester_United_FC_crest.svg/1200px-Manchester_United_FC_crest.svg.png',
      'status': 'NS'
    },
    {
      'homeTeam': 'Man Utd',
      'awayTeam': 'Man City',
      'date': '2025-01-18T15:00:00Z',
      'time': '15:00',
      'league': 'FA Cup',
      'logoHome': 'https://upload.wikimedia.org/wikipedia/en/thumb/7/7a/Manchester_United_FC_crest.svg/1200px-Manchester_United_FC_crest.svg.png',
      'logoAway': 'https://upload.wikimedia.org/wikipedia/en/thumb/e/eb/Manchester_City_FC_badge.svg/1200px-Manchester_City_FC_badge.svg.png',
      'status': 'NS'
    },
  ];

  // --- STANDINGS ---
  static final List<Map<String, String>> leagues = [
    {'id': 'PL', 'name': 'Premier League'},
    {'id': 'CL', 'name': 'Champions League'},
  ];

  static final List<Map<String, String>> standingsPL = [
    {'rank': '1', 'teamName': 'Man City', 'badge': 'https://upload.wikimedia.org/wikipedia/en/thumb/e/eb/Manchester_City_FC_badge.svg/1200px-Manchester_City_FC_badge.svg.png', 'played': '37', 'win': '27', 'draw': '7', 'loss': '3', 'points': '88'},
    {'rank': '2', 'teamName': 'Arsenal', 'badge': 'https://upload.wikimedia.org/wikipedia/en/thumb/5/53/Arsenal_FC.svg/1200px-Arsenal_FC.svg.png', 'played': '37', 'win': '27', 'draw': '5', 'loss': '5', 'points': '86'},
    {'rank': '3', 'teamName': 'Liverpool', 'badge': 'https://upload.wikimedia.org/wikipedia/en/thumb/0/0c/Liverpool_FC.svg/1200px-Liverpool_FC.svg.png', 'played': '37', 'win': '23', 'draw': '10', 'loss': '4', 'points': '79'},
    {'rank': '8', 'teamName': 'Manchester United', 'badge': 'https://upload.wikimedia.org/wikipedia/en/thumb/7/7a/Manchester_United_FC_crest.svg/1200px-Manchester_United_FC_crest.svg.png', 'played': '37', 'win': '17', 'draw': '6', 'loss': '14', 'points': '57'},
  ];
}
