import 'package:get/get.dart';

class PasswordViewController extends GetxController{

  RxBool show=true.obs;

  void show_password(){
    show.value=!show.value;
  }
}