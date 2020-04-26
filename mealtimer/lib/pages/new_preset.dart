import 'package:flutter/material.dart';
import 'package:mealtimer/services/time_math.dart';

class NewPreset extends StatefulWidget {
  @override
  _NewPresetState createState() => _NewPresetState();
}

class _NewPresetState extends State<NewPreset> {
  final _formKey = GlobalKey<FormState>();

  //Form Values
  String _presetName = "NEW PRESET NAME";
  TimeOfDay _wakeUpTime = _time;
  TimeOfDay _sleepTime = _time;
  int _mealNumber = 3;
  List<String> _mealName = [];

  static TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;

  Future<TimeOfDay> selectTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: _time);

    setState(() {
      _time = picked;
      print(_time.format(context));
    });

    return _time;
  }

  List<Widget> getMealField(int mealNumber) {
    List<Widget> list = [];
    for (var i = 0; i < mealNumber; i++) {
      list.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                (i + 1).toString() + "º Meal Name",
                style: TextStyle(fontSize: 16, color: Color(0xff69BF41)),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  height: 45,
                  width: 220,
                  child: TextFormField(
                    style: TextStyle(
                      color: Color(0xff121726),
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                      hintText: "Name",
                      hintStyle: TextStyle(color: Color(0xff121726)),
                      filled: true,
                      fillColor: Color(0xffD2F28D),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                          borderSide: BorderSide.none),
                    ),
                    validator: (String value) {
                      return value.isEmpty ? "Name is necessary" : null;
                    },
                    onSaved: (String value) {
                      setState(() {
                        _mealName.add(value);
                      });
                    },
                  )),
            ],
          ),
          FloatingActionButton(
            heroTag: "photo " + i.toString(),
            elevation: 0,
            backgroundColor: Color(0xffD2F28D),
            child: Icon(
              Icons.photo_camera,
              color: Color(0xff3D5938),
              size: 25,
            ),
            mini: true,
            onPressed: null,
          ),
          SizedBox(
            height: 90,
          )
        ],
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121726),
      body: Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Color(0xff121726),
          body: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27),
                    image: DecorationImage(
                        image: AssetImage("assets/food.jpg"),
                        fit: BoxFit.cover)),
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                    color: Color(0xff1A3540),
                    borderRadius: BorderRadius.circular(27),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 275,
                          child: TextFormField(
                            showCursor: false,
                            maxLength: 17,
                            initialValue: _presetName,
                            style: TextStyle(
                                color: Color(0xffD2F28D), fontSize: 23),
                            decoration: InputDecoration(
                                counterText: "",
                                hintText: "NEW PRESET NAME",
                                hintStyle: TextStyle(
                                    height: 1.5, color: Color(0xffD2F28D)),
                                labelText: "New Preset",
                                labelStyle: TextStyle(
                                    fontSize: 16, color: Color(0xff69BF41)),
                                border: InputBorder.none),
                            validator: (String value) {
                              return value.isEmpty ? "Name is necessary" : null;
                            },
                            enableInteractiveSelection: true,
                            onSaved: (String value) {
                              _presetName = value;
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Color(0xff1A3540),
                  borderRadius: BorderRadius.circular(27),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Wake Up",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff69BF41))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              height: 42,
                              width: 120,
                              child: FlatButton(
                                onPressed: () async {
                                  TimeOfDay time = await selectTime(context);
                                  setState(() {
                                    _wakeUpTime = time;
                                  });
                                  print(_wakeUpTime);
                                },
                                color: Color(0xffD2F28D),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(_wakeUpTime.format(context)),
                                    Icon(Icons.timer)
                                  ],
                                ),
                              )),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Sleep",
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff69BF41))),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              height: 42,
                              width: 120,
                              child: FlatButton(
                                onPressed: () async {
                                  TimeOfDay time = await selectTime(context);
                                  setState(() {
                                    _sleepTime = time;
                                  });
                                  print(_sleepTime);
                                },
                                color: Color(0xffD2F28D),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(_sleepTime.format(context)),
                                    Icon(Icons.timer)
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Color(0xff1A3540),
                  borderRadius: BorderRadius.circular(27),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Number of Meals",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff69BF41)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: "decrement",
                              mini: true,
                              onPressed: () {
                                int aux = _mealNumber - 2;
                                setState(() {
                                  _mealNumber = aux < 3 ? 3 : aux;
                                });
                              },
                              backgroundColor: Color(0xffD2F28D),
                              child: Icon(
                                Icons.remove,
                                color: Color(0xff3D5938),
                                size: 35,
                              ),
                            ),
                            Text(
                              _mealNumber.toString(),
                              style: TextStyle(
                                  color: Color(0xffD2F28D), fontSize: 40),
                            ),
                            FloatingActionButton(
                              heroTag: "increment",
                              mini: true,
                              onPressed: () {
                                int aux = _mealNumber + 2;

                                setState(() {
                                  _mealNumber = aux > 10 ? 9 : aux;
                                });
                              },
                              backgroundColor: Color(0xffD2F28D),
                              child: Icon(
                                Icons.add,
                                color: Color(0xff3D5938),
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Color(0xff1A3540),
                  borderRadius: BorderRadius.circular(27),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 10, 10),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: getMealField(_mealNumber),
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          )),
          floatingActionButton: FloatingActionButton(
            heroTag: "save",
            onPressed: () {
              if (!_formKey.currentState.validate()) return;

              _formKey.currentState.save();

              List<TimeOfDay> timeofdays =
                  TimeMath.calculateTime(_wakeUpTime, _sleepTime, _mealNumber);
              List<String> times = ["0"];

              for (TimeOfDay time in timeofdays) {
                String period = time.periodOffset == 0 ? " AM" : " PM";
                times.add(time.format(context) + period);
              }

              Navigator.pop(context, {
                "name": _presetName,
                "mealNumber": _mealNumber,
                "mealTimes": times,
                "mealNames": _mealName,
              });
            },
            child: Icon(
              Icons.save,
              color: Color(0xff3D5938),
              size: 35,
            ),
            backgroundColor: Color(0xffD2F28D),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Color(0xff69BF41),
        unselectedItemColor: Color(0xff3D5938),
        backgroundColor: Color(0xff1A3540),
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            title: Text(
              "Share",
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                "Home",
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text(
                "Info",
              ))
        ],
        onTap: (index) {
          Navigator.pop(context);
        },
      ),
    );
  }
}
