import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class GetXSwitchState2 extends GetxController{


  var isSwitcheded = false;


  final switchdatacontroller = GetStorage();

  GetXSwitchState2(){
    print("Constructor called");

    if(switchdatacontroller.read('getXIsSwitched2') != null){
      isSwitcheded = switchdatacontroller.read('getXIsSwitched2');
      update();
    }

  }
  // called when user click on switch to on/off it
  changeSwitchState2(bool value2){

    isSwitcheded = value2;


    switchdatacontroller.write('getXIsSwitched2', isSwitcheded);


    update();
  }
}