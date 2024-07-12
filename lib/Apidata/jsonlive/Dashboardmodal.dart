// To parse this JSON data, do
//
//     final dashboardmodal = dashboardmodalFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Dashboardmodal dashboardmodalFromJson(String str) => Dashboardmodal.fromJson(json.decode(str));

String dashboardmodalToJson(Dashboardmodal data) => json.encode(data.toJson());

class Dashboardmodal {
  bool status;
  String message;
  List<DashboardmodalResult> result;

  Dashboardmodal({
    required this.status,
    required this.message,
    required this.result,
  });

  factory Dashboardmodal.fromJson(Map<String, dynamic> json) => Dashboardmodal(
    status: json["Status"],
    message: json["Message"],
    result: List<DashboardmodalResult>.from(json["Result"].map((x) => DashboardmodalResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class DashboardmodalResult {
  String menuId;
  String heading;
  List<SubHeadingmenulist> subHeadingmenulist;

  DashboardmodalResult({
    required this.menuId,
    required this.heading,
    required this.subHeadingmenulist,
  });

  factory DashboardmodalResult.fromJson(Map<String, dynamic> json) => DashboardmodalResult(
    menuId: json["MenuId"],
    heading: json["Heading"],
    subHeadingmenulist: List<SubHeadingmenulist>.from(json["SubHeadingmenulist"].map((x) => SubHeadingmenulist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "MenuId": menuId,
    "Heading": heading,
    "SubHeadingmenulist": List<dynamic>.from(subHeadingmenulist.map((x) => x.toJson())),
  };
}

class SubHeadingmenulist {
  String subHeadingMenuId;
  String subHeading;
  String subHeadingParentId;
  List<SubHeadingmenulistResult> result;

  SubHeadingmenulist({
    required this.subHeadingMenuId,
    required this.subHeading,
    required this.subHeadingParentId,
    required this.result,
  });

  factory SubHeadingmenulist.fromJson(Map<String, dynamic> json) => SubHeadingmenulist(
    subHeadingMenuId: json["SubHeadingMenuId"],
    subHeading: json["SubHeading"],
    subHeadingParentId: json["SubHeadingParentId"],
    result: List<SubHeadingmenulistResult>.from(json["Result"].map((x) => SubHeadingmenulistResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "SubHeadingMenuId": subHeadingMenuId,
    "SubHeading": subHeading,
    "SubHeadingParentId": subHeadingParentId,
    "Result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class SubHeadingmenulistResult {
  String lableMenuId;
  String lableText;
  String lableValue;
  String icon;

  SubHeadingmenulistResult({
    required this.lableMenuId,
    required this.lableText,
    required this.lableValue,
    required this.icon,
  });

  factory SubHeadingmenulistResult.fromJson(Map<String, dynamic> json) => SubHeadingmenulistResult(
    lableMenuId: json["lableMenuId"],
    lableText: json["LableText"],
    lableValue: json["LableValue"],
    icon: json["Icon"],
  );

  Map<String, dynamic> toJson() => {
    "lableMenuId": lableMenuId,
    "LableText": lableText,
    "LableValue": lableValue,
    "Icon": icon,
  };
}
