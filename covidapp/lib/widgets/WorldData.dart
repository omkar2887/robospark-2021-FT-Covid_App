// ignore_for_file: use_key_in_widget_constructors, file_names, unused_import, must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Stat {
  final cases;
  final deaths;
  final recovered;
  final todayactive;
  final todaydeaths;
  final todaycases;
  Stat(
      {this.cases,
      this.deaths,
      this.recovered,
      this.todayactive,
      this.todaydeaths,
      this.todaycases});
}

class WorldData extends StatefulWidget {
  @override
  _WorldData createState() => _WorldData();
}

class _WorldData extends State<WorldData> {
  Stat stat = Stat(
    cases: null,
    deaths: null,
    recovered: null,
    todayactive: null,
    todaydeaths: null,
    todaycases: null,
  );

  void getStats() async {
    var url =
        Uri.parse("https://coronavirus-19-api.herokuapp.com/countries/world");

    var response = await http.get(url);

    var responseData = jsonDecode(response.body);
    setState(() {
      Stat obj = Stat(
        cases: responseData["cases"],
        deaths: responseData["deaths"],
        recovered: responseData["recovered"],
        todayactive: responseData["active"],
        todaydeaths: responseData["todayDeaths"],
        todaycases: responseData["todayCases"],
      );

      stat = obj;
    });
  }

  @override
  void initState() {
    super.initState();
    getStats();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          const Text("World Statistics"),
          Text("Total Cases : " + stat.cases.toString()),
          Text("Total Recovered : " + stat.recovered.toString()),
          Text("Total Deaths : " + stat.deaths.toString()),
          Text("Active : " + stat.todayactive.toString()),
          Text("Deaths Today : " + stat.todaydeaths.toString()),
          Text("Cases Today : " + stat.todaycases.toString()),
        ],
      ),
    );
  }
}
