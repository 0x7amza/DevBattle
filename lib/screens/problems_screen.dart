import 'package:devbattle/api/favorite_api.dart';
import 'package:devbattle/api/problems_api.dart';
import 'package:devbattle/constants/colors.dart';
import 'package:devbattle/screens/problem_screen.dart';
import 'package:devbattle/widgets/problem.dart';
import 'package:flutter/material.dart';

class ProblemsScreen extends StatefulWidget {
  const ProblemsScreen({super.key});

  @override
  State<ProblemsScreen> createState() => _ProblemsScreenState();
}

class _ProblemsScreenState extends State<ProblemsScreen> {
  final QuestionApi _questionApi = QuestionApi();
  List<dynamic> _problems = [];
  List<dynamic> _originalProblems = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchProblems();
  }

  Future<void> _fetchProblems() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _questionApi.fetchQuestions();
      _originalProblems = response;
      setState(() {
        _problems = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching problems: $e');
    }
  }

  String? _difficultySelectedValue = 'Difficulty';
  String? _statusSelectedValue = 'Status';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackGroundColor,
      body: Column(
        children: [
          SizedBox(height: 20, width: double.infinity),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: SecendryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
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
                      onChanged:
                          (value) => setState(() {
                            _problems =
                                _originalProblems.where((problem) {
                                  return problem['title']
                                      .toString()
                                      .toLowerCase()
                                      .contains(value.toLowerCase());
                                }).toList();
                          }),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                // Dropdown for Difficulty
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
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton<String>(
                    value: _difficultySelectedValue,
                    iconSize: 24,
                    isExpanded: true,
                    elevation: 0,
                    style: TextStyle(color: Colors.black),
                    underline: Container(height: 2, color: Colors.transparent),
                    dropdownColor: Colors.white,
                    onChanged: (String? newValue) {
                      if (newValue != 'Difficulty') {
                        _problems =
                            _originalProblems.where((problem) {
                              return problem['difficultyLevel']
                                  .toString()
                                  .toLowerCase()
                                  .contains(newValue.toString().toLowerCase());
                            }).toList();
                      } else {
                        _problems = _originalProblems;
                      }
                      setState(() {
                        _difficultySelectedValue =
                            newValue; // تحديث القيمة عند التغيير
                      });
                    },
                    items:
                        <String>[
                          'Difficulty',
                          'Easy',
                          'Medium',
                          'Hard',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            alignment: Alignment.centerLeft,
                            child: Text(value),
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
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButton<String>(
                    value: _statusSelectedValue,
                    iconSize: 24,
                    isExpanded: true,
                    elevation: 0,
                    style: TextStyle(color: Colors.black),
                    underline: Container(height: 2, color: Colors.transparent),
                    dropdownColor: Colors.white,
                    onChanged: (String? newValue) {
                      setState(() {
                        _statusSelectedValue = newValue;

                        if (newValue == 'Status') {
                          _problems = _originalProblems;
                        } else {
                          bool isSolvedFilter = newValue == 'Solved';

                          _problems =
                              _originalProblems.where((problem) {
                                return problem['isSolved'] == isSolvedFilter;
                              }).toList();
                        }
                      });
                    },

                    items:
                        <String>[
                          'Status',
                          'Solved',
                          'Unsolved',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            alignment: Alignment.centerLeft,
                            child: Text(value),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child:
                _problems.isEmpty
                    ? Center(child: Text('No problems available'))
                    : ListView.builder(
                      itemCount: (_problems.length / 5).ceil(), // عدد الصفوف
                      itemBuilder: (context, rowIndex) {
                        int startIndex = rowIndex * 5; // بداية الصف
                        int endIndex =
                            (startIndex + 5 > _problems.length)
                                ? _problems.length
                                : startIndex + 5; // نهاية الصف

                        return Wrap(
                          alignment:
                              WrapAlignment
                                  .spaceAround, // توزيع العناصر بالتساوي
                          spacing: 10, // المسافة بين العناصر أفقيًا
                          runSpacing: 10, // المسافة بين الصفوف عموديًا
                          children: List.generate(
                            5, // دائمًا نولد 5 عناصر لكل صف
                            (index) {
                              int problemIndex = startIndex + index;

                              if (problemIndex < _problems.length) {
                                final problemData = _problems[problemIndex];
                                return problem(
                                  context: context,
                                  title: problemData['title'],
                                  description: problemData['description'],
                                  difficulty: problemData['difficultyLevel'],
                                  score: problemData['score'],
                                  isSolved: problemData['isSolved'],
                                  isFavorite: problemData['isFavorite'],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => ProblemScreen(
                                              id: problemData['id'].toString(),
                                            ),
                                      ),
                                    );
                                  },
                                  onFavoriteToggle: () async {
                                    final favoriteApi = FavoriteApi();
                                    try {
                                      final response = await favoriteApi
                                          .toggleFavorite(
                                            questionId:
                                                problemData['id'].toString(),
                                          );

                                      setState(() {
                                        problemData['isFavorite'] =
                                            !problemData['isFavorite'];
                                      });
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(content: Text('Error: $e')),
                                      );
                                    }
                                  },
                                );
                              } else {
                                // عرض العناصر الفارغة
                                return Container(width: 260, height: 100);
                              }
                            },
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
