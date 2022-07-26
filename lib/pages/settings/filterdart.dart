import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:notify/service/session_data_manager.dart';
import 'package:notify/utils/constant.dart';
import 'package:notify/widgets/app_bar.dart';

import '../../service/notification_data_manager.dart';
import '../login.dart';
import 'package:get/get.dart';

import 'GetXSwitchState.dart';
import 'GetXSwitchState2.dart';
import 'GetXSwitchState3.dart';



/*class Filters extends StatefulWidget {
  const Filters({Key? key}) : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {

  //final GetXSwitchState3 getXSwitchStateData = Get.put(GetXSwitchState3());
  //final GetXSwitchState2 getXSwitchStateMerchant = Get.put(GetXSwitchState2());

  bool allowDataNotifications = SessionDataManager.getAllowDataNotifications();
  //bool allowMerchantNotifications = SessionDataManager.getAllowMerchantNotifications();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: getAppBar2('Filters'),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: pageTopDecoration,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      GetBuilder<GetXSwitchState>(builder: (_) =>


                         /* Column(
                            children: [
                              const SizedBox(height: 20,),
                              ListTile(
                                onTap: () { },
                                leading: const Icon(CupertinoIcons.bell, color: primaryColor),
                                title: Text(
                                  'Data',
                                  style: textStyle2,
                                ),
                                trailing: SizedBox(
                                  width: 40,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child:
    /*CupertinoSwitch(
                                      trackColor: Colors.grey[300],
                                      activeColor: primaryColor,
                                      value:          //allowDataNotifications && getXSwitchStateData.isSwitcheded,
                                      onChanged: (value) {

                                       /* getXSwitchStateData.changeSwitchState3(value);

                                        setState(() {

                                          allowDataNotifications = value;


                                          SessionDataManager.setAllowBankNotifications(allowDataNotifications );

                                          CollectionReference userInfo = FirebaseFirestore.instance.collection('user_info');
                                          userInfo.doc(SessionDataManager.getUserId()).update({'allow_data_notifications': allowDataNotifications })
                                              .then((value) => ("filter updated"))
                                              .catchError((error) => ("Failed to update setting: $error"));

                                          if (allowDataNotifications) {
                                            NotificationDataManager.subscribeToTopic('data');
                                          } else {
                                            NotificationDataManager.unsubscribeFromTopic('data');
                                          } */



                                        });  */


                                    ),

                                  ),

                                ),

                              ),*/


                            ],
                          )






                      ),
                    ],
                  ),
                ),
                /*Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      GetBuilder<GetXSwitchState2>(builder: (_) =>

                          Column(
                            children: [

                              ListTile(
                                onTap: () {},
                                leading: const Icon(CupertinoIcons.bell, color: primaryColor),
                                title: Text(
                                  'Allow Merchant Notifications',
                                  style: textStyle2,
                                ),
                                trailing: SizedBox(
                                  width: 40,
                                  child: Transform.scale(
                                    scale: 0.8,
                                    child: CupertinoSwitch(
                                      trackColor: Colors.grey[300],
                                      activeColor: primaryColor,
                                      value: allowMerchantNotifications && getXSwitchStateMerchant.isSwitcheded,
                                      onChanged: (value) {

                                        getXSwitchStateMerchant.changeSwitchState2(value);

                                        setState(() {

                                          allowMerchantNotifications = value;


                                          SessionDataManager.setAllowMerchantNotifications(allowMerchantNotifications);

                                          CollectionReference userInfo = FirebaseFirestore.instance.collection('user_info');
                                          userInfo.doc(SessionDataManager.getUserId()).update({'allow_merchant_notifications': allowMerchantNotifications})
                                              .then((value) => ("setting updated"))
                                              .catchError((error) => ("Failed to update setting: $error"));

                                          if (allowMerchantNotifications) {
                                            NotificationDataManager.subscribeToTopic('merchant');
                                          } else {
                                            NotificationDataManager.unsubscribeFromTopic('merchant');
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),





                              ListTile(
                                onTap: () async {
                                  await FirebaseAuth.instance.signOut();
                                  Get.to(() => const Login());
                                },
                                leading: const Icon(Icons.logout_outlined, color: primaryColor),
                                title: Text(
                                  'Logout',
                                  style: textStyle2,
                                ),
                              ),



                            ],
                          )






                      ),
                    ],
                  ),
                ), */

                /* GetBuilder<GetXSwitchState>(builder: (_) =>

                  Column(
                    children: [
                      const SizedBox(height: 20,),
                      ListTile(
                        onTap: () { },
                        leading: const Icon(CupertinoIcons.bell, color: primaryColor),
                        title: Text(
                          'Allow Bank Notifications',
                          style: textStyle2,
                        ),
                        trailing: SizedBox(
                          width: 40,
                          child: Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              trackColor: Colors.grey[300],
                              activeColor: primaryColor,
                              value: allowBankNotifications  && getXSwitchStateBank.isSwitcheded,
                              onChanged: (value) {

                                setState(() {

                                  allowBankNotifications = value;
                                  getXSwitchStateBank.changeSwitchState(value);

                                  SessionDataManager.setAllowBankNotifications(allowBankNotifications );

                                  CollectionReference userInfo = FirebaseFirestore.instance.collection('user_info');
                                  userInfo.doc(SessionDataManager.getUserId()).update({'allow_bank_notifications': allowBankNotifications })
                                      .then((value) => ("setting updated"))
                                      .catchError((error) => ("Failed to update setting: $error"));

                                  if (allowBankNotifications) {
                                    NotificationDataManager.subscribeToTopic('bank');
                                  } else {
                                    NotificationDataManager.unsubscribeFromTopic('bank');
                                  }

                                });
                              },

                            ),

                          ),

                        ),

                      ),


                      ListTile(
                        onTap: () {},
                        leading: const Icon(CupertinoIcons.bell, color: primaryColor),
                        title: Text(
                          'Allow Merchant Notifications',
                          style: textStyle2,
                        ),
                        trailing: SizedBox(
                          width: 40,
                          child: Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              trackColor: Colors.grey[300],
                              activeColor: primaryColor,
                              value: allowMerchantNotifications && getXSwitchStateMerchant.isSwitcheded,
                              onChanged: (value) {

                                setState(() {

                                  allowMerchantNotifications = value;
                                  getXSwitchStateMerchant.changeSwitchState(value);

                                  SessionDataManager.setAllowMerchantNotifications(allowMerchantNotifications);

                                  CollectionReference userInfo = FirebaseFirestore.instance.collection('user_info');
                                  userInfo.doc(SessionDataManager.getUserId()).update({'allow_merchant_notifications': allowMerchantNotifications})
                                      .then((value) => ("setting updated"))
                                      .catchError((error) => ("Failed to update setting: $error"));

                                  if (allowMerchantNotifications) {
                                    NotificationDataManager.subscribeToTopic('merchant');
                                  } else {
                                    NotificationDataManager.unsubscribeFromTopic('merchant');
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),





                      ListTile(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Get.to(() => const Login());
                        },
                        leading: const Icon(Icons.logout_outlined, color: primaryColor),
                        title: Text(
                          'Logout',
                          style: textStyle2,
                        ),
                      ),



                    ],
                  )






              ), */

              ]
          ),
        ),
      ),
    );
  }
} */
