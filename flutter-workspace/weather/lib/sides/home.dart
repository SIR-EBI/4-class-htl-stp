import 'package:flutter/material.dart';
import 'package:flutter_test_eberhardt/domain/sun_manager.dart';
import 'package:flutter_test_eberhardt/widgets/city_line_chart.dart';

import '../domain/db_utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SunManager> downTimeList = <SunManager>[];
  List<SunManager> upTimeList = <SunManager>[];

  String city = "";
  String url = "";

  Future<void> loadDatas() async {
    upTimeList = await DBUtils.getSunFromCity(
        "https://fluttertests-9a56e-default-rtdb.europe-west1.firebasedatabase.app",
        "Sonnenaufgang",
        "bregenz");
    downTimeList = await DBUtils.getSunFromCity(
        "https://fluttertests-9a56e-default-rtdb.europe-west1.firebasedatabase.app",
        "Sonnenuntergang",
        "bregenz");

    setState(() {});
    setState(() {});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (downTimeList.isEmpty && city.isNotEmpty) {
      loadDatas();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Sunrise/Sunset   $city"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () async {
              dynamic result = await Navigator.pushNamed(context, "/setting");

              if (result is Map) {
                url = result["url"];
                city = result["city"];

                if (city != "Empty") {
                  loadDatas();
                }
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          /**
           *    Question:
           *      Describe the Plow where is the offset coming from?
           *
           *    Answer:
           *      The shift in the chart comes from the time shift, which happens 2 times in the year.
           */

          child: CityLineChart(
            downTimeList: downTimeList,
            upTimeList: upTimeList,
          ),
        ),
      ),
    );
  }
}
