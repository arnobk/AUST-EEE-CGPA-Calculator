import 'package:CGPACalculator/global.dart';
import 'package:CGPACalculator/screens/resultsummary.dart';
import 'package:CGPACalculator/utils/calculation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AUST EEE CGPA Calculator"),
        centerTitle: true,
        elevation: 0,
        actions: [
          InkWell(
            onTap: _openInfoDialog,
            child: Icon(
              CupertinoIcons.info_circle,
              color: accentColor,
            ),
          ),
          SizedBox(
            width: 24,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Reset All'),
        icon: Icon(CupertinoIcons.refresh),
        onPressed: _getResetConfirmation,
      ),
      body: Center(
        child: ResultSummary(),
      ),
    );
  }

  void _openInfoDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Theme.of(context).canvasColor,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
              child: Wrap(
                children: [
                  Text(
                    'About',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'This CGPA Calculator is based on AUST EEE Curriculum 2013. Made with ❤️ using Flutter.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Help',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    'Press on any of the semester from the list to update your grades of that semester. Pull to refresh your homescreen.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Developer',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    'Arnob Karmokar\nElectrical and Electronic Engineer\nAhsanullah University of Science and Technology\nwww.arnob.me',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _getResetConfirmation() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Theme.of(context).canvasColor,
            content: Text(
              "Do you want to reset all the saved data? This action can not be undone.",
              style:
                  Theme.of(context).textTheme.bodyText2.apply(fontSizeDelta: 2),
            ),
            actions: [
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  resetAll();
                  Navigator.pop(context);
                  Timer(Duration(milliseconds: 500), () {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (context) => HomePage()),
                    );
                  });
                },
              ),
            ],
          );
        });
  }
}
