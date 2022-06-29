import 'package:flutter/material.dart';
import 'package:notify/utils/constant.dart';


import 'RealTimeDb/İnsertDb.dart';

class InsurancePage extends StatelessWidget {
  const InsurancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RealTimeDbInsert();

   // return const DataFutureModel();

    /*Scaffold(

      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20.0),
            primary: primaryColor,

          ),
          child: Text("Məlumat Artır",style: TextStyle(fontSize: 20),),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RealTimeDbInsert()),
            );
          },
        ),
      ),
    ); */

  }
}
