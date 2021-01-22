import 'package:CGPACalculator/utils/calculation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CourseResultListItem extends StatefulWidget {
  final String courseNo, courseTitle;
  final int year, semester;
  CourseResultListItem(
      {this.courseNo, this.courseTitle, this.year, this.semester});
  @override
  _CourseResultListItemState createState() => _CourseResultListItemState();
}

class _CourseResultListItemState extends State<CourseResultListItem> {
  var courseResultBox = Hive.box<String>('courseResultBox');
  String _currentValue = 'N/A';

  @override
  Widget build(BuildContext context) {
    if (courseResultBox.get(widget.courseNo) != null) {
      _currentValue = courseResultBox.get(widget.courseNo);
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.courseNo,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text(
                  widget.courseTitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            children: [
              DropdownButton<String>(
                value: _currentValue,
                items: <String>[
                  'N/A',
                  'A+',
                  'A',
                  'A-',
                  'B+',
                  'B',
                  'B-',
                  'C+',
                  'C',
                  'D'
                ].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  courseResultBox.put(widget.courseNo, newValue);
                  calculateSemesterResult(widget.year, widget.semester);
                  calculateCGPAResult();
                  setState(() {
                    _currentValue = newValue;
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
