import 'package:CGPACalculator/screens/updatesemesterresult.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class ResultListItem extends StatelessWidget {
  final int year, semester;
  final double totalCredit;
  ResultListItem({this.year, this.semester, this.totalCredit});
  @override
  Widget build(BuildContext context) {
    var semesterResultBox = Hive.box<String>('semesterResultBox');

    String digitToReadable(int digit) {
      switch (digit) {
        case 1:
          return "1st";
        case 2:
          return "2nd";
        case 3:
          return "3rd";
        case 4:
          return "4th";
        default:
          return "n/a";
      }
    }

    return InkWell(
      highlightColor: Theme.of(context).primaryColorLight,
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => UpdateSemesterResult(
                    year: year,
                    semester: semester,
                  )),
        );
      },
      child: ClipRRect(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).primaryColorLight,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Year",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    digitToReadable(year),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Semester",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    digitToReadable(semester),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Credits",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    semesterResultBox.get(
                                'completedcredityear${year}semester$semester') !=
                            null
                        ? double.parse(semesterResultBox.get(
                                    'completedcredityear${year}semester$semester'))
                                .toStringAsPrecision(3) +
                            '/' +
                            totalCredit.toString()
                        : '0.00' + '/' + totalCredit.toString(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "GPA",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    semesterResultBox.get('year${year}semester$semester') !=
                            null
                        ? double.parse(semesterResultBox
                                .get('year${year}semester$semester'))
                            .toStringAsPrecision(4)
                        : '0.000',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "CGPA",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    semesterResultBox.get('cgpayear${year}semester$semester') !=
                            null
                        ? double.parse(semesterResultBox
                                    .get('cgpayear${year}semester$semester'))
                                .isNaN
                            ? ('0.000')
                            : double.parse(semesterResultBox
                                    .get('cgpayear${year}semester$semester'))
                                .toStringAsPrecision(4)
                        : '0.000',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
