import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../models/dashboard_notification_model.dart';
import '../../service/session_data_manager.dart';
import '../../utils/constant.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<DashboardNotificationsModel> dashboardNotificationsModelList = List<DashboardNotificationsModel>.empty(growable: true);


  @override

  void initState() {
    super.initState();

    // Get the token each time the application loads
    saveTokenValue();

    loadNotificationData();

  }
  Future<void> saveTokenValue() async {

    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();
    // Save the initial token to the database
    await saveTokenToDatabase(token!);
    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);

  }
  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    String userId = SessionDataManager.getUserId();

    CollectionReference userInfo = FirebaseFirestore.instance.collection('user_info');
    var userDoc = await userInfo.doc(userId).get();

    await FirebaseFirestore.instance
        .collection('user_info')
        .doc(userId)
        .update({
      'tokens': FieldValue.arrayUnion([token]),
    });
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(


      onRefresh: () { return loadNotificationData(); },
      color: primaryColor,

      /*child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),*/
      child: Container(
        child: buildNotificationList(),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: pageTopDecoration,

      ),


    );

  }
  ListView buildNotificationList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: dashboardNotificationsModelList.length,
      itemBuilder: (BuildContext context, int index) =>
          buildDashboardMessageNotifications(
            context,
            dashboardNotificationsModelList[index],
          ),
    );
  }

  Future<void> loadNotificationData() async {

   dashboardNotificationsModelList.clear();




    await FirebaseFirestore.instance
        .collection('user_notifications')
        .where('phone_number', isEqualTo: SessionDataManager.getPhoneNumber())
        .where('is_deleted', isEqualTo: false)
        .orderBy('instance_time', descending: false)
        .limitToLast(100)  //TODO will be refactored
        .get()
        .then((QuerySnapshot querySnapshotUN) {
      querySnapshotUN.docs.forEach((docUN) async {

        await FirebaseFirestore.instance
            .collection('notification_messages')
            .where('message_id', isEqualTo: docUN['message_id'])
            //.orderBy('instance_time', descending: false)
            .get()
            .then((QuerySnapshot querySnapshotNM) {
          querySnapshotNM.docs.forEach((docNM) async {

            DashboardNotificationsModel dashboardNotificationsModel =
            DashboardNotificationsModel(
             // id: docUN['id'],
              messageId: docUN['message_id'],
              avatar: docNM['avatar'],
              name: docNM['title'],
              instanceTime: docUN['instance_time'],
              image: docNM['image'],
              messageText: docNM['body'],
              isRead: docUN['is_read'],
              isDeleted: docUN['is_deleted'],
            );

            setState(() {
              dashboardNotificationsModelList.add(dashboardNotificationsModel);
              //dashboardNotificationsModelList.sort((a, b) => b.instanceTime.compareTo(a.instanceTime));
            });

          });
          dashboardNotificationsModelList.sort((a, b) => b.instanceTime.compareTo(a.instanceTime));
        });
      });
    });
   // dashboardNotificationsModelList.sort((a, b) => b.instanceTime.compareTo(a.instanceTime));

  }

  String showTimeDifference(DateTime dateTime) {
    String timeDifference = '';

    int inDays = DateTime.now().difference(dateTime).inDays;

    if (inDays < 1) {
      int inHours = DateTime.now().difference(dateTime).inHours;

      if (inHours < 1) {
        int inMinutes = DateTime.now().difference(dateTime).inMinutes;

        timeDifference = inMinutes.toString() + ' minutes ';

      } else {
        if (inHours == 1) {
          timeDifference = inHours.toString() + ' hour ';
        } else {
          timeDifference = inHours.toString() + ' hours ';
        }
      }

    } else {
      if (inDays == 1) {
        timeDifference = inDays.toString() + ' day ';
      } else {
        timeDifference = inDays.toString() + ' days ';
      }
    }

    return timeDifference + ' ago';
  }

  buildDashboardMessageNotifications(BuildContext context, DashboardNotificationsModel data) {
    return data.isDeleted == true
        ? Container()
        : Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0.4,
      shadowColor: primaryColor,
      child: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                             CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(data.avatar),
                              ),

                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.name,

                                    style: textStyle2.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    showTimeDifference(data.instanceTime.toDate()),
                                    style: textStyle3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              data.isRead == false
                                  ? Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: fourthColor,
                                    radius: 4,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'New',
                                    style: textStyle3.copyWith(
                                        color: primaryColor),
                                  ),
                                ],
                              )
                                  :
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Stack(
                                    children: const [
                                      Icon(
                                        Icons.check,
                                        size: 20,
                                        color: fifthColor,
                                      ),
                                      Positioned(
                                          left: 5,
                                          child: Icon(
                                            Icons.check,
                                            size: 20,
                                            color: fifthColor,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                data.instanceTime.toDate().toString().substring(0, 10),
                                style: textStyle3,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      data.image != ''
                          ? Image(image: NetworkImage(data.image))
                          : Container(),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SelectableText(
                            data.messageText,
                            style: textStyle2.copyWith(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: tertiaryColor)),
                        child: IconButton(
                          onPressed: () { updateNotificationAsDeleted(data); },
                          icon: const Icon(
                            CupertinoIcons.delete,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: tertiaryColor)),
                        child: IconButton(
                          onPressed: () {
                            _onShare(context, data.messageText);
                          },
                          icon: const Icon(
                            CupertinoIcons.share,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      data.isRead == true
                          ? Container()
                          : Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: tertiaryColor)),
                        child: IconButton(
                          onPressed: () { updateNotificationAsRead(data);  },
                          icon: const Icon(
                            CupertinoIcons.check_mark,
                            color: primaryColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),


            ),

          ],
        ),
      ),
    );
  }

  Future<void> updateNotificationAsDeleted(DashboardNotificationsModel data) async {

    await FirebaseFirestore.instance.collection('user_notifications')
        .where('phone_number', isEqualTo: SessionDataManager.getPhoneNumber())
        .where('message_id', isEqualTo: data.messageId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({'is_deleted': true, 'update_time' : DateTime.now()});
      });
    });

    setState(() {
      data.isDeleted = true;
    });
  }

  Future<void> updateNotificationAsRead(DashboardNotificationsModel data) async {

    await FirebaseFirestore.instance.collection('user_notifications')
        .where('phone_number', isEqualTo: SessionDataManager.getPhoneNumber())
        .where('message_id', isEqualTo: data.messageId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.update({'is_read': true, 'update_time' : DateTime.now()});
      });
    });

    setState(() {
      data.isRead = true;
    });

  }

  _onShare(BuildContext context, String shareText) async {
    await Share.share(shareText);
  }



}
