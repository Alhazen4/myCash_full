import 'dart:convert';

List<StatisticModel> statisticModelFromJson(String str) =>
    List<StatisticModel>.from(
        json.decode(str).map((x) => StatisticModel.fromJson(x)));

String statisticModelToJson(List<StatisticModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatisticModel {
  StatisticModel({
    required this.amount,
    required this.userid,
  });

  int amount;
  int userid;

  factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
        amount: json["amount"],
        userid: json["userID"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "userid": userid,
      };
}
