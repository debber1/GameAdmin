import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScoreBoard extends StatelessWidget {
  ScoreBoard({Key? key}) : super(key: key);
  final String text = "ScoreBoard page";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      title: 'My Dog App',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: AppBar(
            title: Text('Score Board'),
          ),
        ),
        body: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            //The left column
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Column(
                    children: [
                      _updateBtn(context, Icons.add, 8, 8),
                      _updateBtn(context, Icons.remove, 8, 8)
                    ],
                  ),
                  Text(
                    "00",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 4),
                  ),
                ],
              ),
              Text(
                "Period: 1/2",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 15),
                textAlign: TextAlign.left,
              ),
              Text(
                "Period Length:",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 15),
                textAlign: TextAlign.left,
              ),
              Row(
                children: [
                  _updateBtnText(context, "-1", 10, 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                    child: Center(
                      child: Text(
                        "10",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 15),
                      ),
                    ),
                  ),
                  _updateBtnText(context, "+1", 10, 12)
                ],
              ),
              Text(
                "Break Length:",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 15),
                textAlign: TextAlign.left,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _updateBtnText(context, "-1", 10, 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 20,
                    child: Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height / 15),
                      ),
                    ),
                  ),
                  _updateBtnText(context, "+1", 10, 12)
                ],
              ),
            ],
          ),
          Column(
            //The center column
            children: [
              Row(
                children: [
                  Text(
                    "10:00",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 4),
                  ),
                ],
              ),
              Row(
                children: [
                  _updateBtnText(context, "Start", 5, 8.6),
                  _updateBtnText(context, "Stop", 5, 8.6)
                ],
              ),
              _updateBtnText(context, "Reset", 2.45, 8.6),
              Row(
                children: [
                  _updateBtnText(context, "-1 minute", 5, 8.6),
                  _updateBtnText(context, "+1 minute", 5, 8.6)
                ],
              ),
              Row(
                children: [
                  _updateBtnText(context, "-1 second", 5, 8.6),
                  _updateBtnText(context, "+1 second", 5, 8.6)
                ],
              ),
            ],
          ),
          Column(
            //The right column
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "00",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 4),
                  ),
                  Column(
                    children: [
                      _updateBtn(context, Icons.add, 8, 8),
                      _updateBtn(context, Icons.remove, 8, 8)
                    ],
                  ),
                ],
              ),
              Text(
                "60",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height / 5.5),
              ),
              Row(
                children: [
                  _updateBtnText(context, "Start", 8, 12),
                  _updateBtnText(context, "Stop", 8, 12)
                ],
              ),
              _updateBtnText(context, "Reset", 3.85, 12),
              Row(
                children: [
                  _updateBtnText(context, "-1", 8, 12),
                  _updateBtnText(context, "+1", 8, 12)
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _updateBtn(context, IconData icon, double widthDiv, double heightDiv) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width / widthDiv,
        height: MediaQuery.of(context).size.height / heightDiv,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Icon(icon),
        ),
      ),
    );
  }

  Widget _updateBtnText(
      context, String text, double widthDiv, double heightDiv) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width / widthDiv,
        height: MediaQuery.of(context).size.height / heightDiv,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
