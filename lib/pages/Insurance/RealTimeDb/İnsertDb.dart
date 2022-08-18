import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notify/utils/constant.dart';
import 'package:http/http.dart' as http;

import '../PostModelRobee/DataPostModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RealTimeDbInsert extends StatefulWidget {
  const RealTimeDbInsert({Key? key}) : super(key: key);

  @override
  State<RealTimeDbInsert> createState() => _RealTimeDbInsertState();
}

Future<DataPostModel?> submitdata(String plateNumber, String finCode,
    String carCertificateCode, String mobilePhone, String email) async {
  //var response = await http.post(Uri.https('iwork.btarge.com','api/AccountApi/CreateInsuranceContract'),
  //var response = await http.post(Uri.https('iwork.btarge.com','api/AccountApi/CreateInsuranceContract'),

  var response = await http.post(
      Uri.parse(
          "https://iwork.btarge.com/api/AccountApi/CreateInsuranceContract"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: json.encode({
        "plateNumber": plateNumber,
        "finCode": finCode,
        "carCertificateCode": carCertificateCode,
        "mobilePhone": mobilePhone,
        "email": email
      }));
  var data = response.body;
  print(data);

  if (response.statusCode == 200) {
    String responseString = response.body;
    dataPostModelFromJson(responseString);
  } else {
    return null;
  }
}

class _RealTimeDbInsertState extends State<RealTimeDbInsert> {
  late DataPostModel _dataPostModel;
  // late Link _link;
  TextEditingController regController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController finController = TextEditingController();
  TextEditingController phoneControoler = TextEditingController();
  TextEditingController mailController = TextEditingController();

  //TextEditingController linkController = TextEditingController();

  //final databaseRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("İcbari Sigorta",
                      style: GoogleFonts.oswald(fontSize: 25)),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: regController,
                    decoration: InputDecoration(
                      labelText: 'Qeydiyyat şəhadətnaməsi nömrəsi',
                      labelStyle: GoogleFonts.oswald(fontSize: 20),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: numberController,
                    decoration: InputDecoration(
                      labelText: 'Dövlət qeydiyyat nişanı ',
                      labelStyle: GoogleFonts.oswald(fontSize: 20),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: finController,
                    decoration: InputDecoration(
                      labelText: 'Fin Nömrəsi ',
                      border: OutlineInputBorder(),
                      labelStyle: GoogleFonts.oswald(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: phoneControoler,
                    keyboardType: TextInputType.phone,

                    ///
                    decoration: InputDecoration(
                      labelText: 'Telefon nömrəsi',
                      border: OutlineInputBorder(),
                      labelStyle: GoogleFonts.oswald(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: mailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      labelStyle: GoogleFonts.oswald(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 50),

                  /* TextFormField(
                    controller: linkController,
                    decoration: InputDecoration(
                      labelText: 'Link', border: OutlineInputBorder(),
                      labelStyle: GoogleFonts.oswald(fontSize: 20),

                    ),
                  ), */

                  SizedBox(height: 50),
                  OutlinedButton.icon(
                    onPressed: () async {
                      if (regController.text.isNotEmpty &&
                          numberController.text.isNotEmpty &&
                          finController.text.isNotEmpty &&
                          phoneControoler.text.isNotEmpty &&
                          mailController.text.isNotEmpty) {
                        String carCertificateCode =
                            regController.text; // sonra elave olunan
                        String plateNumber =
                            numberController.text; // sonra elave olunan
                        String finCode =
                            finController.text; // sonra elave olunan
                        String mobilePhone =
                            phoneControoler.text; // sonra elave olunan
                        String email = mailController.text;

                        regController.clear();
                        numberController.clear();
                        finController.clear();
                        phoneControoler.clear();
                        mailController.clear();

                        Fluttertoast.showToast(
                            msg: "Tələbiniz qeydə alındı!.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 20.0);

                        DataPostModel data = submitdata(
                            plateNumber,
                            finCode,
                            carCertificateCode,
                            mobilePhone,
                            email) as DataPostModel;

                        setState(() {
                          _dataPostModel = data;
                          //  _link = linkController.text as Link;
                        });
                      }

                      /*if (regController.text.isNotEmpty &&
                          numberController.text.isNotEmpty &&
                          finController.text.isNotEmpty
                          && phoneControoler.text.isNotEmpty &&
                          mailController.text.isNotEmpty) {
                        //insertData(regController.text, numberController.text, finController.text, phoneControoler.text, mailController.text);
                        Map <String, dynamic> data = {
                          "regNumber": regController.text,
                          "carNumber": numberController.text,
                          "finNumber": finController.text,
                          "phone": phoneControoler.text,
                          "mail": mailController.text
                        };

                        /*FirebaseFirestore.instance.collection("information").add(
                            data);*/
                      } */
                    },
                    icon: const Icon(Icons.send),
                    label: const Text("Send",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
