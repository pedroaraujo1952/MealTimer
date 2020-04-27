import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Preset extends StatefulWidget {
  bool active;
  String name;
  int mealNumber;
  List<String> mealNames, mealTimes;
  Function eat, reset, activate;

  Preset(
      {this.active = false,
      this.name,
      this.mealNumber,
      this.mealNames,
      this.mealTimes,
      this.eat,
      this.reset,
      this.activate});

  int getFoodCount() {
    if (this.active) {
      return this.mealNumber;
    } else
      return null;
  }

  @override
  _PresetState createState() => _PresetState();
}

const enabledColor = 0xffD2F28D;
const disabledColor = 0xff3D5938;

class _PresetState extends State<Preset> {
  bool _active;
  String _name;
  int _mealNumber;
  List<String> _mealNames, _mealTimes;

  @override
  void initState() {
    setState(() {
      _active = widget.active;
      _name = widget.name;
      _mealNumber = widget.mealNumber;
      _mealNames = widget.mealNames;
      _mealTimes = widget.mealTimes;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_name != null) {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (_active)
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xff1A3540),
                        borderRadius: BorderRadius.all(Radius.circular(27.0))),
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          onLongPress: () {
                            setState(() {
                              _active = !_active;
                            });

                            if (_active)
                              widget.activate(_mealNumber);
                            else
                              widget.reset();
                          },
                          onPressed: () {
                            widget.eat();
                          },
                          color: Color(0xff1A3540),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(27.0)),
                              side: BorderSide(color: Color(0xffD2F28D))),
                          child: Container(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    widget.name,
                                    style: TextStyle(color: Colors.grey[200]),
                                  ),
                                  Icon(
                                    Icons.fastfood,
                                    color: Color(0xffD2F28D),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: widget.mealNames
                              .asMap()
                              .map((index, name) {
                                final mealTimeMap = widget.mealTimes.asMap();
                                return MapEntry(
                                    index,
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 0, vertical: 2),
                                            leading: CircleAvatar(
                                              backgroundImage:
                                                  AssetImage("assets/food.jpg"),
                                            ),
                                            title: Text(
                                              name,
                                              style: TextStyle(
                                                  color: Colors.grey[300]),
                                            ),
                                            trailing: Text(
                                              mealTimeMap[index + 1],
                                              style: TextStyle(
                                                  color: Color(0xff69BF41),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onTap: () {},
                                          ),
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              if (index ==
                                                  widget.mealNames.length - 1)
                                                return SizedBox();
                                              else
                                                return Divider(
                                                  height: 1,
                                                  color: Color(enabledColor),
                                                );
                                            },
                                          ),
                                        ],
                                      ),
                                    ));
                              })
                              .values
                              .toList(),
                        ),
                        SizedBox(
                          height: 10,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: RaisedButton(
                    onLongPress: () {
                      setState(() {
                        _active = !_active;
                      });

                      print(_active);

                      if (_active)
                        widget.activate(_mealNumber);
                      else
                        widget.reset();
                    },
                    onPressed: _active
                        ? () {
                            widget.eat();
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
    } else
      return Container();
  }
}
