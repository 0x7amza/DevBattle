import 'package:devbattle/constants/colors.dart';
import 'package:devbattle/screens/home_screen.dart';
import 'package:devbattle/screens/leaderboard_screen.dart';
import 'package:devbattle/screens/problems_screen.dart';
import 'package:devbattle/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  var _index = 0;
  var _pages = [
    HomePage(),
    ProblemsScreen(),
    Text('Profile'),
    LeaderboardPage(),
    Text('Statistics'),
  ];
  @override
  Widget build(BuildContext context) {
    mediaQuery query = mediaQuery(context);
    return Scaffold(
      backgroundColor: BackGroundColor,
      body: Center(child: _pages[_index]),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: BackGroundColor,
        flexibleSpace: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(image: AssetImage('assets/images/logo.png')),
              Container(
                width: query.getWidth() * 80,
                height: 55,
                decoration: BoxDecoration(
                  color: PrimeryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        navItem('Home', 0),
                        navItem('Problems', 1),
                        navItem('Rankings', 2),
                        navItem('Leaderboard', 3),
                        navItem('Statistics', 4),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/fire.svg'),
                        SizedBox(width: 5),
                        Text(
                          '100',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(width: 10),
                        SvgPicture.asset('assets/icons/notifications.svg'),
                        SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: Image.network(
                            'https://picsum.photos/seed/picsum/200/300',
                            fit: BoxFit.cover,
                            width: 35,
                            height: 35,
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(String title, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _index = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(right: BorderSide(color: BlackColor, width: 1.2)),
        ),
        height: 45,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          title,
          style: TextStyle(
            color:
                _index == index ? Colors.white : Colors.white.withOpacity(0.9),
            fontSize: 24,
            fontWeight: _index == index ? FontWeight.normal : FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
