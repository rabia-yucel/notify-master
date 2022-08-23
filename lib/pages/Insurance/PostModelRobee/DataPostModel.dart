import 'dart:convert';

import 'dart:convert';

DataPostModel dataPostModelFromJson(String str) =>
    DataPostModel.fromJson(json.decode(str));

String dataPostModelToJson(DataPostModel data) => json.encode(data.toJson());

class DataPostModel {
  DataPostModel({
    required this.plateNumber,
    required this.finCode,
    required this.carCertificateCode,
    required this.mobilePhone,
    //required this.email,
  });

  String plateNumber;
  String finCode;
  String carCertificateCode;
  String mobilePhone;
  //String email;

  factory DataPostModel.fromJson(Map<String, dynamic> json) => DataPostModel(
        plateNumber: json["PlateNumber"],
        finCode: json["FinCode"],
        carCertificateCode: json["CarCertificateCode"],
        mobilePhone: json["MobilePhone"],
        // email: json["Email"],
      );

  Map<String, dynamic> toJson() => {
        "PlateNumber": plateNumber,
        "FinCode": finCode,
        "CarCertificateCode": carCertificateCode,
        "MobilePhone": mobilePhone,
        // "Email": email,
      };
}

/*class DataPostModel {


  String? PlateNumber;
  String? FinCode;
  String? CarCertificateCode;
  String? MobilePhone;
  String? Email;

  DataPostModel({
    this.PlateNumber,
    this.FinCode,
    this.CarCertificateCode,
    this.MobilePhone,
    this.Email,
  });
  DataPostModel.fromJson(Map<String, dynamic> json) {
    PlateNumber = json['PlateNumber']?.toString();
    FinCode = json['FinCode']?.toString();
    CarCertificateCode = json['CarCertificateCode']?.toString();
    MobilePhone = json['MobilePhone']?.toString();
    Email = json['Email']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['PlateNumber'] = PlateNumber;
    data['FinCode'] = FinCode;
    data['CarCertificateCode'] = CarCertificateCode;
    data['MobilePhone'] = MobilePhone;
    data['Email'] = Email;
    return data;
  }
} */

/* class DataPostModel {
  String? plateNumber;
  String? finCode;
  String? carCertificateCode;
  String? mobilePhone;
  String? email;

  DataPostModel(
      {this.plateNumber,
        this.finCode,
        this.carCertificateCode,
        this.mobilePhone,
        this.email});

  DataPostModel.fromJson(Map<String, dynamic> json) {
    plateNumber = json['PlateNumber'];
    finCode = json['FinCode'];
    carCertificateCode = json['CarCertificateCode'];
    mobilePhone = json['MobilePhone'];
    email = json['Email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PlateNumber'] = this.plateNumber;
    data['FinCode'] = this.finCode;
    data['CarCertificateCode'] = this.carCertificateCode;
    data['MobilePhone'] = this.mobilePhone;
    data['Email'] = this.email;
    return data;
  }
}  */
