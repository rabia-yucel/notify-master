

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';
//import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clipboard/clipboard.dart';
import 'package:notify/pages/ScanPhoto/Widget/textArea.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';


import '../../../utils/constant.dart';
import 'DataPostModelOcr.dart';

class PhotoOCR extends StatefulWidget {
  const PhotoOCR({Key? key}) : super(key: key);

  @override
  State<PhotoOCR> createState() => _PhotoOCRState();
}

Future<DataPostModelOcr?> submitdata(String textt) async{

  var response = await http.post(Uri.parse("http://fursetbufurset.com/TestOCR/SendOCRText?text=$textt"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json" },
      body:json.encode(
          {
            "textt": textt,

          }
      )

  );
  var data =  response.body;
  print(data);

  if(response.statusCode == 200){
    String responseString = response.body;
    dataPostModelOcrFromJson(responseString);

  }
  else {
    return null;
  }




}



class _PhotoOCRState extends State<PhotoOCR> {
  late DataPostModelOcr _dataPostModelOcr;

  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  late final InputImage inputImage;

  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (textScanning) const CircularProgressIndicator(),
                    if (!textScanning && imageFile == null)
                      Container(
                        width: 300,
                        height: 300,
                        color: Colors.grey[300]!,
                      ),
                    if (imageFile != null) Image.file(File(imageFile!.path)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.grey,
                                shadowColor: Colors.grey[400],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              onPressed: () {
                                getImage(ImageSource.gallery);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.image,
                                      size: 30,
                                      color: primaryColor,
                                    ),
                                    Text(
                                      "Gallery",
                                      style: TextStyle(
                                          fontSize: 13, color: primaryColor),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.grey,
                                shadowColor: Colors.grey[400],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              onPressed: () {
                                getImage(ImageSource.camera);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                      color: primaryColor,
                                    ),
                                    Text(
                                      "Camera",
                                      style: TextStyle(
                                          fontSize: 13, color: primaryColor),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.grey,
                                shadowColor: Colors.grey[400],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),

                              onPressed: () async {


                                  String textt = scannedText.toString();
                                  DataPostModelOcr data = await submitdata (textt) as DataPostModelOcr;

                                  setState((){
                                    _dataPostModelOcr = data ;

                                  });




                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(
                                      Icons.send_outlined,
                                      size: 30,
                                      color: primaryColor,
                                    ),
                                    Text(
                                      "Send",
                                      style: TextStyle(
                                          fontSize: 13, color: primaryColor),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        /* Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.grey,
                                shadowColor: Colors.grey[400],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                              onPressed: () {

                                  setState((){
                                    imageFile?.path ;
                                  });

                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.clear_outlined,
                                      size: 30,
                                    ),
                                    Text(
                                      "Clear",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                              ),
                            )), */
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextArea(text: scannedText,
                      onClickedCopy: copyToClipboard,

                    ),
                    /* Container(
                      child: Text(
                        scannedText,
                        style: TextStyle(fontSize: 20),
                      ),
                    )*/



                  ],
                )),
          )),
    );
  }



  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {

    final inputImage = InputImage.fromFilePath(image.path);
    //final textDetector = GoogleMlKit.vision.textRecognizer();
    //final textDetector =
    //RecognizedText recognizedText = await textDetector.processImage(inputImage); // RecognisedText
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    scannedText = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textScanning = false;

    setState(() {});
  }



  void copyToClipboard(){
    if(scannedText.trim() !=''){
      FlutterClipboard.copy(scannedText);
    }

  }

  @override
  void initState() {
    super.initState();
  }
}


