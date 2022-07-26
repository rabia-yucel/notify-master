import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class GetXSwitchState3 extends GetxController{


  var isSwitcheded = false;


  final switchdatacontroller = GetStorage();

  GetXSwitchState3(){
    print("Constructor called");

    if(switchdatacontroller.read('getXIsSwitched3') != null){
      isSwitcheded = switchdatacontroller.read('getXIsSwitched3');
      update();
    }

  }
  // called when user click on switch to on/off it
  changeSwitchState3(bool value3){

    isSwitcheded = value3;


    switchdatacontroller.write('getXIsSwitched3', isSwitcheded);


    update();
  }
}