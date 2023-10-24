import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:segment_display/segment_display.dart';

class TimeMachine extends StatefulWidget {
  final Color color;

  const TimeMachine({Key? key, required this.color}) : super(key: key);

  @override
  State<TimeMachine> createState() => _TimeMachineState();
}

class _TimeMachineState extends State<TimeMachine> {
  final segmentSize = 4.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: Colors.grey, boxShadow: [
          const BoxShadow(
              color: Colors.black,
              blurRadius: 8.0,
              offset: Offset(
                8.0,
                8.0,
              ))
        ]),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.red,
                          child: Text(
                            "MONTH",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(color: Colors.black),
                          child: FourteenSegmentDisplay(
                            value: "NOV",
                            size: segmentSize,
                            segmentStyle: DefaultSegmentStyle(
                              enabledColor: widget.color,
                              disabledColor: widget.color.withOpacity(0.15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.red,
                          child: Text(
                            "DAY",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(color: Colors.black),
                          child: SevenSegmentDisplay(
                            value: "05",
                            size: segmentSize,
                            segmentStyle: DefaultSegmentStyle(
                              enabledColor: widget.color,
                              disabledColor: widget.color.withOpacity(0.15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.red,
                          child: Text(
                            "YEAR",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(color: Colors.black),
                          child: SevenSegmentDisplay(
                            value: "1955",
                            size: segmentSize,
                            segmentStyle: DefaultSegmentStyle(
                              enabledColor: widget.color,
                              disabledColor: widget.color.withOpacity(0.15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          child: Text(
                            "NULL",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.red,
                          child: Text(
                            "AM",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          color: widget.color,
                        ),
                        Container(
                          color: Colors.red,
                          child: Text(
                            "PM",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.red,
                          child: Text(
                            "HOUR",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(color: Colors.black),
                          child: SevenSegmentDisplay(
                            value: "06",
                            size: segmentSize,
                            segmentStyle: DefaultSegmentStyle(
                              enabledColor: widget.color,
                              disabledColor: widget.color.withOpacity(0.15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        child: Text(
                          "NULL",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.circle,
                              color: widget.color,
                            ),
                            Icon(
                              Icons.circle,
                              color: widget.color,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          color: Colors.red,
                          child: Text(
                            "MIN",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(color: Colors.black),
                          child: SevenSegmentDisplay(
                            value: "28",
                            size: segmentSize,
                            segmentStyle: DefaultSegmentStyle(
                              enabledColor: widget.color,
                              disabledColor: widget.color.withOpacity(0.15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 12.0),
              decoration: BoxDecoration(color: Colors.black),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "DESTINATION TIME",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
