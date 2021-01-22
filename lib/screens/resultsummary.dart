import 'package:CGPACalculator/global.dart';
import 'package:CGPACalculator/utils/calculation.dart';
import 'package:CGPACalculator/widgets/resultlistitem.dart';
import 'package:flutter/material.dart';

class ResultSummary extends StatefulWidget {
  @override
  _ResultSummaryState createState() => _ResultSummaryState();
}

class _ResultSummaryState extends State<ResultSummary> {
  String cgpa;
  @override
  void initState() {
    super.initState();
    cgpa = getCGPA();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          cgpa = getCGPA();
        });
        calculateCGPAResult();
        for (int year = 1; year <= 4; year++) {
          for (int semester = 1; semester <= 2; semester++) {
            calculateSemesterResult(year, semester);
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12),
              child: Column(
                children: [
                  Text(
                    "Your CGPA",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    getCGPA(),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Details",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Text(
                  "${semesterResultBox.get('totalcompletedcredit') != null ? semesterResultBox.get('totalcompletedcredit') : '0.0'} of 165.0 Credits Completed",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 6, bottom: 72),
              shrinkWrap: true,
              itemCount: cgpaList.length,
              itemBuilder: (context, index) {
                return ResultListItem(
                    year: cgpaList[index]['year'],
                    semester: cgpaList[index]['semester'],
                    totalCredit: cgpaList[index]['total_credit']);
              },
            ),
          )
        ],
      ),
    );
  }
}
