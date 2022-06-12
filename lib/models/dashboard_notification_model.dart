import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardNotificationsModel {
  String messageId;
  String avatar;
  String name;
  Timestamp instanceTime;
  String image;
  String messageText;
  bool isRead;
  bool isDeleted;
 // int id;

  DashboardNotificationsModel({
    required this.messageId,
    required this.avatar,
    required this.name,
    required this.instanceTime,
    required this.image,
    required this.messageText,
    required this.isRead,
    required this.isDeleted,
   // required this.id,
  });
}

/* TODO will be removed
class DashBoardNotificationsList {
  static List<DashboardNotificationsModel> list = [
    DashboardNotificationsModel(
      avatar:
      'https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      name: 'Jas Dao',
      date: '5 mins ago',
      timeAgo: '5 mins ago',
      imagePath: 'https://images.unsplash.com/photo-1642957323739-5632d8a2ff3d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
      messageText:
      'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC,',
      isRead: false,
    ),
    DashboardNotificationsModel(
      avatar:
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      name: 'Sams Bat',
      timeAgo: '10 mins ago',
      imagePath: 'https://images.unsplash.com/photo-1642986952655-4367c9d96514?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2MHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
      messageText:
      'Wish you all a Merry Christmas and a Happy Ne A handy Lorem Ipsum Generator that helps to create dummy text for all layout needs.',
      isRead: false,
    ),
    DashboardNotificationsModel(
      avatar:
      'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjl8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      name: 'Danial Dao',
      timeAgo: '10 mins ago',
      imagePath: '',
      messageText:
      'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
      isRead: false,
    ),
    DashboardNotificationsModel(
      avatar:
      'https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTF8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      name: 'Jatta Rao',
      timeAgo: '10 mins ago',
      imagePath: '',
      messageText:
      'Wish you all a Merry Christmas and a Happy Ne A handy Lorem Ipsum Generator that helps to create dummy text for all layout needs.',
      isRead: false,
    ),
    DashboardNotificationsModel(
      avatar:
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTN8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      name: 'Aleena Dk',
      timeAgo: '12 mins ago',
      imagePath: 'https://images.unsplash.com/photo-1642957325322-10f21662f462?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2M3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
      messageText:
      'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
      isRead: true,
    ),
    DashboardNotificationsModel(
      avatar:
      'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OTR8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      name: 'Sams Bat',
      timeAgo: '12 mins ago',
      imagePath: 'https://images.unsplash.com/photo-1642851401285-9e0b2aee43cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNDV8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
      messageText:
      'Wish you all a Merry Christmas and a Happy Ne A handy Lorem Ipsum Generator that helps to create dummy text for all layout needs.',
      isRead: true,
    ),
    DashboardNotificationsModel(
      avatar:
      'https://images.unsplash.com/photo-1618641986557-1ecd230959aa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      name: 'Jas Dao',
      timeAgo: '12 mins ago',
      imagePath: '',
      messageText:
      'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
      isRead: true,
    ),
    DashboardNotificationsModel(
      avatar:
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      name: 'Sams Bat',
      timeAgo: '30 mins ago',
      imagePath: 'https://images.unsplash.com/photo-1642957323739-5632d8a2ff3d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOXx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
      messageText:
      'Wish you all a Merry Christmas and a Happy Ne A handy Lorem Ipsum Generator that helps to create dummy text for all layout needs.',
      isRead: true,
    ),
    DashboardNotificationsModel(
      avatar:
      'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjl8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      name: 'Jas Dao',
      timeAgo: '30 mins ago',
      imagePath: 'https://images.unsplash.com/photo-1642986952655-4367c9d96514?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2MHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
      messageText:
      'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
      isRead: true,
    ),
    DashboardNotificationsModel(
      avatar:
      'https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTF8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      name: 'Sams Bat',
      timeAgo: '32 mins ago',
      imagePath: '',
      messageText:
      'Wish you all a Merry Christmas and a Happy Ne A handy Lorem Ipsum Generator that helps to create dummy text for all layout needs.',
      isRead: true,
    ),
    DashboardNotificationsModel(
      avatar:
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTN8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      name: 'Jas Dao',
      timeAgo: '34 mins ago',
      imagePath: '',
      messageText:
      'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type',
      isRead: true,
    ),
    DashboardNotificationsModel(
      avatar:
      'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OTR8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
      name: 'Sams Bat',
      timeAgo: '34 mins ago',
      imagePath: 'https://images.unsplash.com/photo-1642957325322-10f21662f462?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2M3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
      messageText:
      'Wish you all a Merry Christmas and a Happy Ne A handy Lorem Ipsum Generator that helps to create dummy text for all layout needs.',
      isRead: true,
    ),
  ];
}
*/
