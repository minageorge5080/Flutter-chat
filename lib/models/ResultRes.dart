class ResultRes {
  String currency;
  double transferPrice;
  double sellPrice;
  double buyPrice;
  String marker;
  String updateTime;

  ResultRes({this.currency, this.transferPrice, this.sellPrice, this.buyPrice,this.marker,this.updateTime});

  ResultRes.fromJson(Map<String, dynamic> json) {
    currency = json['العملة'];
    transferPrice = json['سعر التحويل'];
    sellPrice = json['سعر البيع'];
    buyPrice = json['سعر الشراء'];
    marker = json['الرمز'];
    updateTime = json['اخر وقت تحديث'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['العملة'] = this.currency;
    data['سعر التحويل'] = this.transferPrice;
    data['سعر البيع'] = this.sellPrice;
    data['سعر الشراء'] = this.buyPrice;
    data['الرمز'] = this.marker;
    data['اخر وقت تحديث'] = this.updateTime;

    return data;
  }
}