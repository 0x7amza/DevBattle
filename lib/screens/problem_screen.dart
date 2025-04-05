import 'package:devbattle/api/problems_api.dart';
import 'package:devbattle/constants/colors.dart';
import 'package:devbattle/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/cpp.dart';

class ProblemScreen extends StatefulWidget {
  final String id;
  const ProblemScreen({super.key, required this.id});

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  bool _isLoading = true;
  String markdown = '';
  List<Map<String, dynamic>> testCases = [];
  List<Map<String, dynamic>> parameters = [];
  List<Map<String, dynamic>> defaultCode = [];
  int selectedLanguageIndex = 0;
  int selectedCaseIndex = 0;
  bool isDescriptionSelected = true;

  final Map<String, dynamic> languageMap = {
    'Java': java,
    'C++': cpp,
    'Python': python,
    'JavaScript': javascript,
  };

  late CodeController _codeController;

  void _initializeController() {
    if (defaultCode.isNotEmpty) {
      _codeController = CodeController(
        text: defaultCode[selectedLanguageIndex]['code'].toString(),
        language:
            languageMap[defaultCode[selectedLanguageIndex]['name'].toString()],
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getProblemData() async {
    try {
      final data = await QuestionApi().fetchQuestionById(widget.id);
      setState(() {
        markdown = data['markdown']?.toString() ?? 'No description available';
        testCases = List<Map<String, dynamic>>.from(
          data['testCases']?.map((e) => Map<String, dynamic>.from(e)) ?? [],
        );
        defaultCode = List<Map<String, dynamic>>.from(
          data['defaultCode']?.map((e) => Map<String, dynamic>.from(e)) ?? [],
        );
        parameters = List<Map<String, dynamic>>.from(
          data['parameters']?.map((e) => Map<String, dynamic>.from(e)) ?? [],
        );
      });
      if (defaultCode.isNotEmpty) {
        _initializeController();
      }
    } catch (e) {
      print('Error fetching problem data: $e');
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getProblemData();
  }

  @override
  Widget build(BuildContext context) {
    final query = mediaQuery(context);

    return Scaffold(
      backgroundColor: BackGroundColor,
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDescriptionColumn(query),
                  buildCodeAndTestCasesColumn(query),
                ],
              ),
    );
  }

  // ويدجت لعمود الوصف
  Widget buildDescriptionColumn(mediaQuery query) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [buildExitButtonRow(query), buildDescriptionContainer(query)],
    );
  }

