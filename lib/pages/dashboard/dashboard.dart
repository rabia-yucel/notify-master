import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notify/models/dashboard_notification_model.dart';
import 'package:notify/pages/dashboard/HomePage.dart';
import 'package:notify/pages/dashboard/MainPage.dart';
import 'package:notify/service/session_data_manager.dart';
import 'package:notify/utils/constant.dart';
import 'package:notify/widgets/app_bar.dart';
import 'package:share/share.dart';

// Dashboard with List View notifications

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  @override



  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: getAppBar3('Dashboard'),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
     return const MainPage();
  }
  /*
  getBody(BuildContext context) {
    return
      Container(
      height: double.infinity,
      width: double.infinity,
      decoration: pageTopDecoration,
      child: refreshableList(),
    );
  }
*/





}
