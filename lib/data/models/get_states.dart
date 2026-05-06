import 'dart:convert';

GetStates getStatesFromJson(String str) => GetStates.fromJson(json.decode(str));

String getStatesToJson(GetStates data) => json.encode(data.toJson());

class GetStates {
  final List<StateModel> states;

  GetStates({required this.states});

  // Factory constructor to create an instance from JSON
  factory GetStates.fromJson(Map<String, dynamic> json) {
    var list = json['states'] as List;
    List<StateModel> stateList = list.map((x) => StateModel.fromJson(x)).toList();

    return GetStates(states: stateList);
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() => {
    'states': states.map((state) => state.toJson()).toList(),
  };
}

class StateModel {
  final String code;
  final String name;
  final String mycode;
  final int mnpCode;

  StateModel({
    required this.code,
    required this.name,
    required this.mycode,
    required this.mnpCode,
  });

  // Factory constructor to create a State object from JSON
  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    code: json['code'],
    name: json['name'],
    mycode: json['mycode'],
    mnpCode: json['mnpCode'],
  );

  // Method to convert a State object to JSON
  Map<String, dynamic> toJson() => {
    'code': code,
    'name': name,
    'mycode': mycode,
    'mnpCode': mnpCode,
  };

  // Override toString() to print State objects nicely
  @override
  String toString() {
    return 'State(code: $code, name: $name, mycode: $mycode, mnpCode: $mnpCode)';
  }
}

