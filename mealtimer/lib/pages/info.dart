import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              decoration: BoxDecoration(
                  color: Color(0xff1A3540),
                  borderRadius: BorderRadius.all(Radius.circular(27.0))),
              child: Padding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/ph.jpg"),
                      radius: 55,
                    ),
                    Column(
                      children: <Widget>[
                        Text("from",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        Text(
                          "Pedro Araújo",
                          style: TextStyle(fontSize: 27, color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 25.0),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              decoration: BoxDecoration(
                  color: Color(0xff1A3540),
                  borderRadius: BorderRadius.all(Radius.circular(27.0))),
              child: Padding(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 10.0),
                      child: Image(
                        image: AssetImage("assets/food.jpg"),
                      ),
                    ),
                    Text(
                      "©2020-2021 Copyright",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 20.0,
                    )
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              decoration: BoxDecoration(
                  color: Color(0xff1A3540),
                  borderRadius: BorderRadius.all(Radius.circular(27.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Version",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "0.0.1",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        )
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
