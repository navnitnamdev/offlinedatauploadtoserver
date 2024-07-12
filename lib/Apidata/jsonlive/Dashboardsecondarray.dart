import 'dart:convert';

class Dashboardsecondarray {
  final String? MenuId;
  final String? Heading;
  final List<Subheadinglocallistmodal> subheadinglocallist;

  Dashboardsecondarray(
      {required this.MenuId,
      required this.Heading,
      required this.subheadinglocallist});

  Map<String, dynamic> toMap() {
    return {
      'MenuId': MenuId,
      'Heading': Heading,
      'SubHeadingmenulist': jsonEncode(subheadinglocallist),
    };
  }

  factory Dashboardsecondarray.fromMap(Map<String, dynamic> map) {
    return Dashboardsecondarray(
      MenuId: map['MenuId'],
      Heading: map['Heading'],
      subheadinglocallist: jsonDecode(map['SubHeadingmenulist']),
    );
  }
}

class Subheadinglocallistmodal {
  final int? SubHeadingMenuId;
  final int? SubHeading;
  final int? SubHeadingParentId;

  final List<Subresultlistmodal> Result;

  Subheadinglocallistmodal(
      {required this.SubHeadingMenuId,
      required this.SubHeading,
      required this.SubHeadingParentId,
      required this.Result});

  Map<String, dynamic> toMap() {
    return {
      'SubHeadingMenuId': SubHeadingMenuId,
      'SubHeading': SubHeading,
      'SubHeadingParentId': SubHeadingParentId,
      'Result': jsonEncode(Result),
    };
  }

  factory Subheadinglocallistmodal.fromMap(Map<String, dynamic> map) {
    return Subheadinglocallistmodal(
      SubHeadingMenuId: map['SubHeadingMenuId'],
      SubHeading: map['SubHeading'],
      SubHeadingParentId: map['SubHeadingParentId'],
      Result: jsonDecode(map['Result']),
    );
  }
}

class Subresultlistmodal {
  final int? lableMenuId;
  final int? LableText;
  final int? LableValue;
  final int? Icon;

  Subresultlistmodal(
      {required this.lableMenuId,
      required this.LableText,
      required this.LableValue,
      required this.Icon});

  Map<String, dynamic> toMap() {
    return {
      'lableMenuId': lableMenuId,
      'LableText': LableText,
      'LableValue': LableValue,
      'Icon': Icon,
    };
  }

  factory Subresultlistmodal.fromMap(Map<String, dynamic> map) {
    return Subresultlistmodal(
      lableMenuId: map['lableMenuId'],
      LableText: map['LableText'],
      LableValue: map['LableValue'],
      Icon: jsonDecode(map['Icon']),
    );
  }
}
