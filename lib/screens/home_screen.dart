import 'package:devbattle/constants/colors.dart';
import 'package:devbattle/widgets/problem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  final statistics;
  const HomePage(this.statistics, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Title(icon: 'assets/icons/Statisctics.svg', title: 'Statisctics'),
              Statisctics(),
              SizedBox(height: 20),
              Title(icon: 'assets/icons/Favorites.svg', title: 'Favorites'),
              Row(children: [
               
                ],
              ),

              SizedBox(height: 20),
              Title(icon: 'assets/icons/recent.svg', title: 'Recent Problems'),
              Row(children: [
                 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Title({icon, title}) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: PrimeryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, color: Colors.white),
          SizedBox(width: 10),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }

  Widget Statisctics() {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 20),
      decoration: BoxDecoration(
        color: SecendryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(20),
      width: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Solved Problems',
                style: TextStyle(
                  color: BlackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.statistics['solvedProblems'].toString(),
                style: TextStyle(
                  color: BlackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Points',
                style: TextStyle(
                  color: BlackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/fire.svg', color: BlackColor),
                  SizedBox(width: 5),
                  Text(
                    widget.statistics['totalPoints'].toString(),

                    style: TextStyle(
                      color: BlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Global Rank',
                style: TextStyle(
                  color: BlackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/globe.svg', color: BlackColor),
                  SizedBox(width: 5),
                  Text(
                    widget.statistics['globalRank'].toString(),

                    style: TextStyle(
                      color: BlackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Success Rate',
                style: TextStyle(
                  color: BlackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.statistics['successRate'].toString(),

                style: TextStyle(
                  color: BlackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
