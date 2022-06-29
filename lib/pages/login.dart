import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notify/pages/otp_verification.dart';
import 'package:notify/service/session_data_manager.dart';
import 'package:notify/utils/constant.dart';
import 'package:notify/widgets/app_bar.dart';
import 'package:notify/widgets/inputwidget.dart';
import 'package:notify/widgets/pressedwidget.dart';

import 'dashboard/dashboard.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController();
  //TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = true;
  String countryCode = "+90";

  @override
  void initState() {
    super.initState();

    isLoggedIn();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: getAppBar('Login'),
      body: getBody(context),
    );
  }

  void isLoggedIn() {

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      // TODO log user action
      if (user != null) {
        SessionDataManager.setUserId(user.uid);
        SessionDataManager.setPhoneNumber(user.phoneNumber);
        Get.to(() => const Dashboard());
      }
    });

  }

  void _onCountryChange(CountryCode _countryCode) {
    countryCode = _countryCode.toString();
  }

  getBody(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: pageTopDecoration,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: size.height * 0.01),
            const Center(
                child: Image(
              image: AssetImage('assets/directlogo.png'),
              height: 60,
            )),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Phone Number',
                style: textStyle2,
              ),
            ),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: tertiaryColor.withOpacity(0.1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CountryCodePicker(
                      onChanged: _onCountryChange,
                      initialSelection: 'tr',
                      showCountryOnly: true,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: true,
                      favorite: const ['+90', 'tr'],

                    ),
                  ),
                  Expanded(child: numberInput('Phone', phoneController)),
                ],
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Password',
                style: textStyle2,
              ),
            ),
            input2(
                obscureText: isPasswordVisible,
                hintText: 'Password',
                prefix: CupertinoIcons.lock,
                controller: passwordController,
                suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        if (isPasswordVisible == true) {
                          isPasswordVisible = false;
                        } else {
                          isPasswordVisible = true;
                        }
                      });
                    },
                    icon: const Icon(CupertinoIcons.eye))),*/

            SizedBox(height: size.height * 0.08),
            customButton('Login', () async {
              SessionDataManager.setPhoneNumber(countryCode + phoneController.text);
              Get.to(() => const OTPVerification());
            }),
            SizedBox(height: size.height * 0.06),
          ]),
        ),
      ),
    );
  }
}
