import 'package:CGPACalculator/global.dart';
import 'package:CGPACalculator/widgets/courseresultlistitem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateSemesterResult extends StatefulWidget {
  final int year, semester;
  UpdateSemesterResult({this.year, this.semester});
  @override
  _UpdateSemesterResultState createState() => _UpdateSemesterResultState();
}

class _UpdateSemesterResultState extends State<UpdateSemesterResult> {
  @override
  Widget build(BuildContext context) {
    List semesterCourseList = courseList
        .where(
            (i) => i['year'] == widget.year && i['semester'] == widget.semester)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Update " +
            widget.year.toString() +
            "/" +
            widget.semester.toString() +
            " Result"),
        elevation: 0,
        centerTitle: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   isExtended: true,
      //   label: Text('Update Result'),
      //   icon: Icon(CupertinoIcons.download_circle),
      //   onPressed: () {},
      // ),
      body: Container(
        padding: EdgeInsets.only(bottom: 12),
        child: ListView.builder(
          itemCount: semesterCourseList.length,
          itemBuilder: (context, index) {
            return CourseResultListItem(
              courseNo: semesterCourseList[index]['no'],
              courseTitle: semesterCourseList[index]['title'],
              year: widget.year,
              semester: widget.semester,
            );
          },
        ),
      ),
    );
  }
}
