import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_chat/models/BalanceSheetResppnse.dart';
import 'package:flutter_chat/models/CurrencyRatesResponse.dart';
import 'package:flutter_chat/models/ResultRes.dart';

class DioScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DioState();
  }
}

class DioState extends State<DioScreen> {
  List<ResultRes> results = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dio test"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
                child: Container(
                  width: double.infinity,
                  color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("get DATA"),
                  ),
                ),
                onTap: () {
                  getSheet2();
                }),
          ),
          Expanded(
              flex: 5,
              child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Text(results[index].currency),
                        Text(results[index].marker),
                        Text(results[index].updateTime),
                      ],
                    );
                  }))
        ],
      ),
    );
  }

  Future getSheet() async {
    print("Start getSheet......");
    var response = await Dio().post(
        "https://abubasem.apptech.cash:6608/PaymentService/api/Payment/BalanceSheet",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization":
              "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIwMDI4IiwibmFtZSI6Itio2KfYs9mFIiwicmlkIjoiMiIsInRpbWUiOiIyMDE5LTEyLTIyVDIzOjMwOjI1LjQ5Nzc0OTcrMDM6MDAifQ.9Q_H6MWS_jaUmWlDsEAbAprahau7c2zHQvCYASs0stg",
          "Channel": "EC0000300"
        }),
        data: {
          "PeriodType": 0,
          "EndDate": "2019-12-22",
          "StartDate": "2019-10-22",
          "CurrencyID": 0,
          "Type": 0
        });
    print("end getSheet......");

    BalanceSheetResppnse myResponse =
        BalanceSheetResppnse.fromJson(json.decode(json.encode(response.data)));
    print("Hello  ${myResponse.result[0].price}");
  }

  Future getSheet2() async {
    print("Start getSheet......");
    var response = await Dio().post(
        "https://abubasem.apptech.cash:6608/PaymentService/api/Payment/BalanceSheet",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization":
              "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIwMDI4IiwibmFtZSI6Itio2KfYs9mFIiwicmlkIjoiMiIsInRpbWUiOiIyMDE5LTEyLTIyVDIzOjMwOjI1LjQ5Nzc0OTcrMDM6MDAifQ.9Q_H6MWS_jaUmWlDsEAbAprahau7c2zHQvCYASs0stg",
          "Channel": "EC0000300"
        }),
        data: {
          "PeriodType": 1,
          "EndDate": "2019-12-22",
          "StartDate": "2019-10-22",
          "CurrencyID": 0,
          "Type": 1
        });
    print("end getSheet......");

    BalanceSheetResppnse myResponse =
        BalanceSheetResppnse.fromJson(json.decode(json.encode(response.data)));
    print("Hello  ${myResponse.result[2].document}");
  }

  Future getCurrencyRate() async {
    print("Start getCurrencyRate......");
    var response = await Dio().get(

        "https://abubasem.apptech.cash:6608/PaymentService/api/Payment/CurrencyRates",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        }));
    print("end getCurrencyRate......");

    CurrencyRatesResponse myResponse =
        CurrencyRatesResponse.fromJson(json.decode(json.encode(response.data)));
    setState(() {
      this.results = myResponse.result;
    });





  }


}
