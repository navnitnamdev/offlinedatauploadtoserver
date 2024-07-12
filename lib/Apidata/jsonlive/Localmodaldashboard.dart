import 'dart:convert';

import 'package:untitled/Apidata/jsonlive/Dashboardmodal.dart';
import 'package:untitled/Apidata/jsonlive/Dashboardsecondarray.dart';

class Localmodaldashboard {
  final int? id;

  // If you have an ID for each record
  final List<Dashboardsecondarray> mainresult;

  Localmodaldashboard({required this.id, required this.mainresult});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Result': jsonEncode(mainresult),
    };
  }

  factory Localmodaldashboard.fromMap(Map<String, dynamic> map) {
    return Localmodaldashboard(
      id: map['id'],
      mainresult: jsonDecode(map['Result']),
    );
  }
}
