// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, file_names, deprecated_member_use, prefer_typing_uninitialized_variables, must_be_immutable, avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/WorldData.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:country_state_city_picker/country_state_city_picker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  RegExp regex = RegExp(
      "((?<=(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff])[\ufe0e\ufe0f]?(?:[\u0300-\u036f\ufe20-\ufe23\u20d0-\u20f0]|\ud83c[\udffb-\udfff])?(?:\u200d(?:[^\ud800-\udfff]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff])[\ufe0e\ufe0f]?(?:[\u0300-\u036f\ufe20-\ufe23\u20d0-\u20f0]|\ud83c[\udffb-\udfff])?)*)|(?=(?:[\u2700-\u27bf]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff])[\ufe0e\ufe0f]?(?:[\u0300-\u036f\ufe20-\ufe23\u20d0-\u20f0]|\ud83c[\udffb-\udfff])?(?:\u200d(?:[^\ud800-\udfff]|(?:\ud83c[\udde6-\uddff]){2}|[\ud800-\udbff][\udc00-\udfff])[\ufe0e\ufe0f]?(?:[\u0300-\u036f\ufe20-\ufe23\u20d0-\u20f0]|\ud83c[\udffb-\udfff])?)*))");
  String? chosenCountry = null,
      chosenState = null,
      chosenCity = null,
      response = "";

  Stat stat = Stat(
    cases: null,
    deaths: null,
    recovered: null,
    todayactive: null,
    todaydeaths: null,
    todaycases: null,
  );

  void getStats(String country) async {
    var url = Uri.parse(
        "https://coronavirus-19-api.herokuapp.com/countries/$country");

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

  void getError(country) {
    setState(() {
      response = country;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Covid Seva Portal")),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          WorldData(),
          Text(
            "Search by Region",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: SelectState(
              onCountryChanged: (value) {
                setState(() {
                  chosenCountry = value.split(regex)[2].trim();
                  response = "";
                  getStats(chosenCountry.toString());
                });
              },
              onStateChanged: (value) {
                setState(() {
                  chosenState = value;
                  response = "";
                });
              },
              onCityChanged: (value) {
                setState(() {
                  chosenCity = value;
                  response = "";
                });
              },
            ),
          ),
          Text(response.toString()),
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              if (chosenCountry != null &&
                  chosenState != null &&
                  chosenCity != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GoToNext(
                        chosenCountry.toString(),
                        stat.cases.toString(),
                        stat.deaths.toString(),
                        stat.recovered.toString(),
                        stat.todayactive.toString(),
                        stat.todaydeaths.toString(),
                        stat.todaycases.toString())));
              } else if (chosenCountry == null &&
                  chosenState == null &&
                  chosenCity == null) {
                getError("Please select Country, State, City");
              } else if (chosenCountry != null &&
                  chosenState == null &&
                  chosenCity == null) {
                getError("Please select State, City");
              } else if (chosenCountry != null &&
                  chosenState != null &&
                  chosenCity == null) {
                getError("Please select City");
              }
            },
            child: Text("Search"),
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

class GoToNext extends StatelessWidget {
  final String country,
      cases,
      deaths,
      recovered,
      active,
      todaydeaths,
      todaycases;
  const GoToNext(this.country, this.cases, this.deaths, this.recovered,
      this.active, this.todaydeaths, this.todaycases);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("Total Cases : " + cases),
          Text("Total Deaths : " + deaths),
          Text("Total Recovered : " + recovered),
          Text("Active Today : " + active),
          Text("Total Recovered : " + todaydeaths),
          Text("Cases Today : " + todaycases),
        ],
      ),
    );
  }
}
