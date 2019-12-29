class BalanceSheetResppnse {
  int reqType;
  int rC;
  bool success;
  List<Result> result;
  Null extra;
  Null error;
  bool unAuthorized;

  BalanceSheetResppnse(
      {this.reqType,
        this.rC,
        this.success,
        this.result,
        this.extra,
        this.error,
        this.unAuthorized});

  BalanceSheetResppnse.fromJson(Map<String, dynamic> json) {
    reqType = json['ReqType'];
    rC = json['RC'];
    success = json['Success'];
    if (json['Result'] != null) {
      result = new List<Result>();
      json['Result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
    extra = json['Extra'];
    error = json['Error'];
    unAuthorized = json['UnAuthorized'];
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

class Result {
  String accountName;
  String currency;
  String modeen;
  String daaaen;
  String price;
  String description;
  String document;

  Result({this.accountName, this.currency, this.modeen, this.daaaen, this.price, this.description, this.document});

  Result.fromJson(Map<String, dynamic> json) {
    accountName = json['اسم الحساب'];
    currency = json['العملة'];
    modeen = json['مدين'];
    daaaen = json['دائن'];
    price = json['الرصيد'];
    description = json['البيان'];
    document = json['المستند'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['اسم الحساب'] = this.accountName;
    data['العملة'] = this.currency;
    data['مدين'] = this.modeen;
    data['دائن'] = this.daaaen;
    data['الرصيد'] = this.price;
    data['البيان'] = this.description;
    data['المستند'] = this.document;
    return data;
  }
}