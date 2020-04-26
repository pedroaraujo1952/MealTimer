import 'package:flutter/material.dart';

class Preset extends StatefulWidget {
  bool active;
  String name;
  int mealNumber;
  List<String> mealNames, mealTimes;
  Function function;

  Preset({
    this.active = false,
    this.name,
    this.mealNumber,
    this.mealNames,
    this.mealTimes,
    this.function,
  });

  void changeActiveState() {
    this.active = false;
  }

  int getFoodCount() {
    if (this.active) {
      return this.mealNumber;
    } else
      return null;
  }

  @override
  _PresetState createState() => _PresetState();
}

class _PresetState extends State<Preset> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (widget.active)
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: RaisedButton(
                  onPressed: () {
                    widget.function();
                  },
                  color: Color(0xff1A3540),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(27.0)),
                      side: BorderSide(color: Color(0xffD2F28D))),
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.name,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: RaisedButton(
                  onPressed: widget.active
                      ? () {
                          widget.function();
                        }
                      : null,
                  color: Color(0xff1A3540),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(27.0)),
                      side: BorderSide(color: Color(0xff3D5938))),
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.name,
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
