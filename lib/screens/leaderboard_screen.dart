import 'package:devbattle/widgets/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20, width: double.infinity),
            SizedBox(
              width: 550,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  topUsersleaderboardWidget(
                    rank: 2,
                    name: 'Rawan Ahmed',
                    score: 100,
                  ),
                  topUsersleaderboardWidget(
                    name: 'Alhamza Nazhan',
                    score: 120,
                    rank: 1,
                  ),
                  topUsersleaderboardWidget(
                    rank: 3,
                    name: 'Momen Raed',
                    score: 90,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            for (int i = 0; i < 7; i++)
              leaderboardWidget(rank: i + 4, name: 'Random Name', score: 100),
          ],
        ),
      ),
    );
  }
}
