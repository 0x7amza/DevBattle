import 'package:devbattle/constants/colors.dart';
import 'package:devbattle/widgets/problem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProblemsScreen extends StatefulWidget {
  const ProblemsScreen({super.key});

  @override
  State<ProblemsScreen> createState() => _ProblemsScreenState();
}

class _ProblemsScreenState extends State<ProblemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackGroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20, width: double.infinity),
            SizedBox(
              child: Row(
                children: [
                  SizedBox(width: 20),
                  //search bar
                  Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: SecendryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search, color: Colors.grey),
                        contentPadding: EdgeInsets.all(20.0),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 20),
                  //dropdown button
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: SecendryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      value: 'Difficulty',
                      iconSize: 24,
                      isExpanded: true,
                      elevation: 0,

                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.transparent,
                      ),
                      dropdownColor: Colors.white,
                      onChanged: (String? newValue) {},
                      items:
                          <String>[
                            'Difficulty',
                            'Easy',
                            'Medium',
                            'Hard',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              alignment: Alignment.centerLeft,
                            );
                          }).toList(),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: SecendryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      value: 'Status',
                      iconSize: 24,
                      isExpanded: true,
                      elevation: 0,

                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.transparent,
                      ),
                      dropdownColor: Colors.white,
                      onChanged: (String? newValue) {},
                      items:
                          <String>[
                            'Status',
                            'Solved',
                            'Unsolved',
                            'All',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              alignment: Alignment.centerLeft,
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            //problems list (grid view)
            GridView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.3,
              ),

              children: [for (int i = 0; i < 20; i++) problem()],
            ),
          ],
        ),
      ),
    );
  }
}
