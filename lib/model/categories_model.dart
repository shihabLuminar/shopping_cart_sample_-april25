// To parse this JSON data, do
//
//     final categroyModel = categroyModelFromJson(jsonString);

import 'dart:convert';

List<CategroyModel> categroyModelFromJson(String str) =>
    List<CategroyModel>.from(
        json.decode(str).map((x) => CategroyModel.fromJson(x)));

class CategroyModel {
  String? slug;
  String? name;
  String? url;

  CategroyModel({
    this.slug,
    this.name,
    this.url,
  });

  factory CategroyModel.fromJson(Map<String, dynamic> json) => CategroyModel(
        slug: json["slug"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "url": url,
      };
}
