


import 'package:barcode_scan2/barcode_scan2.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constant.dart';



class BarcodeDb extends StatefulWidget {
  const BarcodeDb({Key? key}) : super(key: key);

  @override
  State<BarcodeDb> createState() => _BarcodeDbState();
}

class _BarcodeDbState extends State<BarcodeDb> {
  String qrData = "";
  var data;
  bool hasdata = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      /*appBar: AppBar(
        backgroundColor: Colors.teal.shade300,
        title: const Text("QR Code Reader"
        ),
        centerTitle: true,
      ), */
      body:
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Lottie.asset("assets/lottie/68692-qr-code-scanner.json",width: 155),
            SizedBox(height: 25,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Flexible(child: TextButton(
                  onPressed: hasdata ? () async {
                    if (await canLaunch(qrData)) {
                    print(qrData);
                    await launch(qrData);
                    } else {
                    throw 'Could not launch ';
                    }
                  } : null,
                  child:Text(
                    " ${(qrData)}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
                  )
                )),

              ],
            ),
            const SizedBox(height: 15,),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              ),
              onPressed: () async {
                var options = const ScanOptions(
                  autoEnableFlash: false,
                );
                var data = await BarcodeScanner.scan(options: options);
                setState(() {
                  qrData = data.rawContent.toString();
                  hasdata = true;
                });
              },
              child: Text('Scan'),
            ),


            const SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}


