import 'package:flutter/material.dart';

import '../../utils/constant.dart';
import '../Barcode/BarcodePage.dart';
import '../Insurance/InsurancePage.dart';
import 'HomePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages =[
    const HomePage(),
    const InsurancePage(),
    const BarcodePage(),
    //const MyPage(),
  ];

  int currentIndex = 0;

  void onTap( int index){
    setState((){
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        //unselectedFontSize: 0,
       // selectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryColor,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        //showSelectedLabels: true,
       // showUnselectedLabels: true,
        elevation: 0,

        items: const [
          BottomNavigationBarItem(label: ("Home") ,icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: ("Insurance") ,icon: Icon(Icons.work)),
          BottomNavigationBarItem(label: ("Qr Scan") ,icon: Icon(Icons.search)),
          //BottomNavigationBarItem(label: ("MyPage") ,icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
