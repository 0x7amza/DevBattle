import 'package:devbattle/constants/colors.dart';
import 'package:devbattle/screens/problem_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget problem({
  required BuildContext context,
  required String title,
  required String description,
  required String difficulty,
  required int score,
  required bool isSolved,
  required bool isFavorite,
  required VoidCallback onTap,
  required VoidCallback onFavoriteToggle,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200, // ارتفاع ثابت
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
                    title, // استخدام العنوان الديناميكي
                    maxLines: 1, // تحديد عدد الأسطر القصوى للعنوان
                    overflow:
                        TextOverflow
                            .ellipsis, // إضافة علامة "..." إذا كان العنوان طويلًا
                    style: TextStyle(
                      color: BlackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5), // مسافة صغيرة بين العنوان والوصف
                  Text(
                    description, // استخدام الوصف الديناميكي
                    maxLines: 2, // تحديد عدد الأسطر القصوى للوصف
                    overflow:
                        TextOverflow
                            .ellipsis, // إضافة علامة "..." إذا كان الوصف طويلًا
                    style: TextStyle(color: BlackColor, fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Difficulty: ', style: TextStyle(color: BlackColor)),
                      Text(
                        difficulty, // استخدام مستوى الصعوبة الديناميكي
                        style: TextStyle(
                          color: _getDifficultyColor(
                            difficulty,
                          ), // تحديد لون حسب مستوى الصعوبة
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(), // لدفع العناصر التالية إلى الأسفل
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
                    (isSolved) ? 'Solved' : 'Unsolved',
                    style: TextStyle(
                      color: (isSolved) ? TextColor : Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: BackGroundColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              score.toString(),
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
                      InkWell(
                        onTap: onFavoriteToggle,
                        child:
                            !isFavorite
                                ? Icon(Icons.star_border, color: Colors.black)
                                : Icon(Icons.star, color: Colors.green),
                      ),
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

// دالة مساعدة لتحديد لون مستوى الصعوبة
Color _getDifficultyColor(String difficulty) {
  switch (difficulty.toLowerCase()) {
    case 'easy':
      return Colors.green;
    case 'medium':
      return Colors.orange;
    case 'hard':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
