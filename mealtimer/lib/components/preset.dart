import 'package:flutter/material.dart';

class Preset extends StatelessWidget {
  final bool active;
  final String name;
  final int mealNumber;
  final List<String> mealNames, mealTimes;

  Preset(
      {this.active = false,
      this.name,
      this.mealNumber,
      this.mealNames,
      this.mealTimes});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (active)
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xff1A3540),
                    border: Border.all(width: 1, color: Color(0xffD2F28D)),
                    borderRadius: BorderRadius.all(Radius.circular(27.0))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(color: Colors.grey[200]),
                      ),
                      Icon(
                        Icons.play_arrow,
                        color: Color(0xffD2F28D),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          );
        else
          return Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xff1A3540),
                    border: Border.all(width: 1, color: Color(0xff3D5938)),
                    borderRadius: BorderRadius.all(Radius.circular(27.0))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      Icon(
                        Icons.play_arrow,
                        color: Color(0xff3D5938),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          );
      },
    );
  }
}