  // ويدجت لزر الخروج
  Widget buildExitButtonRow(mediaQuery query) {
    return Row(
      children: [
        Icon(Icons.exit_to_app_outlined),
        SizedBox(width: query.getWidth() * 0.4),
        Text(
          'Exit Problem',
          style: TextStyle(
            color: BlackColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  // ويدجت لحاوية الوصف
  Widget buildDescriptionContainer(mediaQuery query) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: query.getWidth() * 2,
        vertical: query.getHeight() * 5,
      ),
      width: query.getWidth() * 20,
      height: query.getHeight() * 80,
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
      child: Column(
        children: [
          buildDescriptionHeader(query),
          SizedBox(height: query.getHeight() * 0.8),
          isDescriptionSelected
              ? Expanded(child: Markdown(data: markdown))
              : ListView.builder(
                itemCount: testCases.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: query.getWidth() * 20,
                    height: query.getHeight() * 5,
                    alignment: Alignment.center,
                    child: Text(
                      'Case - ${(index + 1).toString()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }

  // ويدجت لرأس الوصف
  Widget buildDescriptionHeader(mediaQuery query) {
    return Container(
      width: query.getWidth() * 20,
      height: query.getHeight() * 5,
      decoration: BoxDecoration(
        color: PrimeryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isDescriptionSelected = true;
              });
            },
            child: Text(
              'Description',
              style: TextStyle(
                color: isDescriptionSelected ? Colors.white : Colors.white60,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(width: query.getWidth() * 1),
          SizedBox(
            height: 25,
            child: VerticalDivider(
              color: Colors.white,
              thickness: 2,
              indent: 5,
              endIndent: 0,
              width: 20,
            ),
          ),
          SizedBox(width: query.getWidth() * 1),
          InkWell(
            onTap: () {
              setState(() {
                isDescriptionSelected = false;
              });
            },
            child: Text(
              'Submissions',
              style: TextStyle(
                color: !isDescriptionSelected ? Colors.white : Colors.white60,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت لعمود الكود وحالات الاختبار
  Widget buildCodeAndTestCasesColumn(mediaQuery query) {
    return Column(
      children: [
        buildCodeEditorContainer(query),
        SizedBox(height: query.getHeight() * 2),
        buildTestCasesContainer(query),
      ],
    );
  }

  // ويدجت لحاوية محرر الكود
  Widget buildCodeEditorContainer(mediaQuery query) {
    return Container(
      width: query.getWidth() * 74,
      height: query.getHeight() * 60,
      margin: EdgeInsets.only(top: query.getHeight() * 5),
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
      child: Column(
        children: [
          buildCodeEditorHeader(query),
          Expanded(
            child: CodeTheme(
              data: CodeThemeData(styles: atomOneLightTheme),
              child: SingleChildScrollView(
                child: CodeField(controller: _codeController),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت لرأس محرر الكود
  Widget buildCodeEditorHeader(mediaQuery query) {
    return Container(
      width: query.getWidth() * 74,
      height: query.getHeight() * 5,
      decoration: BoxDecoration(
        color: PrimeryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          SizedBox(width: query.getWidth() * 1),
          Text(
            '</> Code',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(width: query.getWidth() * 1),
          DropdownButton<String>(
            value:
                defaultCode.isNotEmpty
                    ? defaultCode[selectedLanguageIndex]['name'].toString()
                    : '',
            underline: Container(),
            icon: Icon(Icons.arrow_drop_down, color: PrimeryColor),
            dropdownColor: PrimeryColor,
            focusColor: Colors.transparent,
            onTap: () {},
            borderRadius: BorderRadius.circular(10),
            items:
                defaultCode.map((code) {
                  return DropdownMenuItem<String>(
                    value: code['name'].toString(),
                    child: Text(
                      code['name'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                }).toList(),
            onChanged: (_value) {
              setState(() {
                selectedLanguageIndex = defaultCode.indexWhere(
                  (element) => element['name'].toString() == _value,
                );
                _initializeController();
              });
            },
          ),
        ],
      ),
    );
  }

  // ويدجت لحاوية حالات الاختبار
  Widget buildTestCasesContainer(mediaQuery query) {
    return Container(
      width: query.getWidth() * 74,
      height: query.getHeight() * 30,
      decoration: BoxDecoration(
        color: SecendryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          buildTestCasesHeader(query),
          Row(
            children: [buildTestCasesList(query), buildTestCaseDetails(query)],
          ),
        ],
      ),
    );
  }

  Widget buildTestCasesHeader(mediaQuery query) {
    return Container(
      width: query.getWidth() * 74,
      height: query.getHeight() * 5,
      decoration: BoxDecoration(
        color: PrimeryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          SizedBox(width: query.getWidth() * 1),
          Text(
            'Test Cases',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTestCasesList(mediaQuery query) {
    return Container(
      width: query.getWidth() * 8,
      height: query.getHeight() * 25,
      decoration: BoxDecoration(
        color: PrimeryColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < testCases.length; i++)
              InkWell(
                onTap: () {
                  setState(() {
                    selectedCaseIndex = i;
                  });
                },
                child: Container(
                  width: query.getWidth() * 12,
                  height: query.getHeight() * 5,
                  alignment: Alignment.center,
                  child: Text(
                    'Case - ${(i + 1).toString()}',
                    style: TextStyle(
                      color:
                          selectedCaseIndex == i
                              ? Colors.white
                              : Colors.white60,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ويدجت لتفاصيل حالة الاختبار
  Widget buildTestCaseDetails(mediaQuery query) {
    return Container(
      width: query.getWidth() * 65,
      height: query.getHeight() * 25,
      margin: EdgeInsets.only(left: query.getWidth() * 1),
      decoration: BoxDecoration(
        color: SecendryColor,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            for (var i = 0; i < parameters.length; i++)
              Container(
                width: query.getWidth() * 65,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parameters[i]['name'].toString(),
                      style: TextStyle(
                        color: BlackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: query.getWidth() * 2),
                    Row(
                      children: [
                        Container(
                          width: query.getWidth() * 45,
                          height: query.getHeight() * 7,
                          decoration: BoxDecoration(
                            color: PrimeryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: query.getWidth() * 1),
                          child: Text(
                            testCases[selectedCaseIndex]['input'][i].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        SizedBox(width: query.getWidth() * 2),
                        Container(
                          width: query.getWidth() * 7,
                          height: query.getHeight() * 7,
                          decoration: BoxDecoration(
                            color: PrimeryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            parameters[i]['type'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
