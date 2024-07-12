// To parse this JSON data, do
//
//     final getdatamodal = getdatamodalFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Getdatamodal getdatamodalFromJson(String str) =>
    Getdatamodal.fromJson(json.decode(str));

String getdatamodalToJson(Getdatamodal data) => json.encode(data.toJson());

class Getdatamodal {
  bool status;
  String message;
  List<Result> result;

  Getdatamodal({
    required this.status,
    required this.message,
    required this.result,
  });

  factory Getdatamodal.fromJson(Map<String, dynamic> json) => Getdatamodal(
        status: json["Status"],
        message: json["Message"],
        result:
            List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  String name;
  String emailId;
  String mobielNumber;

  Result({
    required this.name,
    required this.emailId,
    required this.mobielNumber,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["Name"],
        emailId: json["EmailId"],
        mobielNumber: json["MobielNumber"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "EmailId": emailId,
        "MobielNumber": mobielNumber,
      };
}
