import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class GetXSwitchState extends GetxController{


  var isSwitcheded = false;


  final switchdatacontroller = GetStorage();

  GetXSwitchState(){
    print("Constructor called");

    if(switchdatacontroller.read('getXIsSwitched') != null){
      isSwitcheded = switchdatacontroller.read('getXIsSwitched');
      update();
    }

  }
  // called when user click on switch to on/off it
  changeSwitchState(bool value){

    isSwitcheded = value;


    switchdatacontroller.write('getXIsSwitched', isSwitcheded);


    update();
  }
}