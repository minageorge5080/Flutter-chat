import 'dart:convert';

import 'ResultRes.dart';

class CurrencyRatesResponse {
  int reqType;
  int rC;
  bool success;
  List<ResultRes> result;
  Null extra;
  Null error;
  bool unAuthorized;

  CurrencyRatesResponse(
      {this.reqType,
        this.rC,
        this.success,
        this.result,
        this.extra,
        this.error,
        this.unAuthorized});

  CurrencyRatesResponse.fromJson(Map<String, dynamic> myjson) {
    reqType = myjson['ReqType'];
    rC = myjson['RC'];
    success = myjson['Success'];
    if (myjson['Result'] != null) {
      result = new List<ResultRes>();
      json.decode(myjson['Result']).forEach((v) {
        result.add(new ResultRes.fromJson(v));
      });
    }
    extra = myjson['Extra'];
    error = myjson['Error'];
    unAuthorized = myjson['UnAuthorized'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ReqType'] = this.reqType;
    data['RC'] = this.rC;
    data['Success'] = this.success;
    if (this.result != null) {
      data['Result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['Extra'] = this.extra;
    data['Error'] = this.error;
    data['UnAuthorized'] = this.unAuthorized;
    return data;
  }

}

