import 'package:flutter/material.dart';
import 'squad_screen.dart';
import 'standings_screen.dart';
import 'fixtures_screen.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TabController is used to coordinate the tab bar with the tab views.
    return DefaultTabController(
      length: 3, // We have three tabs: Fixtures, Standings, Squad
      child: Scaffold(
        // We use a nested AppBar for the tabs within the Calendar screen.
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0, // Remove toolbar space since we only have TabBar
          bottom: TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.event), text: 'Fixtures'),
              Tab(icon: Icon(Icons.emoji_events), text: 'Standings'),
              Tab(icon: Icon(Icons.groups), text: 'Squad'),
            ],
            indicatorColor: const Color(0xFFFDB913), // Gold indicator
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ),
        // TabBarView holds the content for each tab.
        body: const TabBarView(
          children: [
            // The content for each tab is the corresponding screen.
            FixturesScreen(),
            StandingsScreen(),
            SquadScreen(),
          ],
        ),
      ),
    );
  }
}
