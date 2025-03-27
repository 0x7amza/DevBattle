import 'package:devbattle/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget topUsersleaderboardWidget({rank = 1, name, score}) {
  return Column(
    children: [
      Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(120),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          border: Border.all(color: Colors.grey.shade300, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(120),
          child: Image.network(
            'https://picsum.photos/seed/picsum/200/300',
            fit: BoxFit.cover,
            width: 70,
            height: 70,
          ),
        ),
      ),
      SizedBox(height: 10),
      Container(
        width: 145,
        height:
            rank == 1
                ? 180
                : rank == 2
                ? 130
                : 110,
        decoration: BoxDecoration(
          color: Color(0xff28544f),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(100),
              ),
              alignment: Alignment.center,
              child: Text(
                rank.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: BlackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              name.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${score.toString()}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5),
                SvgPicture.asset(
                  'assets/icons/fire.svg',
                  color: Colors.white,
                  width: 15,
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget leaderboardWidget({rank, name, score}) {
  return Container(
    margin: EdgeInsets.only(bottom: 20, left: 150, right: 150),
    decoration: BoxDecoration(
      color: Color(0xff5c7875),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 10, height: 40),

        SizedBox(width: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(120),
          child: Image.network(
            'https://picsum.photos/seed/picsum/200/300',
            fit: BoxFit.cover,
            width: 30,
            height: 30,
          ),
        ),

        SizedBox(width: 10),
        Text(
          rank.toString() + '. ' + name.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        Spacer(),
        Row(
          children: [
            Text(
              '${score.toString()}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 5),
            SvgPicture.asset(
              'assets/icons/fire.svg',
              color: Colors.white,
              width: 15,
              height: 15,
            ),
          ],
        ),
        SizedBox(width: 20),
      ],
    ),
  );
}
