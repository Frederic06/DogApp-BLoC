import 'dart:convert';

BreedListResponse breedListResponseFromJson(Map<String, dynamic> json) =>
    BreedListResponse.fromJson(json);

String breedListResponseToJson(BreedListResponse data) =>
    json.encode(data.toJson());

class BreedListResponse {
  Map<String, dynamic> message;
  String status;

  BreedListResponse({
    this.message,
    this.status,
  });

  factory BreedListResponse.fromJson(Map<String, dynamic> json) =>
      BreedListResponse(
        message: Map.from(json["message"]).map((k, v) =>
            MapEntry<String, List<String>>(
                k, List<String>.from(v.map((x) => x)))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": Map.from(message).map((k, v) =>
            MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))),
        "status": status,
      };
}

extension NewFunctions on BreedListResponse {
  List<String> getBreedList() {
    var listOfString = List<String>.empty(growable: true);
    this.message.forEach((key, value) {
      listOfString.add(key);
    });
    return listOfString;
  }
}
