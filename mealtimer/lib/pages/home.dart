import 'package:flutter/material.dart';
import 'package:mealtimer/components/preset.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

int foodEatenCount = 0;
int totalFoodCount = 0;
double foodEatenPercent = (foodEatenCount / totalFoodCount).isNaN
    ? 0.8
    : foodEatenCount / totalFoodCount;

List<Widget> presets = [];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
                      style: TextStyle(fontSize: 16, color: Color(0xffD2F28D)))
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

                  print(response);

                  setState(() {
                    presets.add(Preset(
                      active: false,
                      name: response['name'],
                      mealNumber: response['mealNumber'],
                      mealNames: response['mealNames'],
                      mealTimes: response['mealTimes'],
                    ));
                  });
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
                      style: TextStyle(color: Color(0xffD2F28D), fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        )
      ],
    );
  }
}
