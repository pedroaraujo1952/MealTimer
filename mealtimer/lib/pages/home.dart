import 'package:flutter/material.dart';
import 'package:mealtimer/components/preset.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _nameTag = "name";
const _activeIndexTag = "activeindex";
const _mealNumberTag = "mealnumber";
const _mealNamesTag = "mealnames";
const _mealTimesTag = "mealtimes";

const _foodEatenCountTag = "foodeatencount";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

int foodEatenCount = 0;
int totalFoodCount = 0;
double foodEatenPercent = (foodEatenCount / totalFoodCount).isNaN
    ? 0.01
    : foodEatenCount / totalFoodCount;

List<Widget> presets = [];
int presetLength = 0;

int _activeIndex;

class _HomeState extends State<Home> {
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
                  lineWidth: 10,
                  percent: foodEatenPercent,
                  animation: true,
                  center: Image(
                    image: AssetImage("assets/stick.png"),
                    height: 86,
                    width: 40,
                  ),
                  progressColor: Color(0xff69BF41),
                  backgroundColor: Color(0xff1A3540),
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
          Column(
            children: presets,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: RaisedButton(
                  onPressed: () async {
                    dynamic response =
                        await Navigator.pushNamed(context, "/newPreset");

                    for (Preset preset in presets) {
                      preset.changeActiveState();
                    }

                    setState(() {
                      presets.add(Preset(
                        active: true,
                        name: response['name'],
                        mealNumber: response['mealNumber'],
                        mealNames: response['mealNames'],
                        mealTimes: response['mealTimes'],
                        function: eatMeal,
                      ));
                      foodEatenCount = 0;
                      totalFoodCount = response['mealNumber'];
                      _activeIndex = presetLength;
                      presetLength += 1;
                    });

                    savePreset(
                        _activeIndex,
                        response['name'],
                        response['mealNumber'],
                        response['mealNames'],
                        response['mealTimes']);

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
                height: 30,
              )
            ],
          )
        ],
      ),
    );
  }

  //Save Preset
  Future<bool> savePreset(int activeIndex, String name, int mealNumber,
      List<String> mealNames, List<String> mealTimes) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_activeIndexTag, activeIndex);
    await preferences.setString(_nameTag + presetLength.toString(), name);
    await preferences.setInt(
        _mealNumberTag + presetLength.toString(), mealNumber);
    await preferences.setStringList(
        _mealNamesTag + presetLength.toString(), mealNames);
    await preferences.setStringList(
        _mealTimesTag + presetLength.toString(), mealTimes);
    return true;
  }

  //Get Presets
  Future<void> getPresets() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    int activeIndex = preferences.getInt(_activeIndexTag);

    var i = 1;
    while (preferences.getString(_nameTag + i.toString()) != null) {
      String name = preferences.getString(_nameTag + i.toString());
      int mealNumber = preferences.getInt(_mealNumberTag + i.toString());
      List<String> mealNames =
          preferences.getStringList(_mealNamesTag + i.toString());
      List<String> mealTimes =
          preferences.getStringList(_mealTimesTag + i.toString());

      setState(() {
        _activeIndex = activeIndex;

        presets.add(Preset(
          active: presets.length == activeIndex ? true : false,
          name: name,
          mealNumber: mealNumber,
          mealNames: mealNames,
          mealTimes: mealTimes,
          function: eatMeal,
        ));
        totalFoodCount =
            presets.length == activeIndex ? mealNumber : totalFoodCount;
        presetLength += 1;
      });
      i++;
    }
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
}
