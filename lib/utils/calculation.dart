import 'package:hive/hive.dart';
import '../global.dart';

var courseResultBox = Hive.box<String>('courseResultBox');
var semesterResultBox = Hive.box<String>('semesterResultBox');

void calculateSemesterResult(int year, int semester) {
  List semesterCourseList = courseList
      .where((i) => i['year'] == year && i['semester'] == semester)
      .toList();
  double creditCompleted = 0;
  double creditScore = 0;

  for (int i = 0; i < semesterCourseList.length; i++) {
    if (courseResultBox.get(semesterCourseList[i]['no']) != null &&
        courseResultBox.get(semesterCourseList[i]['no']) != 'N/A') {
      creditCompleted += semesterCourseList[i]['credit'];
      creditScore +=
          gradetogpa(courseResultBox.get(semesterCourseList[i]['no'])) *
              semesterCourseList[i]['credit'];
    }
  }
  if (creditScore > 0) {
    semesterResultBox.put('year${year}semester$semester',
        (creditScore / creditCompleted).toString());
  } else {
    semesterResultBox.put('year${year}semester$semester', (0.00).toString());
  }
  semesterResultBox.put('completedcredityear${year}semester$semester',
      (creditCompleted).toString());
}

void calculateCGPAResult() {
  for (int year = 1; year <= 4; year++) {
    for (int semester = 1; semester <= 2; semester++) {
      List semesterCourseList = courseList
          .where((i) => i['year'] * 10 + i['semester'] <= year * 10 + semester)
          .toList();
      double creditCompleted = 0;
      double creditScore = 0;

      for (int i = 0; i < semesterCourseList.length; i++) {
        if (courseResultBox.get(semesterCourseList[i]['no']) != null &&
            courseResultBox.get(semesterCourseList[i]['no']) != 'N/A') {
          creditCompleted += semesterCourseList[i]['credit'];
          creditScore +=
              gradetogpa(courseResultBox.get(semesterCourseList[i]['no'])) *
                  semesterCourseList[i]['credit'];
        }
      }
      semesterResultBox.put('cgpayear${year}semester$semester',
          (creditScore / creditCompleted).toString());
      semesterResultBox.put(
          'totalcompletedcredit', (creditCompleted).toString());
    }
  }
}

String getCGPA() {
  double currentCGPA;
  for (int year = 4; year > 0; year--) {
    for (int semester = 2; semester > 0; semester--) {
      if (semesterResultBox.get('cgpayear${year}semester$semester') != null) {
        currentCGPA = double.parse(
                    semesterResultBox.get('cgpayear${year}semester$semester')) >
                0.0
            ? double.parse(
                semesterResultBox.get('cgpayear${year}semester$semester'))
            : 0.0;
        break;
      } else {
        currentCGPA = 0.0;
      }
      break;
    }
    break;
  }
  return currentCGPA.toStringAsPrecision(4);
}

double gradetogpa(String grade) {
  switch (grade) {
    case 'A+':
      return 4.00;
    case 'A':
      return 3.75;
    case 'A-':
      return 3.5;
    case 'B+':
      return 3.25;
    case 'B':
      return 3.00;
    case 'B-':
      return 2.75;
    case 'C+':
      return 2.5;
    case 'C':
      return 2.25;
    case 'D':
      return 2.00;
    default:
      return 0.00;
  }
}

void resetAll() {
  courseResultBox.clear();
  semesterResultBox.clear();
}
