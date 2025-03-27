import 'package:devbattle/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget problem() {
  return Container(
    margin: EdgeInsets.only(left: 20, top: 20),
    decoration: BoxDecoration(
      color: SecendryColor,
      border: Border.all(color: Colors.grey.withOpacity(0.3)),
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
    width: 260,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, top: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                'Problem Title',
                style: TextStyle(
                  color: BlackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(
                'Problem description dasd asd asda dsa dsadsadasdsad sadasd',
                style: TextStyle(color: BlackColor, fontSize: 16),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text('Difficulty: ', style: TextStyle(color: BlackColor)),
                  Text(
                    'Easy',
                    style: TextStyle(
                      color: TextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            25,
            (index) => Text(
              " • ",
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Solved',
                style: TextStyle(color: TextColor, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: BackGroundColor,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '30',
                          style: TextStyle(
                            color: BlackColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 5),
                        SvgPicture.asset(
                          'assets/icons/fire.svg',
                          color: BlackColor,
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.star_border, color: Colors.black),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
