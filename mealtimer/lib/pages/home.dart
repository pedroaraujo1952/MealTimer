import 'package:flutter/material.dart';
import 'package:mealtimer/components/preset.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _nameTag = "name";
const _activeStatusTag = "activestatus";
const _mealNumberTag = "mealnumber";
const _mealNamesTag = "mealnames";
const _mealTimesTag = "mealtimes";

const _foodEatenCountTag = "foodeatencount";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _active;
  String _name;
  int _mealNumber;
  List<String> _mealNames, _mealTimes;
  Function _eatFunction, _resetFunction, _activateFunction;

  int foodEatenCount = 0;
  int totalFoodCount = 0;
  double foodEatenPercent = 0.01;

  //InitState
  @override
  void initState() {
    getPresets().then((_) {
      getFoodEatenCount().then((int value) {
        var aux = value / totalFoodCount;
        print(aux);
        if (aux.isNaN || aux == 0) aux = 0.01;
        setState(() {
          foodEatenCount = value;
          foodEatenPercent = aux;
        });
      });
    });
    super.initState();
  }

  void eatMeal() {
    setState(() {
      foodEatenCount = foodEatenCount >= totalFoodCount
          ? foodEatenCount
          : foodEatenCount + 1;
      foodEatenPercent = foodEatenCount / totalFoodCount;
    });
    saveFoodEatenCount(foodEatenCount);
  }

  void resetFoodCounters() {
    setState(() {
      foodEatenCount = 0;
      totalFoodCount = 0;
      foodEatenPercent = 0.01;
    });

    saveFoodEatenCount(foodEatenCount);
    saveActiveStatus(false);
  }

  void activate(int _totalFoodCount) {
    int _foodEatenCount = 0;
    double _foodEatenPercent = _foodEatenCount / _totalFoodCount;

    setState(() {
      foodEatenCount = _foodEatenCount;
      totalFoodCount = _totalFoodCount;
      foodEatenPercent = _foodEatenPercent == 0 ? 0.01 : _foodEatenPercent;
    });

    saveFoodEatenCount(foodEatenCount);
    saveActiveStatus(true);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 70,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xff1A3540),
                borderRadius: BorderRadius.all(Radius.circular(27.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                CircularPercentIndicator(
                  radius: 135,
                  lineWidth: 13,
                  percent: foodEatenPercent,
                  animation: true,
                  center: Image(
                    image: AssetImage("assets/stick.png"),
                    height: 76,
                    width: 30,
                  ),
                  progressColor: Color(0xff69BF41),
                  backgroundColor: Color(0xff12262E),
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Food Eaten",
                  style: TextStyle(fontSize: 16, color: Color(0xffD2F28D)),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      foodEatenCount.toString(),
                      style: TextStyle(fontSize: 16, color: Color(0xff69BF41)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "/",
                      style: TextStyle(fontSize: 16, color: Color(0xffD2F28D)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(totalFoodCount.toString(),
                        style:
                            TextStyle(fontSize: 16, color: Color(0xffD2F28D)))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              if (_name != null)
                return Preset(
                  active: _active,
                  name: _name,
                  mealNumber: _mealNumber,
                  mealNames: _mealNames,
                  mealTimes: _mealTimes,
                  eat: _eatFunction,
                  reset: _resetFunction,
                  activate: _activateFunction,
                );
              else
                return Container();
            },
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: RaisedButton(
                  onPressed: () async {
                    dynamic response =
                        await Navigator.pushNamed(context, "/newPreset");

                    setState(() {
                      _active = true;
                      _name = response['name'];
                      _mealNumber = response['mealNumber'];
                      _mealNames = response['mealNames'];
                      _mealTimes = response['mealTimes'];
                      _eatFunction = eatMeal;
                      _resetFunction = resetFoodCounters;
                      _activateFunction = activate;

                      foodEatenCount = 0;
                      totalFoodCount = response['mealNumber'];
                      foodEatenPercent = 0.01;
                    });

                    savePreset(response['name'], response['mealNumber'],
                        response['mealNames'], response['mealTimes']);

                    saveFoodEatenCount(foodEatenCount);
                  },
                  color: Color(0xff1A3540),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(27.0)),
                      side: BorderSide(color: Color(0xffD2F28D))),
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "New Preset",
                        style:
                            TextStyle(color: Color(0xffD2F28D), fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          )
        ],
      ),
    );
  }

  //Save Preset
  Future<bool> savePreset(String name, int mealNumber, List<String> mealNames,
      List<String> mealTimes) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_nameTag, name);
    await preferences.setInt(_mealNumberTag, mealNumber);
    await preferences.setStringList(_mealNamesTag, mealNames);
    await preferences.setStringList(_mealTimesTag, mealTimes);
    return true;
  }

  //Get Presets
  Future<void> getPresets() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String name = preferences.getString(_nameTag);
    int mealNumber = preferences.getInt(_mealNumberTag);
    List<String> mealNames = preferences.getStringList(_mealNamesTag);
    List<String> mealTimes = preferences.getStringList(_mealTimesTag);

    bool isActive = await getActiveStatus();

    setState(() {
      _active = isActive;
      _name = name;
      _mealNumber = mealNumber;
      _mealNames = mealNames;
      _mealTimes = mealTimes;
      _eatFunction = eatMeal;
      _resetFunction = resetFoodCounters;
      _activateFunction = activate;
      totalFoodCount = mealNumber;
    });
  }

  Future<bool> saveFoodEatenCount(int food) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_foodEatenCountTag, food);
    return true;
  }

  Future<int> getFoodEatenCount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_foodEatenCountTag);
  }

  Future<bool> saveActiveStatus(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_activeStatusTag, value);
    return true;
  }

  Future<bool> getActiveStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_activeStatusTag);
  }
}
