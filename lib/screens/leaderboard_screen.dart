import 'package:devbattle/api/leaderboard_api.dart';
import 'package:devbattle/widgets/leaderboard.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final LeaderboardApi _leaderboardApi = LeaderboardApi();
  List<User> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLeaderboard();
  }

  Future<void> _fetchLeaderboard() async {
    try {
      // جلب بيانات لوحة الصدارة من الـ API
      List<User> users = await _leaderboardApi.fetchLeaderboard(limit: 10);
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching leaderboard: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          _isLoading
              ? Center(
                child: CircularProgressIndicator(),
              ) // عرض مؤشر التحميل أثناء جلب البيانات
              : SingleChildScrollView(
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
                          if (_users.length > 1)
                            topUsersleaderboardWidget(
                              rank: 2,
                              name: _users[1].name,
                              score: _users[1].score,
                            ),
                          if (_users.isNotEmpty)
                            topUsersleaderboardWidget(
                              rank: 1,
                              name: _users[0].name,
                              score: _users[0].score,
                            ),
                          if (_users.length > 2)
                            topUsersleaderboardWidget(
                              rank: 3,
                              name: _users[2].name,
                              score: _users[2].score,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    for (int i = 3; i < _users.length; i++)
                      leaderboardWidget(
                        rank: i + 1,
                        name: _users[i].name,
                        score: _users[i].score,
                      ),
                  ],
                ),
              ),
    );
  }
}
