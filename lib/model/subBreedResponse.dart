import 'dart:convert';

SubBreedList subBreedListFromJson(Map<String, dynamic> json) => SubBreedList.fromJson(json);

String subBreedListToJson(SubBreedList data) => json.encode(data.toJson());

class SubBreedList {
    SubBreedList({
        this.message,
        this.status,
    });

    List<String> message;
    String status;

    factory SubBreedList.fromJson(Map<String, dynamic> json) => SubBreedList(
        message: List<String>.from(json["message"].map((x) => x)),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message.map((x) => x)),
        "status": status,
    };
}
