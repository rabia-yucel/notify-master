import 'dart:convert';



DataPostModelOcr dataPostModelOcrFromJson(String str) => DataPostModelOcr.fromJson(json.decode(str));

String dataPostModelOcrToJson(DataPostModelOcr data) => json.encode(data.toJson());

class DataPostModelOcr {
  DataPostModelOcr({
    required this.textt,

  });

  String textt;


  factory DataPostModelOcr.fromJson(Map<String, dynamic> json) => DataPostModelOcr(
    textt: json["Textt"],

  );

  Map<String, dynamic> toJson() => {
    "Textt": textt,

  };
}

