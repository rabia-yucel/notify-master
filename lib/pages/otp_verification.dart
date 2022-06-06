import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notify/service/session_data_manager.dart';
import 'package:notify/utils/constant.dart';
import 'package:notify/widgets/app_bar.dart';
import 'package:notify/widgets/pressedwidget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({Key? key}) : super(key: key);

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  String _verificationId = "";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();

    verifyUser();

  }

  Future verifyUser() async {

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: SessionDataManager.getPhoneNumber(),
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        //print('sms verified');
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') { // TODO for debug purposes
          //print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        // TODO implement codesent
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // TODO implement timeout
      },
    );

  }


  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
        backgroundColor: primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getAppBar2('Verification'),
      backgroundColor: primaryColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: pageTopDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'Please wait until you receive the SMS \nwith the OTP code.',
                  textAlign: TextAlign.center,
                  style: textStyle2,
                ),
              ),
              SizedBox(height: size.height * 0.06),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 2),
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: secondaryColor,
                      ),
                      length: 6,
                      obscureText: true,
                      obscuringCharacter: '•',
                      // textStyle: style3.copyWith(
                      //     fontWeight: FontWeight.w900,
                      //     fontSize: 20,
                      //     color: secondaryColor.withOpacity(0.5)),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 3) {
                          return null;
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12),
                        fieldHeight: 55,
                        fieldWidth: 45,
                        borderWidth: 0.0,
                        activeFillColor: secondaryColor.withOpacity(0.1),
                        // inactiveColor: secondaryColor,
                        inactiveFillColor: Colors.grey,
                        selectedColor: secondaryColor,
                        disabledColor: secondaryColor,
                      ),
                      //backgroundColor: secondaryColor,
                      cursorColor: primaryColor,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,

                      onCompleted: (v) {
                        if (kDebugMode) {
                          print("Completed");
                        }
                      },
                      onTap: () {
                        if (kDebugMode) {
                          //print("Pressed");
                        }
                      },
                      onChanged: (value) {
                        if (kDebugMode) {
                          //print(value);
                        }
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        if (kDebugMode) {
                          //print("Allowing to paste $text");
                        }
                        return true;
                      },
                    )),
              ),
              SizedBox(height: size.height * 0.03),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I don't receive code!",
                    style: textStyle2,
                  ),
                  SizedBox(
                    width: 101,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Please resend",
                        style: textStyle2.copyWith(
                            fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Resend code in ",
                    style: textStyle3,
                  ),
                  Text(
                    "60s",
                    style: textStyle2.copyWith(color: fourthColor,fontWeight: FontWeight.bold),
                  ),
                ],
              ),*/
              SizedBox(height: size.height * 0.06),
              customButton('Verify', () async {
                //Get.to(const DashBoardOne());
                //Get.to(const DashBoardTwo());
                formKey.currentState!.validate();
                // conditions for validating
                if (currentText.length != 6) {
                  errorController!.add(ErrorAnimationType
                      .shake); // Triggering error shake animation
                  setState(() {
                    hasError = true;
                  });
                } else {

                  bool isVerified = await verifyOTP(currentText);

                  if (isVerified == true) {
                    snackBar("OTP Verified!");
                  } else {
                    setState((){
                      hasError = true;
                      },
                    );
                  }

                }
              }),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> verifyOTP(String pinText) async {
    bool isVerified = false;

    try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: _verificationId, smsCode: pinText);

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        User? user = userCredential.user;

        if (user != null) {

          CollectionReference userInfo = FirebaseFirestore.instance.collection('user_info');
          var userDoc = await userInfo.doc(user.uid).get();

          var currentTime = DateTime.now();

          if (!userDoc.exists) {

              userInfo.doc(user.uid).set(
                  {
                    'user_id': user.uid,
                    'user_name': user.phoneNumber,
                    'user_icon': "",
                    'phone_number': user.phoneNumber,
                    'allow_merchant_notifications': true,
                    'allow_bank_notifications': true,
                    'instance_time': currentTime,
                    'update_time': currentTime,
                    'status': 'active',
                    'last_login_time': currentTime,
                  })
                  .then((value) => print("User Added"))
                  .catchError((error) =>
                  print("Failed to add user: $error"));

                 SessionDataManager.setAllowBankNotifications(true);
                 SessionDataManager.setAllowMerchantNotifications(true);

            } else{
              userInfo.doc(user.uid).update({'last_login_time': currentTime})
                  .then((value) => print("User Updated"))
                  .catchError((error) => print("Failed to update user: $error"));

              SessionDataManager.setAllowBankNotifications(userDoc.get('allow_bank_notifications'));
              SessionDataManager.setAllowMerchantNotifications(userDoc.get('allow_merchant_notifications'));
            }

            SessionDataManager.setUserId(user.uid);
            SessionDataManager.setPhoneNumber(user.phoneNumber);
            isVerified = true;
        }
      } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // TODO handle the error here
          }
          else if (e.code == 'invalid-credential') {
            // TODO handle the error here
          }
      } catch (e) {
          // TODO handle the error here
      }

      return isVerified;
  }
}
